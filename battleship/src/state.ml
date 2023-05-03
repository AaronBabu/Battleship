open Battleship

exception Illegal

type t = string array list

let index (c : char) : int = Char.code c - Char.code 'A'
let init_state = make_play

let new_turn s position =
  let positionupper = String.uppercase_ascii (fst position) in
  let row = int_of_string (snd position) - 1 |> List.nth s in
  let col = index positionupper.[0] in
  if Array.get row col = " " then Array.set row col "o"
  else if Array.get row col = "x" || Array.get row col = "o" then raise Illegal
  else Array.set row col "x"

(* let place_ship1 (position : direction * string * string) : unit list list =
   let dir = match position with | d, _, _ -> d in let col = match position with
   | _, c, _ -> String.get c 0 in let row = match position with | _, _, r ->
   int_of_string r in print_ship1 dir (col, row)

   let place_ship2 (position : direction * string * string) : unit list list =
   let dir = match position with | d, _, _ -> d in let col = match position with
   | _, c, _ -> String.get c 0 in let row = match position with | _, _, r ->
   int_of_string r in print_ship2 dir (col, row)

   let place_ship3 (position : direction * string * string) : unit list list =
   let dir = match position with | d, _, _ -> d in let col = match position with
   | _, c, _ -> String.get c 0 in let row = match position with | _, _, r ->
   int_of_string r in print_ship3 dir (col, row)

   let place_ship4 (position : direction * string * string) : unit list list =
   let dir = match position with | d, _, _ -> d in let col = match position with
   | _, c, _ -> String.get c 0 in let row = match position with | _, _, r ->
   int_of_string r in print_ship4 dir (col, row)

   let place_ship5 (position : direction * string * string) : unit list list =
   let dir = match position with | d, _, _ -> d in let col = match position with
   | _, c, _ -> String.get c 0 in let row = match position with | _, _, r ->
   int_of_string r in print_ship5 dir (col, row) (* let dir = List.nth position
   0 in let col = String.get (List.nth position 1) 0 in let row = int_of_string
   (List.nth position 2) in print_ship1 dir (col, row) *)

   use ship command parsing function to place ship *)
