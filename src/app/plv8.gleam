//// the module implements some plv8 examples
////

import gleam/bool
import gleam/dynamic
import gleam/javascript/array.{type Array}
import gleam/dict
import gleam/json
import gleam/list
import gleam/result
import gleam/string
import glv8.{type Record}
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
    Error(glv8.DBErrorMessage(m)) -> elog_notice(m)
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

pub fn scalar_to_record(i: Int, t: String) -> Record {
  [#("i", i |> json.int), #("t", t |> json.string)]
  |> dict.from_list
}
