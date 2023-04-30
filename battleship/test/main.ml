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

let create_endcoords_test (name : string)
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

let create_endcoords_tests =
  [
    create_endcoords_test "Ship1 left" create_endcoords_shiplength2 Left
      ('E', 7) ('D', 7);
    create_endcoords_test "Ship1 right" create_endcoords_shiplength2 Right
      ('E', 7) ('F', 7);
    create_endcoords_test "Ship1 up" create_endcoords_shiplength2 Up ('E', 7)
      ('E', 6);
    create_endcoords_test "Ship1 down" create_endcoords_shiplength2 Down
      ('E', 7) ('E', 8);
    create_endcoords_test "Ship2/3 left" create_endcoords_shiplength3 Left
      ('F', 3) ('D', 3);
    create_endcoords_test "Ship2/3 right" create_endcoords_shiplength3 Right
      ('F', 3) ('H', 3);
    create_endcoords_test "Ship2/3 up" create_endcoords_shiplength3 Up ('F', 3)
      ('F', 1);
    create_endcoords_test "Ship2/3 down" create_endcoords_shiplength3 Down
      ('F', 3) ('F', 5);
    create_endcoords_test "Ship4 left" create_endcoords_shiplength4 Left
      ('E', 5) ('B', 5);
    create_endcoords_test "Ship4 right" create_endcoords_shiplength4 Right
      ('E', 5) ('H', 5);
    create_endcoords_test "Ship4 up" create_endcoords_shiplength4 Up ('E', 5)
      ('E', 2);
    create_endcoords_test "Ship4 down" create_endcoords_shiplength4 Down
      ('E', 5) ('E', 8);
    create_endcoords_test "Ship5 left" create_endcoords_shiplength5 Left
      ('E', 6) ('A', 6);
    create_endcoords_test "Ship5 right" create_endcoords_shiplength5 Right
      ('E', 6) ('I', 6);
    create_endcoords_test "Ship5 up" create_endcoords_shiplength5 Up ('E', 6)
      ('E', 2);
    create_endcoords_test "Ship5 down" create_endcoords_shiplength5 Down
      ('E', 6) ('E', 10);
  ]

let ship1_left_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; "#"; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let ship1_right_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let ship1_up_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let ship1_down_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

(* let place_ship_test=(name : string) grid (f : (direction -> char * int ->
   unit list list) -> string array list) (direction : direction) (initial_spot :
   char * int) expected_output : test = name >:: fun _ -> let new_grid=(f
   direction initial_spot) in return_player_grid() in let
   grid=return_player_grid in assert_equal expected_output grid *)

let tests =
  "test suite for Final Project"
  >::: List.flatten [ new_turn_tests; create_endcoords_tests ]

let _ = run_test_tt_main tests
