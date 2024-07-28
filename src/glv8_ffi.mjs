import { Ok, Error } from "./gleam.mjs"
import { DBErrorMessage, DBErrorJson } from "./glv8.mjs"
import { NilRow } from "./glv8/database.mjs"

export function id(a) {
  return a;
}

export function info() {
  return plv8_info();
}

export function reset(c) {
  plv8_reset(c);
}

export function reset_all() {
  plv8_reset();
}

export function version() {
  return plv8.version();
}

export function memory_usage() {
  return plv8.memory_usage();
}

export function elog(l, m) {
  switch (Symbol.keyFor(l)) {
    case "DEBUG5":
      plv8.elog(DEBUG5, m);
      break;
    case "DEBUG4":
      plv8.elog(DEBUG4, m);
      break;
    case "DEBUG3":
      plv8.elog(DEBUG3, m);
      break;
    case "DEBUG2":
      plv8.elog(DEBUG2, m);
      break;
    case "DEBUG1":
      plv8.elog(DEBUG1, m);
      break;
    case "LOG":
      plv8.elog(LOG, m);
      break;
    case "INFO":
      plv8.elog(INFO, m);
      break;
    case "NOTICE":
      plv8.elog(NOTICE, m);
      break;
    case "WARNING":
      plv8.elog(WARNING, m);
      break;
    case "ERROR":
      plv8.elog(ERROR, m);
      break;
  }
}

export function run_script(s, f) {
  plv8.run_script(s, f);
}

export function find_function(f) {
  return plv8.find_function(f);
}

export function execute(q, p) {
  try {
    let r = p ? plv8.execute(q, p) : plv8.execute(q);
    return new Ok(r);
  } catch (e) {
    return new Error(new DBErrorMessage(JSON.stringify(e)));
  }
}

export function prepare(q, p) {
  return plv8.prepare(q, p);
}

export function plan_execute(pl, p) {
  try {
    let r = pl.execute(p);
    return new Ok(r);
  } catch (e) {
    return new Error(new DBErrorMessage(JSON.stringify(e)));
  }
}

export function plan_free(pl) {
  pl.free();
}

export function plan_cursor(pl, p) {
  return pl.cursor(p);
}

export function cursor_fetch(c) {
  try {
    let r = c.fetch();
    return r ? new Ok(r) : new Ok(new NilRow(undefined));
  } catch (e) {
    return new Error(new DBErrorMessage(JSON.stringify(e)));
  }
}

export function cursor_fetch_rows(c, n) {
  try {
    let r = c.fetch(n);
    return new Ok(r);
  } catch (e) {
    return new Error(new DBErrorMessage(JSON.stringify(e)));
  }
}

export function cursor_move(c, n) {
  c.move(n);
}

export function cursor_close(c) {
  c.close();
}

export function subtransaction(f) {
  try {
    plv8.subtransaction(f);
    return new Ok(undefined);
  } catch (e) {
    return new Error(new DBErrorMessage(JSON.stringify(e)));
  }
}

export function get_window_object() {
  return plv8.get_window_object();
}

