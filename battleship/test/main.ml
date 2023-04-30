open OUnit2
open Lib
open State
open Battleship

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
    [| " "; " "; "x"; " "; " "; " "; " "; " "; " "; " " |];
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

let new_turn_test (name : string) s (position : string * string) expected : test
    =
  name >:: fun _ ->
  let () = new_turn s position in
  assert_equal expected s

let new_turn_exn_test (name : string) s (position : string * string)
    expected_output : test =
  name >:: fun _ -> assert_raises Illegal (fun () -> new_turn s position)

let final_ship_coords_test (name : string)
    (f : direction -> char * int -> char * int) (direction : direction)
    (initial_spot : char * int) expected_output : test =
  name >:: fun _ ->
  let final_coords = f direction initial_spot in
  assert_equal expected_output final_coords

let new_turn_tests =
  [
    new_turn_test "Basic Test" grid ("B", "4") grid2;
    new_turn_exn_test "exn test" grid3 ("C", "1") Illegal;
  ]

let final_coords_tests =
  [
    final_ship_coords_test "Ship1 left" create_endcoords_shiplength2 Left
      ('E', 7) ('D', 7);
    final_ship_coords_test "Ship1 right" create_endcoords_shiplength2 Right
      ('E', 7) ('F', 7);
    final_ship_coords_test "Ship1 up" create_endcoords_shiplength2 Up ('E', 7)
      ('E', 6);
    final_ship_coords_test "Ship1 down" create_endcoords_shiplength2 Down
      ('E', 7) ('E', 8);
      final_ship_coords_test "Ship2/3 left" create_endcoords_shiplength3 Left
      ('E', 7) ('D', 7);
    final_ship_coords_test "Ship2/3 right" create_endcoords_shiplength3 Right
      ('E', 7) ('F', 7);
    final_ship_coords_test "Ship2/3 up" create_endcoords_shiplength3 Up ('E', 7)
      ('E', 6);
    final_ship_coords_test "Ship2/3 down" create_endcoords_shiplength3 Down
      ('E', 7) ('E', 8);
  ]

let tests =
  "test suite for Final Project"
  >::: List.flatten [ new_turn_tests; final_coords_tests ]

let _ = run_test_tt_main tests
