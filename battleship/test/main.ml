open OUnit2
open Lib
open State
open Battleship
open Command

let grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid2 =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; "o"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid3 =
  [
    [| " "; "#"; "x"; " "; " "; " "; "#"; "#"; "#"; "#" |];
    [| " "; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; "#"; "#"; "#"; "#"; "#"; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; "#"; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; "#"; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; "#"; " " |];
    [| " "; "#"; "#"; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let new_turn_test (name : string) s (position : string * string) expected : test
    =
  name >:: fun _ ->
  let () = new_turn s position in
  assert_equal expected s

let new_turn_error_test (name : string) s (position : string * string)
    (expected_output : exn) : test =
  name >:: fun _ ->
  assert_raises expected_output (fun () -> new_turn s position)

let parse_test (name : string) string (expected_output : string * string) : test
    =
  name >:: fun _ -> assert_equal expected_output (parse string)

let command_tests =
  [ (* parse_test "Testing example where the players input command is shoot b4
       and is \ being parsed" " SHOOT b 4 " ("b", "4"); parse_test "Testing
       example where the players input command is shoot a3 and is \ being
       parsed" " SHOOT a 3 " ("a", "3"); parse_test "Testing example where the
       players input command is shoot a3 and is \ being parsed" " QUIT " ("a",
       "b"); *) ]

let new_turn_tests = [ new_turn_test "Basic Test" grid ("B", "4") grid2 ]

let new_turn_error_tests =
  [ new_turn_error_test "Error test" grid3 ("C", "1") Illegal ]

let tests =
  "test suite for Final Project"
  >::: List.flatten [ new_turn_tests; new_turn_error_tests ]

let _ = run_test_tt_main tests
