(* Define the grid dimensions *)
let num_rows = 10
let num_cols = 10

(* Define a helper function to print a single cell *)
let print_cell () = print_string "|__|"

(* Define a function to print the entire grid with row and column labels *)
let print_grid ()=
  (* Print the column labels *)
  print_string "    ";
  for j = 1 to num_cols do
    print_string (Char.escaped (Char.chr (j + 64))); (* convert column number to letter *)
    print_string "   "
  done;
  print_newline ();

  (* Print the rows with labels and cells *)
  for i = 1 to num_rows do
    print_int i; (* print row label *)
    if i < 10 then print_string " "; (* add space for single digit row numbers *)
    print_string " ";
    for j = 1 to num_cols do
      print_cell ()
    done;
    print_newline ()
  done


(* Call the print_grid function to print the grid *)
let _=print_grid ()

let grid= [["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]; 
["__";"__"; "x"; "x"; "__"; "o"; "__"; "x"; "o"; "__"]]
let print_elements arr start_row end_row start_col end_col =
  for i = start_row to end_row do
    for j = start_col to end_col do
      print_int arr.(i).(j);
    done;
    print_newline ();
  done

