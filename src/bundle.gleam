import app/plv8
import glv8.{type JsObject}
import glv8/util.{export}

pub fn exports() -> JsObject {
  util.object()
  |> export(plv8.plv8_test)
  |> export(plv8.catch_sql_error)
  |> export(plv8.catch_sql_error2)
  |> export(plv8.scalar_to_record)
  |> export(plv8.set_of_records)
  |> export(plv8.set_of_integers)
  |> export(plv8.fastsum)
  |> export(plv8.return_sql)
}

pub fn sqls() -> List(String) {
  ["./app/app.sql"]
}
