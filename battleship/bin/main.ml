(** [play_game f] starts the game with state [g]. *)
open Lib
open Battleship
open AI
open Command
open State

let reset_board () =
  let new_grid = List.map (fun row -> Array.copy row) randomgrid in
  new_grid

let rec play_game grid string= 
  try
      let move2 = parse string in 
      new_turn grid move2;
      print_column_label grid;
      print_grid grid 1;
      print_endline "\n Choose a target: \n";
      let line = (read_line ()) in play_game grid line
  with _ -> 
      print_endline "\n Choose a target: \n";
      let line = (read_line ()) in play_game grid line

let main () =
  let grid = reset_board () in
  print_endline "Choose a target:";
  let line = (read_line ()) in play_game grid line

let () = main ()