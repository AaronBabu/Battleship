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

let create_endcoords_shiplength2 (direction : direction)
    ((char, int) : char * int) : char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = index char - 1 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = index char + 1 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int - 1 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int + 1 in
      (char, new_int)

let create_endcoords_shiplength3 (direction : direction)
    ((char, int) : char * int) : char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = index char - 2 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = index char + 2 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int - 2 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int + 2 in
      (char, new_int)

let create_endcoords_shiplength4 (direction : direction)
    ((char, int) : char * int) : char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = index char - 3 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = index char + 3 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int - 3 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int + 3 in
      (char, new_int)

let create_endcoords_shiplength5 (direction : direction)
    ((char, int) : char * int) : char * int =
  match (direction, char, int) with
  | Left, _, _ ->
      let new_char_int = index char - 4 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Right, _, _ ->
      let new_char_int = index char + 4 in
      let new_char = inverse_index new_char_int in
      (new_char, int)
  | Up, _, _ ->
      let new_int = int - 4 in
      (char, new_int)
  | Down, _, _ ->
      let new_int = int + 4 in
      (char, new_int)

let print_ship start_row start_col end_row end_col =
  [
    (if end_col > start_col || end_row > start_row then
     for x = start_row - 1 to end_row - 1 do
       for y = start_col to end_col do
         let row_arr = List.nth player_grid x in
         row_arr.(y) <- "#"
       done
     done);
    (if end_col < start_col || end_row < start_row then
     for x = start_row - 1 downto end_row - 1 do
       for y = start_col downto end_col do
         let row_arr = List.nth player_grid x in
         row_arr.(y) <- "#"
       done
     done);
  ]

let print_ship1 (direction : direction) ((char, int) : char * int) =
  [
    (let start_col = Char.code char - 65 in
     let start_row = int in
     print_int start_col;
     print_int start_row;
     let end_col, end_row =
       create_endcoords_shiplength2 direction (char, int)
     in
     let new_end_col = Char.code end_col - 65 in
     let ship1_start_row = start_row in
     let ship1_start_col = start_col in
     let ship1_end_row = end_row in
     let ship1_end_col = new_end_col in
     print_int ship1_end_col;
     print_int ship1_end_row;
     print_ship ship1_start_row ship1_start_col ship1_end_row ship1_end_col);
  ]

let print_ship2 (direction : direction) ((char, int) : char * int) =
  [
    (let start_col = Char.code char - 65 in
     let start_row = int in
     let end_col, end_row =
       create_endcoords_shiplength3 direction (char, int)
     in
     let new_end_col = Char.code end_col - 65 in
     let ship2_start_row = start_row in
     let ship2_start_col = start_col in
     let ship2_end_row = end_row in
     let ship2_end_col = new_end_col in
     print_ship ship2_start_row ship2_start_col ship2_end_row ship2_end_col);
  ]

let print_ship3 (direction : direction) ((char, int) : char * int) =
  [
    (let start_col = Char.code char - 65 in
     let start_row = int in
     let end_col, end_row =
       create_endcoords_shiplength2 direction (char, int)
     in
     let new_end_col = Char.code end_col - 65 in
     let ship3_start_row = start_row in
     let ship3_start_col = start_col in
     let ship3_end_row = end_row in
     let ship3_end_col = new_end_col in
     print_ship ship3_start_row ship3_start_col ship3_end_row ship3_end_col);
  ]

let print_ship4 (direction : direction) ((char, int) : char * int) =
  [
    (let start_col = Char.code char - 65 in
     let start_row = int in
     let end_col, end_row =
       create_endcoords_shiplength4 direction (char, int)
     in
     let new_end_col = Char.code end_col - 65 in
     let ship4_start_row = start_row in
     let ship4_start_col = start_col in
     let ship4_end_row = end_row in
     let ship4_end_col = new_end_col in
     print_ship ship4_start_row ship4_start_col ship4_end_row ship4_end_col);
  ]

let print_ship5 (direction : direction) ((char, int) : char * int) =
  [
    (let start_col = Char.code char - 65 in
     let start_row = int in
     let end_col, end_row =
       create_endcoords_shiplength5 direction (char, int)
     in
     let new_end_col = Char.code end_col - 65 in
     let ship5_start_row = start_row in
     let ship5_start_col = start_col in
     let ship5_end_row = end_row in
     let ship5_end_col = new_end_col in
     print_ship ship5_start_row ship5_start_col ship5_end_row ship5_end_col);
  ]

(* let _ = print_ship4 Right ('B', 4) let _ = print_ship1 Left ('E', 7) let _ =
   print_ship2 Down ('A', 1) let _ = print_ship3 Up ('D', 10) let _ =
   print_ship5 Left ('H', 3) *)
