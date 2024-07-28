import gleam/javascript.{type Symbol, get_symbol}
import gleam/json.{type Json}
import glv8.{
  type Function0, type Function1, type Function2, type Function3, type Function4,
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "json")
pub fn to_json(a: a) -> Json

///
///
///
@external(javascript, "../glv8_ffi.mjs", "info")
pub fn info() -> Json

///
///
///
@external(javascript, "../glv8_ffi.mjs", "reset")
pub fn reset(context ctx: String) -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "reset_all")
pub fn reset_all() -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "version")
pub fn version() -> String

///
///
///
@external(javascript, "../glv8_ffi.mjs", "memory_usage")
pub fn memory_usage() -> Json

///
///
///
@external(javascript, "../glv8_ffi.mjs", "elog")
pub fn elog(level l: Symbol, message m: String) -> Nil

///
///
///
pub fn elog_debug5(message m: String) -> Nil {
  elog(get_symbol("DEBUG5"), m)
}

///
///
///
pub fn elog_debug4(message m: String) -> Nil {
  elog(get_symbol("DEBUG4"), m)
}

///
///
///
pub fn elog_debug3(message m: String) -> Nil {
  elog(get_symbol("DEBUG3"), m)
}

///
///
///
pub fn elog_debug2(message m: String) -> Nil {
  elog(get_symbol("DEBUG2"), m)
}

///
///
///
pub fn elog_debug1(message m: String) -> Nil {
  elog(get_symbol("DEBUG1"), m)
}

///
///
///
pub fn elog_log(message m: String) -> Nil {
  elog(get_symbol("LOG"), m)
}

///
///
///
pub fn elog_info(message m: String) -> Nil {
  elog(get_symbol("INFO"), m)
}

///
///
///
pub fn elog_notice(message m: String) -> Nil {
  elog(get_symbol("NOTICE"), m)
}

///
///
///
pub fn elog_warning(message m: String) -> Nil {
  elog(get_symbol("WARNING"), m)
}

///
///
///
pub fn elog_error(message m: String) -> Nil {
  elog(get_symbol("ERROR"), m)
}

///
///
///
@external(javascript, "../glv8_ffi.mjs", "run_script")
pub fn run_script(script s: String, file f: String) -> Nil

///
///
///
@external(javascript, "../glv8_ffi.mjs", "find_function")
pub fn find_function0(function f: String) -> Function0(r)

///
///
///
@external(javascript, "../glv8_ffi.mjs", "find_function")
pub fn find_function1(function f: String) -> Function1(a, r)

///
///
///
@external(javascript, "../glv8_ffi.mjs", "find_function")
pub fn find_function2(function f: String) -> Function2(a, b, r)

///
///
///
@external(javascript, "../glv8_ffi.mjs", "find_function")
pub fn find_function3(function f: String) -> Function3(a, b, c, r)

///
///
///
@external(javascript, "../glv8_ffi.mjs", "find_function")
pub fn find_function4(function f: String) -> Function4(a, b, c, d, r)
