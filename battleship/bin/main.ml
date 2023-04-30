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

let instructions () =
  print_string
    "Hello and welcome to Battleship!\n\
    \    Before you start your battle we must run you through everything you \
     as a player need to know.\n\n\
    \    To start off:\n\
    \      The objective of the game is to sink all 5 of your opponent's ships.\n\
    \    \n\
    \    Rules:\n\
    \      You are going to choose where you would like to place all 5 of your \
     ships.\n\
    \      Everyone's ships may be placed horizontally or vertically, but \
     never diagonally.\n\
    \      These ships will all be of different lengths. One will be of length \
     2, two of length 3, \n\
    \      one of length 4, one of length 5.\n\
    \      You must hit all parts of the ship to get a point.\n\
    \      However, you do not know where your opponent's ships are located, \n\
    \      this is where the fun begins.\n\n\
    \    How to play:\n\
    \      You have ammo that can be shot at any coordinate on your opponent's \
     board. \n\
    \      To hit a spot on the board you must type in the command line “shoot \
     *row letter* *column number*” \n\
    \      If the ammo hits an empty spot and O will appear.\n\
    \      If a ship is hit at one of the points, an X will appear at that \
     exact point \n\
    \      Once you hit all parts of the ship a point will be added to your \
     score. \n\
    \      When your score hits zero you win the game. \n\
    \      If you want to quit at anytime press ctrl + c on your keyboard.\n\n\
    \    Warning:\n\
    \      Your opponent will also try to hit your ships.\n\
    \      If your opponent hits your ship “Your opponent hit part of your \
     ship” will appear.\n\
    \      If you opponent hits your entire ship “Your opponent hit your \
     entire ship. Protect the *amount of ships left* you have left” will \
     appear.";

  print_endline "\n Happy playing! \n"

let main () =
  let instruct = instructions () in
  instruct;
  let grid1 = reset_board () in
  let grid2 = player_board () in
  print_endline "\n AI board \n";
  print_endline "Choose a target:";
  let line = read_line () in
  play_game grid1 grid2 line

let () = main ()
