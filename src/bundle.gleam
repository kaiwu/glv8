import app/plv8
import glv8.{type JsObject}
import glv8/util.{name}

pub fn exports() -> JsObject {
  util.object()
  |> util.merge(name(plv8.plv8_test), plv8.plv8_test)
  |> util.merge(name(plv8.catch_sql_error), plv8.catch_sql_error)
  |> util.merge(name(plv8.catch_sql_error2), plv8.catch_sql_error2)
  |> util.merge(name(plv8.scalar_to_record), plv8.scalar_to_record)
  |> util.merge(name(plv8.set_of_records), plv8.set_of_records)
  |> util.merge(name(plv8.set_of_integers), plv8.set_of_integers)
  |> util.merge(name(plv8.fastsum), plv8.fastsum)
  |> util.merge(name(plv8.return_sql), plv8.return_sql)
}
