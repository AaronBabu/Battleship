open OUnit2
open Lib
open State
open Battleship
open Parse
open AI

(* Our test file successfully tests several features of our game. Below is a
   detailed description of each test function and why/how we tested it this way:

   new_turn_test(): This tested the making a move on the board and compared the
   expected grid to the grid with the new move placed. This was done with glass
   box testing after implementing the new_turn() function. Although we only did
   a basic OUnit test here, we also manually tested placing moves on the grid
   when running `` make play ``.

   new_turn_exn_test(): This extended the new_turn_test by testing when the
   new_turn function threw an exception. It throws an exception if there was
   already a move in that position. Again, this was also tested manually.

   create_endcoords_test(): This tested creating the end coordinates needed for
   placing the ships based on the given initial coordinates. This was done with
   black box testing, as we tested each direction possible to place the ship
   with each possible ship length. This was fully tested with OUnit testing and
   not manually, but we ensured that it worked once we could play the game.

   place_ship_test(): This tested placing the ships on the grid given the
   specific ship placing function (based on ship size) and the intial directions
   and coordinates. These tests required making initial and final grids to
   compare because we needed to ensure that each ship of each length could be
   placed in each direction. Since the function only mutates the given grid and
   doesn't create a new grid, we had to make 2 grids per ship and direction to
   compare. This testing was done completely with OUnit testing and we tested
   each possibility with glass box testing after the functions were written.

   is_occupied test(): This tests the function is_occupied and tells you if the
   position has a ship on it or not. This was tested using glass box testing. We
   make sure it says true when the is a ship (#), false when it was already hit
   (x), and false when it's a miss (o).

   check_hit_count_test(): This tested the function that checks if the game has
   ended or not, with one of the players hitting all ships or not hitting all
   ships. This was done with black box testing, as it will only return true if
   there are 17 x's on the board, and will return false with any other amount of
   x's.

   parse_tests: In this we test both parse and parse 2. We test for when there
   are multiple spaces, upper/lower case, and when exceptions should be raise.
   These were done using glass box testing. Every feature for both parse and
   parse2 were tested and were tested in different combinations to make sure it
   works. This function had to be thoroughly tested because it is the way the
   game can take what the player is saying and use it for other functions to
   make that action happen.

   Tesing AI.ml random generating functions: To make sure the functions in AI.ml
   were outputting random coordinates we test to see if they were in the write
   range when the function ran 100 times. This was done for testing for random
   numbers, letters, coordinates, and points. If the output is not in the proper
   range the function fails.

   Overall, our testing approach demonstreates full correctness of the system.
   With OUnit, we were able to test making moves, calculating coordinates, and
   placing ships in every direction with ships of every length, which are the
   main aspects to playing the game. We were also able to fully test all aspects
   manually once we had everything implemented together by being able to
   physically play the game. Since we are able to play our game correctly based
   on how we wanted and how we implemented it, we can ensure that our system is
   correct. *)

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
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid4 =
  [
    [| " "; " "; "x"; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
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
    new_turn_test "Hit ship" grid3 ("E", "3") grid4;
    new_turn_exn_test "new_turn on missed ship" grid2 ("B", "4") Illegal;
    new_turn_exn_test "new_turn on hit ship" grid3 ("C", "1") Illegal;
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

let grid_1_left_initial =
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

let grid_1_right_initial =
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

let grid_1_up_initial =
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

let grid_1_down_initial =
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

let grid_23_left_initial =
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

let ship23_left_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; "#"; "#"; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_23_right_initial =
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

let ship23_right_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "#"; "#"; "#"; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_23_up_initial =
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

let ship23_up_grid =
  [
    [| " "; " "; " "; " "; " "; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_23_down_initial =
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

let ship23_down_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "#"; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_4_left_initial =
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

let ship4_left_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; "#"; "#"; "#"; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_4_right_initial =
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

let ship4_right_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; "#"; "#"; "#"; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_4_up_initial =
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

let ship4_up_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_4_down_initial =
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

let ship4_down_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_5_left_initial =
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

let ship5_left_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| "#"; "#"; "#"; "#"; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_5_right_initial =
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

let ship5_right_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; "#"; "#"; "#"; "#"; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_5_up_initial =
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

let ship5_up_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let grid_5_down_initial =
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

let ship5_down_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
  ]

let place_ship_test (name : string)
    (f : string array list -> direction -> char * int -> unit list list)
    (initial_grid : string array list) (direction : direction)
    (initial_spot : char * int) (expected_output : string array list) : test =
  name >:: fun _ ->
  let _ = f initial_grid direction initial_spot in
  assert_equal expected_output initial_grid

let place_ship_tests =
  [
    place_ship_test "place ship1 left" print_ship1 grid_1_left_initial Left
      ('E', 7) ship1_left_grid;
    place_ship_test "place ship1 right" print_ship1 grid_1_right_initial Right
      ('E', 7) ship1_right_grid;
    place_ship_test "place ship1 up" print_ship1 grid_1_up_initial Up ('E', 7)
      ship1_up_grid;
    place_ship_test "place ship1 down" print_ship1 grid_1_down_initial Down
      ('E', 7) ship1_down_grid;
    place_ship_test "place ship23 left" print_ship2 grid_23_left_initial Left
      ('F', 3) ship23_left_grid;
    place_ship_test "place ship23 right" print_ship2 grid_23_right_initial Right
      ('F', 3) ship23_right_grid;
    place_ship_test "place ship23 up" print_ship2 grid_23_up_initial Up ('F', 3)
      ship23_up_grid;
    place_ship_test "place ship23 down" print_ship2 grid_23_down_initial Down
      ('F', 3) ship23_down_grid;
    place_ship_test "place ship4 left" print_ship4 grid_4_left_initial Left
      ('E', 5) ship4_left_grid;
    place_ship_test "place ship4 right" print_ship4 grid_4_right_initial Right
      ('E', 5) ship4_right_grid;
    place_ship_test "place ship4 up" print_ship4 grid_4_up_initial Up ('E', 5)
      ship4_up_grid;
    place_ship_test "place ship4 down" print_ship4 grid_4_down_initial Down
      ('E', 5) ship4_down_grid;
    place_ship_test "place ship5 left" print_ship5 grid_5_left_initial Left
      ('E', 6) ship5_left_grid;
    place_ship_test "place ship5 right" print_ship5 grid_5_right_initial Right
      ('E', 6) ship5_right_grid;
    place_ship_test "place ship5 up" print_ship5 grid_5_up_initial Up ('E', 6)
      ship5_up_grid;
    place_ship_test "place ship5 down" print_ship5 grid_5_down_initial Down
      ('E', 6) ship5_down_grid;
  ]

let all_ships_hit_grid =
  [
    [| "x"; "x"; " "; " "; "x"; "x"; "x"; " "; " "; " " |];
    [| " "; " "; "x"; "x"; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
  ]

let not_all_ships_hit_grid =
  [
    [| "#"; "#"; " "; " "; "#"; "x"; "#"; " "; " "; " " |];
    [| " "; " "; "x"; "x"; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; "0"; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "x"; " "; "o"; " " |];
    [| " "; "o"; " "; " "; "#"; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; "x"; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "x"; " "; " "; " "; " "; " " |];
  ]

let no_ships_hit_grid =
  [
    [| "#"; "#"; " "; " "; "#"; "#"; "#"; " "; " "; " " |];
    [| " "; " "; "#"; "#"; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; "0"; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "#"; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "#"; " "; "o"; " " |];
    [| " "; "o"; " "; " "; "#"; " "; "#"; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; "#"; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
  ]

let is_occupied_test (name : string) (grid : string array list)
    (position : char * int) (expected_output : bool) : test =
  name >:: fun _ -> assert_equal expected_output (is_occupied grid position)

let is_occupied_tests =
  [
    is_occupied_test "is occupied" ship5_down_grid ('E', 7) true;
    is_occupied_test "is not occupied" ship5_down_grid ('A', 1) false;
    is_occupied_test "check miss" not_all_ships_hit_grid ('D', 3) false;
    is_occupied_test "check hit" not_all_ships_hit_grid ('C', 2) false;
  ]

let check_hit_count_test (name : string) (grid : string array list)
    expected_output : test =
  name >:: fun _ -> assert_equal (check_hit_count grid) expected_output

let check_hit_count_tests =
  [
    check_hit_count_test "true" all_ships_hit_grid true;
    check_hit_count_test "false on empty grid" grid false;
    check_hit_count_test "false on mid-game grid" not_all_ships_hit_grid false;
    check_hit_count_test "false on no ships hit grid" no_ships_hit_grid false;
  ]

let parse_tests =
  [
    ("basic parse" >:: fun _ -> assert_equal ("b", "4") (parse "shoot b 4"));
    ( "parse with spaces" >:: fun _ ->
      assert_equal ("a", "3") (parse "shoot a  3 ") );
    ( "parse with uppercase" >:: fun _ ->
      assert_equal ("c", "2") (parse "shoot C 2") );
    ("empty parse" >:: fun _ -> assert_raises Empty (fun () -> parse ""));
    ( "parse with just spaces" >:: fun _ ->
      assert_raises Empty (fun () -> parse "    ") );
    ("quit parse" >:: fun _ -> assert_raises Quit (fun () -> parse "quit"));
    ( "quit parse with spaces" >:: fun _ ->
      assert_raises Quit (fun () -> parse "  quit  ") );
    ( "parse anything else " >:: fun _ ->
      assert_raises Malformed (fun () -> parse "hello") );
  ]

let parse2_tests =
  [
    ("parse2 empty" >:: fun _ -> assert_raises Empty (fun () -> parse2 ""));
    ( "parse2 spaces" >:: fun _ ->
      assert_equal (Left, 'A', 4) (parse2 "place left     a   4") );
    ( "parse2 uppercase left" >:: fun _ ->
      assert_equal (Left, 'B', 3) (parse2 "place Left b 3") );
    ( "parse 2 uppercase left uppercase coord" >:: fun _ ->
      assert_equal (Left, 'B', 3) (parse2 "place Left B 3") );
    ( "parse2 lowercase right" >:: fun _ ->
      assert_equal (Right, 'C', 5) (parse2 "place right c 5") );
    ( "parse2 lowercase right uppercase coord" >:: fun _ ->
      assert_equal (Right, 'C', 5) (parse2 "place right C 5") );
    ( "parse2 uppercase right" >:: fun _ ->
      assert_equal (Right, 'C', 7) (parse2 "place Right c 7") );
    ( "parse2 uppercase right uppercase coord" >:: fun _ ->
      assert_equal (Right, 'C', 7) (parse2 "place Right C 7") );
    ( "parse2 uppercase up" >:: fun _ ->
      assert_equal (Up, 'D', 7) (parse2 " place Up d 7") );
    ( "parse2 lowercase up" >:: fun _ ->
      assert_equal (Up, 'G', 10) (parse2 "place up g 10") );
    ( "parse2 uppercase down" >:: fun _ ->
      assert_equal (Down, 'F', 8) (parse2 "place Down f 8") );
    ( "parse2 lowercase down" >:: fun _ ->
      assert_equal (Down, 'A', 4) (parse2 "place down a 4") );
    ( "parse2 uppercase coordinates" >:: fun _ ->
      assert_equal (Down, 'C', 5) (parse2 "place down C 5") );
    ( "parse2 uppercase coordinates with spaces" >:: fun _ ->
      assert_equal (Down, 'C', 5) (parse2 " place down  C   5") );
    ( "parse2 anything else" >:: fun _ ->
      assert_raises Malformed (fun () -> parse2 "flop") );
    ( "parse2 bunch of spaces" >:: fun _ ->
      assert_raises Empty (fun () -> parse2 "    ") );
  ]

let count_x_grid =
  [
    [| "#"; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; "x"; " "; " "; " "; " " |];
    [| " "; " "; " "; "o"; " "; "x"; " "; "x"; " "; " " |];
    [| " "; " "; " "; " "; " "; "x"; " "; "x"; " "; " " |];
    [| " "; " "; " "; " "; " "; "x"; " "; "x"; "o"; " " |];
    [| " "; "o"; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; "#"; " "; " "; " "; " "; " " |];
  ]


let count_o_grid =
  [
    [| "#"; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "o"; " "; " "; " " |];
    [| " "; " "; " "; "o"; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; "o"; " " |];
    [| " "; "o"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; "o"; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; "o"; " " |];
    [| " "; " "; " "; " "; " "; " "; "o"; " "; " "; " " |];
  ]

let count_x_test (name : string) (grid : string array list) (expected_output : int) : test =
name >:: fun _ -> assert_equal expected_output (count_x grid)

let count_o_test (name : string) (grid : string array list) (expected_output : int) : test =
name >:: fun _ -> assert_equal expected_output (count_o grid)

let count_test = [
  count_x_test "Counting x's" count_x_grid 7;
  count_x_test "Counting 0 x's" grid 0;
  count_o_test "Counting o's" count_o_grid 7;
  count_o_test "Counting 0 o's" count_o_grid 0;
]
  
let test_random_point () =
  for i = 1 to 100 do
    let a, b, c = pick_random_point grid in
    if Char.code a < 65 || Char.code a > 74 || b < 1 || b > 10 then
      failwith "Result outside expected range"
  done

let test_random_cord () =
  for i = 1 to 100 do
    let a, b = random_coord () in
    if Char.code a < 65 || Char.code a > 74 || b < 0 || b > 9 then
      failwith "Result outside expected range"
  done

let test_random_letter () =
  for i = 1 to 100 do
    let result = letter_randomizer () in
    if Char.code result < 65 || Char.code result > 74 then
      failwith "Result outside expected range"
  done

let test_random_num () =
  for i = 1 to 100 do
    let result = number_randomizer () in
    if result < 1 || result > 10 then failwith "Result outside expected range"
  done

let test_coord () =
  for i = 1 to 100 do
    let a, b = coord () in
    if Char.code a < 65 || Char.code a > 74 || b < 1 || b > 10 then
      failwith "Result outside expected range"
  done

(* let update_score_test (name : string) (score : int ref) (expected_output :
   int) : test = name >:: let new_score = update_score score in assert_equal
   expected_output new_score

   let s = ref 0 let update_score_tests = [ ("start with 0" >:: fun _ ->
   assert_equal 1 ()) ] *)

let tests =
  "test suite for Final Project"
  >::: List.flatten
         [
           new_turn_tests;
           create_endcoords_tests;
           place_ship_tests;
           check_hit_count_tests;
           parse_tests;
           parse2_tests;
           is_occupied_tests;
         ]

let _ = run_test_tt_main tests
let _ = test_random_point ()
let _ = test_random_cord ()
let _ = test_random_letter ()
let _ = test_random_num ()
let _ = test_coord ()
