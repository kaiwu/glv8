import gleam/io
import gleam/javascript/promise.{type Promise}
import gleam/result

pub const prefix = "glv8"

@external(javascript, "./build_ffi.mjs", "bundle_build")
pub fn bundle_build(
  entry f: String,
  global g: String,
  outfile o: String,
) -> Promise(Result(Nil, String))

const entry = "./build/dev/javascript/glv8/bundle.mjs"

const dist = "./dist/"

pub fn main() {
  use r <- promise.await(bundle_build(entry, "app", dist <> "app.js"))

  r
  |> result.map_error(fn(e) { io.println_error(e) })
  |> promise.resolve
}
