(*mli for parse.ml file*)
open Battleship

exception Empty
exception Malformed
exception Quit
exception Win
exception Lose

val parse : string -> string * string
val parse2 : string -> direction * char * int
