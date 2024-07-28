import app/plv8
import gleam/dynamic
import gleeunit/should

pub fn rec_test() {
  plv8.scalar_to_record(42, "hi")
  |> dynamic.from
  |> dynamic.decode2(
    plv8.Rec,
    dynamic.field("i", dynamic.int),
    dynamic.field("t", dynamic.string),
  )
  |> should.equal(Ok(plv8.Rec(42, "hi")))
}
