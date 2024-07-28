import gleam/dynamic.{type DecodeErrors}
import gleam/json.{type Json}

pub type DBError {
  DBError(Nil)
  DBErrorMessage(e: String)
  DBErrorJson(j: Json)
  DBErrorDecode(es: DecodeErrors)
}

pub type Function0(r) =
  fn() -> r

pub type Function1(a, r) =
  fn(a) -> r

pub type Function2(a, b, r) =
  fn(a, b) -> r

pub type Function3(a, b, c, r) =
  fn(a, b, c) -> r

pub type Function4(a, b, c, d, r) =
  fn(a, b, c, d) -> r

pub type SqlFunction(f) {
  SqlFunction(f: f, sql: String)
}
