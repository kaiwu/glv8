import gleam/dynamic.{type Dynamic}
import gleam/javascript/array.{type Array}
import gleam/dynamic/decode.{type Decoder}
import gleam/result
import glv8.{type DBError, type DecodeErrors}

pub type Row {
  Row
  NilRow(Nil)
}

pub type PreparedPlan

pub type Cursor


pub type SubTransaction =
  fn() -> Nil

///
///
///
pub fn shift(rs: Result(Array(a), DBError)) -> Result(#(a, Array(a)), DBError) {
  rs
  |> result.try(fn(rx) {
    case array.to_list(rx) {
      [f, ..t] -> Ok(#(f, array.from_list(t)))
      [] -> Error(glv8.DBError(Nil))
    }
  })
}

///
///
///
pub fn shift_as(
  rs: Result(Array(a), DBError),
  decoder f: fn(Dynamic) -> Result(b, DecodeErrors),
) -> Result(b, DBError) {
  shift(rs)
  |> result.try(fn(t) {
    t.0
    |> dynamic.from
    |> f
    |> result.map_error(glv8.DBErrorDecode(_))
  })
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "execute")
pub fn execute0(query q: String, parameters p: p) -> Result(Int, DBError)

///
///
///
@external(javascript, "../glv8_ffi.mjs", "execute")
pub fn execute(query q: String, parameters p: p) -> Result(Array(Row), DBError)

///
///
///
pub fn decode(
  rows rs: Array(Row),
  decoder f: Decoder(a),
) -> Result(Array(a), DBError) {
  rs
  |> array.to_list
  |> dynamic.from
  |> decode.run(decode.list(f))
  |> result.map(array.from_list(_))
  |> result.map_error(glv8.DBErrorDecode(_))
}

///
///
///
pub fn execute_as(
  query q: String,
  parameters p: p,
  of f: Decoder(a),
) -> Result(Array(a), DBError) {
  execute(q, p)
  |> result.try(decode(_, f))
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "prepare")
pub fn prepare(query q: String, paremeters p: Array(String)) -> PreparedPlan

///
///
///
@external(javascript, "../glv8_ffi.mjs", "plan_execute")
pub fn plan_execute(
  plan pl: PreparedPlan,
  parameters p: p,
) -> Result(Array(Row), DBError)

///
///
///
pub fn plan_execute_as(
  plan pl: PreparedPlan,
  parameters p: p,
  of f: Decoder(a),
) -> Result(Array(a), DBError) {
  plan_execute(pl, p)
  |> result.try(decode(_, f))
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "plan_free")
pub fn plan_free(plan pl: PreparedPlan) -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "plan_cursor")
pub fn plan_cursor(plan pl: PreparedPlan, parameters p: p) -> Cursor

///
///
///
@external(javascript, "../glv8_ffi.mjs", "cursor_fetch")
pub fn cursor_fetch(cursor c: Cursor) -> Result(Row, DBError)

///
///
///
pub fn decode0(
  row r: Row,
  decoder f: fn(Dynamic) -> Result(a, DecodeErrors),
) -> Result(a, DBError) {
  r
  |> dynamic.from
  |> f
  |> result.map_error(glv8.DBErrorDecode(_))
}

///
///
///
pub fn cursor_fetch_as(
  cursor c: Cursor,
  of f: fn(Dynamic) -> Result(a, DecodeErrors),
) -> Result(a, DBError) {
  cursor_fetch(c)
  |> result.try(decode0(_, f))
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "cursor_fetch_rows")
pub fn cursor_fetch_rows(
  cursor c: Cursor,
  rows n: Int,
) -> Result(Array(Row), DBError)

///
///
///
pub fn cursor_fetch_rows_as(
  cursor c: Cursor,
  rows n: Int,
  of f: Decoder(a),
) -> Result(Array(a), DBError) {
  cursor_fetch_rows(c, n)
  |> result.try(decode(_, f))
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "cursor_move")
pub fn cursor_move(cursor c: Cursor, rows n: Int) -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "cursor_close")
pub fn cursor_close(cursor c: Cursor) -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "subtransaction")
pub fn subtransaction(transaction t: SubTransaction) -> Result(Nil, DBError)
