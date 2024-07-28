//// the module implements some plv8 examples
////

import gleam/bool
import gleam/dynamic
import gleam/javascript/array.{type Array}
import gleam/json
import gleam/list
import gleam/result
import gleam/string
import glv8
import glv8/database
import glv8/util.{elog_notice}

pub fn plv8_test(keys ka: Array(String), values va: Array(String)) -> String {
  // list.zip(ka |> array.to_list, va |> array.to_list)
  // |> list.map(fn(t) { #(t.0, json.string(t.1)) })
  // |> json.object
  // |> json.to_string

  array.fold(ka, #(0, []), fn(t, k) {
    let kv = #(k, array.get(va, t.0))
    #(t.0 + 1, [kv, ..t.1])
  }).1
  |> list.map(fn(t) {
    #(t.0, case t.1 {
      Error(Nil) -> json.null()
      Ok(x) -> json.string(x)
    })
  })
  |> json.object
  |> json.to_string
}

pub fn catch_sql_error() -> Nil {
  let r = database.execute("throw SQL error", Nil)
  use <- bool.guard(result.is_ok(r), Nil)

  case r {
    Error(glv8.DBErrorJson(j)) -> elog_notice(j |> json.to_string)
    _ -> elog_notice("should not come here")
  }
}

pub fn catch_sql_error2() -> String {
  let rs = database.execute_as("throw SQL error", Nil, dynamic.string)
  let fold = fn(rx) { array.fold(rx, "", string.append) }

  use <- bool.guard(
    when: result.is_ok(rs),
    return: result.map(rs, fold) |> result.unwrap(""),
  )

  rs
  |> result.try_recover(fn(e) {
    let _ = elog_notice(e |> glv8.error_to_string)
    database.execute_as(
      "select 'and execute queries again' t",
      Nil,
      dynamic.field("t", dynamic.string),
    )
  })
  |> result.map(fold)
  |> result.unwrap("")
}

pub type Rec {
  Rec(i: Int, t: String)
}

pub fn set_of_records() -> Array(Rec) {
  [Rec(1, "a"), Rec(2, "b"), Rec(3, "c")]
  |> array.from_list
}

pub fn set_of_integers() -> Array(Int) {
  [1, 2, 3]
  |> array.from_list
}

pub fn scalar_to_record(i: Int, t: String) -> Rec {
  Rec(i, t)
}

pub fn fastsum(arr: Array(Int)) -> Int {
  array.fold(arr, 0, fn(s, e) { s + e })
}

pub fn return_sql() -> Array(Rec) {
  let decode =
    dynamic.decode2(
      Rec,
      dynamic.field("i", dynamic.int),
      dynamic.field("t", dynamic.string),
    )
  database.execute_as(
    "SELECT i, $1 || i AS s FROM generate_series(1, $2) as t(i)",
    #("s", 4),
    decode,
  )
  |> result.unwrap([] |> array.from_list)
}
