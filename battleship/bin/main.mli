(**mli for main.ml file*)

type object_phrase = string * string
type command = Shoot of object_phrase

exception Empty
exception Malformed
exception Quit
exception Win
exception Lose

val player_board_for_transfer : string array list
(**[player_board_for_transfer] is the original board for the player. *)

val reset_board : unit -> string array list
(** [reset_board] resets the board back to its original state. *)

val player_board : unit -> string array list
(**[player_board] sets the board to be the player's board. *)

val print_score : int -> unit
(**[print_score score] takes in a score and prints it. *)

val play_game : string array list -> string array list -> string -> unit
(**[play_game grid grid2 string] takes in the player's grid and the ai's grid as
   arguments. This function checks if the player or ai won throughout the game.
   It prompts the player to choose a target and calls parse to read the player's
   input. Raise [Won] if all ships on ai's board are hit. Raise [Lose] if all
   ships on player's board are hit. *)

val instructions : unit -> unit
(**[instructions] prints out the instructions for the game. This includes the
   objective, general rules, and how to play. *)

val first : 'a * 'b * 'c -> 'a
(**[first (a, b, c)] takes in a triple returns the first element. *)

val second : 'a * 'b * 'c -> 'b
(**[second (a, b, c)] takes in a triple and returns the second element. *)

val third : 'a * 'b * 'c -> 'c
(**[third (a, b, c)] takes in a triple and returns the third element. *)

val place_ship1 : string array list -> string -> unit
(**[place_shipq grid string] takes in a grid and string. This function calls
   parse2 on the string and places ship1 on the given grid in the given
   coordinates and direction. *)

val place_ship2 : string array list -> string -> unit
(**[place_shipq grid string] takes in a grid and string. This function calls
   parse2 on the string and places ship2 on the given grid in the given
   coordinates and direction. *)

val place_ship3 : string array list -> string -> unit
(**[place_shipq grid string] takes in a grid and string. This function calls
   parse2 on the string and places ship3 on the given grid in the given
   coordinates and direction. *)

val place_ship4 : string array list -> string -> unit
(**[place_shipq grid string] takes in a grid and string. This function calls
   parse2 on the string and places ship4 on the given grid in the given
   coordinates and direction. *)

val place_ship5 : string array list -> string -> unit
(**[place_shipq grid string] takes in a grid and string. This function calls
   parse2 on the string and places ship5 on the given grid in the given
   coordinates and direction. *)

val main : unit -> unit
(**[main] prints the ai and player's board in the terminal. This function promts
   the player to place their 5 ships and calls the place_ship functions to print
   them in the terminal. *)
