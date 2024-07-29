# glv8

Ever wanted to write functional type-safe postgresql procedures ? Let's use [gleam](https://gleam.run) !

[![Package Version](https://img.shields.io/hexpm/v/glv8)](https://hex.pm/packages/glv8)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glv8/)

glv8 coworks with [plv8](https://plv8.github.io). It provides plv8's API bindings so one can
write procedures with gleam and let `plv8` do the needed proxying. Specifically, gleam codes are
compiled as JavaScript and interoperate with plv8 ecosystem. For example

```gleam
pub fn catch_sql_error() -> Nil {
  let r = database.execute("throw SQL error", Nil)
  use <- bool.guard(result.is_ok(r), Nil)

  case r {
    Error(glv8.DBErrorJson(j)) -> elog_notice(j |> json.to_string)
    _ -> elog_notice("should not come here")
  }
}
```

The snippet can be provisioned with `plv8` declaration

```sql
CREATE FUNCTION catch_sql_error() RETURNS void AS
$$
  glv8.catch_sql_error();
$$ LANGUAGE plv8;
```

More examples can be found at `src/app/plv8.gleam`
Further documentation can be found at <https://hexdocs.pm/glv8>.

## Development

- write any gleam functions, with `pub fn` specifier in any packages.
- provide needed proxying sqls
- declare them in the `exports` and `sqls` of `bundle.gleam`
- build (or watch build) them with npm scripts
- the artifacts are `dist/glv8_init.sql` which wraps up all the exported gleam functions
  and the needed proxying sqls
- by default, the gleam functions use prefix `glv8.` as namespace, one can overwrite
  it with envionment variable `GLV8_NAMESPACE`

```sh
$ npm run build
$ npm run watch
$ npm run clean
$ npm run purge
```

## Deployment

- postgresql database with `plv8` trusted language extension.
- glv8 needs `SET plv8.start_proc = 'glv8_init';` either in `postgresql.conf` or session pre-request
- deploy artifacts `glv8_init.sql` and all the other proxying sqls
- enjoy

## RoadMap

- auto-generate proxying sqls as [plv8ify](https://github.com/divyenduz/plv8ify) with `glance` (it might be rigid and over-kill after all)
