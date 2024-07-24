# glv8

glv8 facilitates one to write [gleam](https://gleam.run) for postgresql as trusted language extension.
It provides [plv8](https://plv8.github.io) bindings and tools like [plv8ify](https://github.com/divyenduz/plv8ify)

[![Package Version](https://img.shields.io/hexpm/v/glv8)](https://hex.pm/packages/glv8)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glv8/)

glv8 is *not* a SQL query builder, it is not an application framework either. Instead it promotes
gleam as an alternative to JavaScript to do functional computation in a restricted JavaScript runtime,
directly inside postgresql database.

Further documentation can be found at <https://hexdocs.pm/glv8>.

## Development

```sh
gleam build # Run the project
gleam test  # Run the tests
```
