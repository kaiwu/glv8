import app/plv8
import gleam/dynamic/decode
import gleeunit/should
import glv8/util

pub fn rec_test() {
  let decoder = {
    use i <- decode.field("i", decode.int)
    use t <- decode.field("t", decode.string)
    decode.success(plv8.Rec(i: i, t: t))
  }
  plv8.scalar_to_record(42, "hi")
  |> util.from
  |> decode.run(decoder)
  |> should.equal(Ok(plv8.Rec(42, "hi")))
}

pub fn nil_test() {
  util.check_nil(Nil)
  |> should.equal(False)

  util.check_nil(False)
  |> should.equal(False)

  util.check_nil(0)
  |> should.equal(False)

  util.check_nil("")
  |> should.equal(False)

  util.check_nil(True)
  |> should.equal(True)

  util.check_nil(1)
  |> should.equal(True)

  util.check_nil(util.object())
  |> should.equal(True)
}
