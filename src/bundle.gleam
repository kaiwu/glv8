import app/plv8
import glv8.{type JsObject}
import glv8/util

pub fn exports() -> JsObject {
  util.object()
  |> util.merge("plv8_test", plv8.plv8_test)
  |> util.merge("catch_sql_error", plv8.catch_sql_error)
  |> util.merge("catch_sql_error2", plv8.catch_sql_error2)
  |> util.merge("scalar_to_record", plv8.scalar_to_record)
  |> util.merge("set_of_records", plv8.set_of_records)
  |> util.merge("set_of_integers", plv8.set_of_integers)
  |> util.merge("fastsum", plv8.fastsum)
  |> util.merge("return_sql", plv8.return_sql)
}
