open Lib
(** [play_game f] starts the game with state [g]. *)

open Battleship
open AI
open Command
open State

let reset_board () =
  let new_grid = List.map (fun row -> Array.copy row) randomgrid in
  new_grid

let player_board () =
  let new_grid = List.map (fun row -> Array.copy row) player_grid in
  new_grid

let rec play_game grid grid2 string =
  try
    let move2 = parse string in
    new_turn grid move2;
    print_endline "\n AI board \n";
    print_column_label grid;
    print_grid grid 1;
    print_endline "\n Player board \n";
    print_column_label grid2;
    print_grid grid2 1;
    print_endline "\n Choose a target: \n";
    let line = read_line () in
    play_game grid grid2 line
  with _ ->
    print_endline "\n Choose a target: \n";
    let line = read_line () in
    play_game grid grid2 line

let main () =
  print_endline "\n AI board \n";
  let grid1 = reset_board () in
  let grid2 = player_board () in
  print_endline "Choose a target:";
  let line = read_line () in
  play_game grid1 grid2 line

let () = main ()

let instructions () = print_string "Hello and welcome to Battleship!";
print_string "Before you start your battle we must run you through everything you as a player need to know.
To start off:
 The objective of the game is to sink all 5 of your opponent's ships.
You are going to choose where you would like to place all 5 of your ships.
Everyone's ships may be placed horizontally or vertically, but never diagonally.
These ships will all be of different lengths. One will be of length 2, two of length 3, 
one of length 4, one of length 5.
You must hit all parts of the ship to get a point.
However, you do not know where your opponent's ships are located, 
this is where the fun begins.
You have ammo that can be shot at any coordinate on your opponent's board."
