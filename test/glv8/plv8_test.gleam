import app/plv8
import bundle
import gleam/dynamic
import gleam/javascript
import gleam/result
import gleeunit/should
import glv8/util

// import gleam/io

pub fn object_test() {
  util.object()
  |> util.merge(util.name(plv8.fastsum), plv8.fastsum)
  |> util.get("fastsum")
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

pub fn bundle_test() {
  bundle.exports()
  |> util.get("fastsum")
  |> result.map(javascript.type_of)
  |> should.equal(Ok(javascript.FunctionType))
}
