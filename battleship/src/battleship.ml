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
  Array.iter (fun x -> print_string ("| " ^ x ^ s " ")) row;
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

let grid =
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
let _ = print_column_label grid
let _ = print_grid grid 1

let make_play =
  print_column_label grid;
  print_grid grid 1;
  grid

type ship =
  | Ship1
  | Ship2
  | Ship3
  | Ship4
  | Ship5

type ships = {
  ship : ship;
  length : int;
}
