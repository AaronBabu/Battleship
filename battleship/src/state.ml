open Battleship

exception Illegal

type t = string array list

let index (c : char) : int = Char.code c - Char.code 'A'
let init_state = make_play
let score = ref 0
let update_score score = score := !score + 1
let current_score () = !score

let new_turn s position =
  let hit = false in
  let positionupper = String.uppercase_ascii (fst position) in
  let row = int_of_string (snd position) - 1 |> List.nth s in
  let col = index positionupper.[0] in
  if Array.get row col = " " then Array.set row col "o"
  else if Array.get row col = "x" || Array.get row col = "o" then raise Illegal
  else
    let hit = true in
    Array.set row col "x";
    if hit then update_score score

(* use ship command parsing function to place ship *)
