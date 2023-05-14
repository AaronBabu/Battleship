(*mli for parse.ml file*)
open Battleship

exception Empty
exception Malformed
exception Quit
exception Win
exception Lose

val parse : string -> string * string
(**[parse string] takes in a string that contains the player's action and parses
   the string to extract information about the players action which outputs a
   tuple containing two strings where the first string indicates the action of
   the player such as "shoot" or "quit" and the second string contains the
   coordinates of the grid they want to shoot into such as "a 4". Raises [Empty]
   if string input is empty. Raises [Malformed] if string is an invalid. Raises
   [Quit] if input string is "quit".*)

val parse2 : string -> direction * char * int
(**[parse string] takes in a string that contains the player's action and parses
   the string for placing a ship into a tuple containing its direction,
   character column of where the ship starts, and integer row coordinates of
   where the ship starts. Raises [Empty] if string input is empty. Raises
   [Malformed] if string is an invalid. *)
