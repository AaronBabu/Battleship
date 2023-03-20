(*mli for the state.ml file*)

(**The compilation for state focuses on state logic pertaining to each state of
   a battleship game. Each state will consist of 2D list of string. This will
   keep track of position, hits, misses, ships. The symbols are as follows in
   the 2D list

   (Subject to change) hit = "x" miss = "o" unhit ship = "."*)

exception Illegal

type t = string array list
(** The abtract type (string list list) of values that represent board state*)

val init_state : t
(** [init_state s] is the board state that [s] represents. Requires: [s] is a
    valis string array list*)

val new_turn : t -> string * string -> unit
(** [new_turn s position] is the result of new turn taken by a player given a
    state [s] and a position that is being targeted [position]. [position] will
    come in the form (string * string) where the first string is a letter and
    the second string is a number. For example, ("A", "2") would shoot at
    position A2.

    If a position has a unhit ship on it, position turns to "x"

    If a position has a hit ship on it, the result is [Illegal x]

    If a position has a already hit marker "o", the result is [Illegal x]

    If a position has nothing on it, position turns to "o"

    Effecs: none. *)
