(** [play_game f] starts the game with state [g]. *)
open Lib
open Battleship
open Command
open State
let play_game g = raise (Failure "Unimplemented: Main.play_game")

  
    (**else if l_type = "two player" then main_two_player ()
    else if l_type = "quit" then (print_endline("Goodbye!"); exit 0;)
    else failwith "Not a valid player configuration"
  with _ -> game_setting ()*)

let rec main () =
  try
    let move =
      print_endline "Please enter a move:";
      read_line () in let move2 = parse move in 
      new_turn grid move2;
      print_column_label grid;
      print_grid grid 1
  with _ -> main ()

let () = main ()