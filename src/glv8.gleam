import gleam/json.{type Json}

pub type DBError {
  DBError(Nil)
  DBErrorMessage(e: String)
  DBErrorJson(j: Json)
}

pub type Function0 =
  fn() -> Nil

pub type Function1(a) =
  fn(a) -> Nil

pub type Function2(a, b) =
  fn(a, b) -> Nil

pub type Function3(a, b, c) =
  fn(a, b, c) -> Nil

pub type Function4(a, b, c, d) =
  fn(a, b, c, d) -> Nil
