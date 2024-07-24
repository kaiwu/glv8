import gleeunit/should
import glv8/database
import gleam/javascript/array

pub fn execute_test() {
  database.execute("test", #(1, 42, "hi", array.from_list([0, 0, 0])))
}
