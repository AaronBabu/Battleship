(** [play_game f] starts the game with state [g]. *)
open Lib
open Battleship
open Command
open State

let grid =
  [
    [| " "; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; "#"; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; "#"; " "; " "; "#"; "#"; "#"; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; "#"; " "; " "; " " |];
    [| " "; " "; "#"; "#"; " "; " "; "#"; " "; " "; "#" |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; "#" |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; "#" |];
  ]

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

  
    (**else if l_type = "two player" then main_two_player ()
    else if l_type = "quit" then (print_endline("Goodbye!"); exit 0;)
    else failwith "Not a valid player configuration"
  with _ -> game_setting ()*)

let rec main () = 
  print_endline "Choose a target:";
  let line = (read_line ()) in play_game grid line

let () = main ()