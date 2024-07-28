//// the module implements some plv8 examples
////

import gleam/bool
import gleam/javascript/array.{type Array}
import gleam/json
import gleam/list
import gleam/result
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
    Error(glv8.DBErrorMessage(m)) -> elog_notice(m)
    Ok(_) -> elog_notice("should not come here")
    _ -> Nil
  }
}

pub type Rec {
  Rec(i: Int, t: String)
}

pub fn scalar_to_record(i: Int, t: String) -> Rec {
  Rec(i, t)
}
