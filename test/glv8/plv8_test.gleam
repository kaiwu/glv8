import app/plv8
import gleam/dynamic
import gleeunit/should
import glv8/util

pub fn rec_test() {
  plv8.scalar_to_record(42, "hi")
  |> util.to_json
  |> dynamic.from
  |> fn(d) {
    let id = dynamic.field("i", dynamic.int)
    let td = dynamic.field("t", dynamic.string)
    #(id(d), td(d))
  }
  |> should.equal(#(Ok(42), Ok("hi")))
}
