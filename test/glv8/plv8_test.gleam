import app/plv8
import gleam/dynamic
import gleam/javascript
import gleam/result
import gleeunit/should
import glv8/util

pub fn object_test() {
  let f = fn(a) { a + 1 }

  util.object()
  |> util.merge("f", f)
  |> util.get("f")
  |> result.map(javascript.type_of)
  |> should.equal(Ok(javascript.FunctionType))
}

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
