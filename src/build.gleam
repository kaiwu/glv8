// import gleam/io
// import gleam/result
import gleam/javascript/promise.{type Promise}

pub const prefix = "glv8"

@external(javascript, "./build_ffi.mjs", "bundle_build")
pub fn bundle_build(
  entry e: String,
  global g: String,
  banner b: String,
  footer f: String,
  outfile o: String,
) -> Promise(Result(String, String))

const entry = "./build/dev/javascript/glv8/bundle.mjs"

const dist = "./dist/"

const banner = "CREATE OR REPLACE FUNCTION glv8_init() RETURNS void LANGUAGE plv8 AS $function$"

const footer = " = app.exports(); $function$"

pub fn main() {
  use r <- promise.await(bundle_build(
    entry,
    "app",
    banner,
    prefix <> footer,
    dist <> "glv8_init.sql",
  ))

  r
  // |> result.map_error(fn(e) { io.println_error(e) })
  |> promise.resolve
}
