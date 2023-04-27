open AI

(* Define the grid dimensions *)
let num_rows = 10
let num_cols = 10

(* Define a helper function to print a single cell *)

let num_columns array =
  match array with
  | [] -> 0
  | h :: t -> Array.length h

let rec get_rowlines n acc =
  if n = 0 then "" else get_rowlines (n - 1) acc ^ "+---"

let print_rowlines n = print_string ("  " ^ get_rowlines n "" ^ "+")

let rec print_row row : unit =
  Array.iter (fun x -> print_string ("| " ^ x ^ " ")) row;
  print_string "|"

let print_column_label array =
  let num_cols = num_columns array in
  print_string "    ";
  for j = 1 to num_cols do
    print_string (Char.escaped (Char.chr (j + 64)));
    (* convert column number to letter *)
    print_string "   "
  done;
  print_newline ();
  print_rowlines num_cols;
  print_newline ()

(* Define a function to print the entire grid with row and column labels *)
let rec print_grid array (row_idx : int) =
  let single = if row_idx < 10 then true else false in
  let columns = num_columns array in
  match array with
  | [] -> print_string ""
  | h :: t ->
      print_int row_idx;
      if single then print_string " " else print_string "";
      print_row h;
      print_endline "";
      print_rowlines columns;
      print_endline "";
      print_grid t (row_idx + 1)

let player_grid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

(* Call the print_grid function to print the grid *)
let _ = print_column_label player_grid
let _ = print_grid player_grid 1

let make_play =
  print_column_label player_grid;
  print_grid player_grid 1;
  player_grid

let playership1 = { ship = Ship1; length = 2 }
let playership2 = { ship = Ship2; length = 3 }
let playership3 = { ship = Ship3; length = 3 }
let playership4 = { ship = Ship4; length = 4 }
let playership5 = { ship = Ship5; length = 5 }

type direction =
  | Left
  | Right
  | Up
  | Down

let inverse_char_code (index : int) : char =
  let code = index + 65 in
  Char.chr code

let place_shiplength_2 (direction : direction) ((char, int) : char * int) :
    char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = Char.code char - 2 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = Char.code char + 2 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int + 2 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int - 2 in
      (char, new_int)

let place_shiplength_3 (direction : direction) ((char, int) : char * int) :
    char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = Char.code char - 3 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = Char.code char + 3 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int + 3 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int - 3 in
      (char, new_int)

let place_shiplength_4 (direction : direction) ((char, int) : char * int) :
    char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = Char.code char - 4 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = Char.code char + 4 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int + 4 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int - 4 in
      (char, new_int)

let place_shiplength_5 (direction : direction) ((char, int) : char * int) :
    char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = Char.code char - 5 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = Char.code char + 5 in
      let new_char = inverse_char_code new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int + 5 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int - 5 in
      (char, new_int)
