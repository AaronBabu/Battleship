open Battleship

exception Illegal

type t = string array list

let index (c : char) : int = Char.code c - Char.code 'A'
let init_state = make_play

let new_turn s position =
  let row = int_of_string (snd position) - 1 |> List.nth s in
  let col = index (fst position).[0] in
  if Array.get row col = " " then Array.set row col "o"
  else if Array.get row col = "x" || Array.get row col = "o" then raise Illegal
  else Array.set row col "x"

(*use ship command parsing function to place ship*)
