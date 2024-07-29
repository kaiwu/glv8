CREATE FUNCTION glv8_test(keys text[], vals text[]) RETURNS text AS
$$
	return glv8.plv8_test(keys, vals);
$$
LANGUAGE plv8 IMMUTABLE STRICT;

CREATE TYPE rec AS (i integer, t text);
CREATE FUNCTION scalar_to_record(i integer, t text) RETURNS rec AS
$$
	return glv8.scalar_to_record(i, t);
$$
LANGUAGE plv8;

CREATE FUNCTION set_of_records() RETURNS SETOF rec AS
$$
  return glv8.set_of_records();
$$
LANGUAGE plv8;

CREATE FUNCTION set_of_integers() RETURNS SETOF integer AS
$$
  return glv8.set_of_integers();
$$
LANGUAGE plv8;

CREATE FUNCTION fastsum(arr int[]) RETURNS int AS
$$
  return glv8.fastsum(arr);
$$
LANGUAGE plv8 IMMUTABLE STRICT;

CREATE FUNCTION return_sql() RETURNS SETOF rec AS
$$
	return glv8.return_sql();
$$
LANGUAGE plv8;

CREATE FUNCTION catch_sql_error() RETURNS void AS
$$
  glv8.catch_sql_error();
$$ LANGUAGE plv8;

CREATE FUNCTION catch_sql_error_2() RETURNS text AS
$$
  return glv8.catch_sql_error2();
$$ LANGUAGE plv8;
