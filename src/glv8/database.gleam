// import gleam/dynamic
import gleam/javascript/array.{type Array}

pub type Row {
  Row
}

pub type PreparedPlan
pub type Cursor
pub type SubTransaction = fn() -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "execute")
pub fn execute(query q: String, parameters p: p) -> Array(Row)

///
///
///
@external(javascript, "../glv8_ffi.mjs", "prepare")
pub fn prepare(query q: String, paremeters p: Array(String)) -> PreparedPlan

///
///
///
@external(javascript, "../glv8_ffi.mjs", "plan_execute")
pub fn plan_execute(plan pl: PreparedPlan, parameters p: p) -> Array(Row)

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
pub fn cursor_fetch(cursor c: Cursor) -> Row

///
///
///
@external(javascript, "../glv8_ffi.mjs", "cursor_fetch_rows")
pub fn cursor_fetch_rows(cursor c: Cursor, rows n: Int) -> Array(Row)

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
pub fn subtransaction(transaction t: SubTransaction) -> Result(Nil, String)


