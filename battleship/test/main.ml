open OUnit2
open Command 
let () = print_endline "Hello, World!"

let parse_test (name: string) str (expected_output: command) : test = 
  name ::> fun _ -> assert_equal expected_output (parse str)


let command_tests = [ 
  parse_test "Testing exmaple for shoot command at position b 4"  " []"

]