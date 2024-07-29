import bundle
import envoy
import gleam/io
import gleam/javascript/promise.{type Promise}
import gleam/list
import gleam/result

@external(javascript, "./build_ffi.mjs", "bundle_build")
pub fn bundle_build(
  entry e: String,
  namespace n: String,
  outfile o: String,
) -> Promise(Result(Nil, String))

@external(javascript, "./build_ffi.mjs", "copy_build")
pub fn copy_build(
  sql f: String,
  namespace n: String,
  outfile o: String,
) -> Promise(Result(Nil, String))

@external(javascript, "./build_ffi.mjs", "bundle_watch")
pub fn bundle_watch(
  entry e: String,
  namespace n: String,
  outfile o: String,
) -> Promise(Result(Nil, String))

@external(javascript, "./build_ffi.mjs", "copy_watch")
pub fn copy_watch(
  sql f: String,
  namespace n: String,
  outfile o: String,
) -> Promise(Result(Nil, String))

type Builder =
  fn(String, String, String) -> Promise(Result(Nil, String))

type Asset {
  Asset(src: String, namespace: String, dist: String, builder: Builder)
}

const entry = "./build/dev/javascript/glv8/bundle.mjs"

const dist = "./dist/"

const src = "./src/"

fn bundle_asset(watch: Bool, namespace: String) -> List(Asset) {
  case watch {
    True -> [Asset(entry, namespace, dist <> "glv8_init.sql", bundle_watch)]
    False -> [Asset(entry, namespace, dist <> "glv8_init.sql", bundle_build)]
  }
}

fn sql_asset(watch: Bool, namespace: String) -> List(Asset) {
  bundle.sqls()
  |> list.map(fn(sql) {
    case watch {
      True -> Asset(src <> sql, namespace, dist <> sql, copy_watch)
      False -> Asset(src <> sql, namespace, dist <> sql, copy_build)
    }
  })
}

fn fold_result(
  r0: Result(Nil, String),
  r: Result(Nil, String),
) -> Result(Nil, String) {
  case r0, r {
    Ok(Nil), Ok(Nil) -> r0
    Error(_), Ok(Nil) -> r0
    Ok(Nil), Error(_) -> r
    Error(e1), Error(e2) -> Error(e1 <> "\n\n" <> e2)
  }
}

fn build(ass: List(Asset)) -> Promise(Result(Nil, String)) {
  ass
  |> list.map(fn(a) { a.builder(a.src, a.namespace, a.dist) })
  |> promise.await_list
  |> promise.map(fn(ls) {
    ls
    |> list.fold(Ok(Nil), fold_result)
  })
}

pub fn main() {
  let watch =
    envoy.get("GLV8_BUILD_WATCH")
    |> result.is_ok

  let namespace =
    envoy.get("GLV8_NAMESPACE")
    |> result.unwrap("glv8")

  use r0 <- promise.await(bundle_asset(watch, namespace) |> build)
  use r1 <- promise.await(sql_asset(watch, namespace) |> build)

  [r0, r1]
  |> list.fold(Ok(Nil), fold_result)
  |> result.map_error(fn(e) { io.println_error(e) })
  |> promise.resolve
}
