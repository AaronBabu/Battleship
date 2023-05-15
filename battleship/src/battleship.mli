(*mli for the battleship.ml file *)
open AI

val num_rows : int
(** [num_rows] is the number of rows in the grid*)

val num_cols : int
(** [num_cols] is the number of rows in the grid*)

val num_columns : 'a array list -> int
(** [num_columns array] which takes in an array and counts the number of columns
    and returns [] if array is empty*)

val get_rowlines : int -> 'a -> string
(**[get_rowlines n acc] takes an int n and acc and returns the rowlines of the
   grid*)

val print_rowlines : int -> unit
(**[print_rowlines n] takes an int n and print rowlines of the grid*)

val print_rowlines_ai : int -> unit
(**[print_rowlines n] takes an int n and print rowlines of the grid for the ai*)

val print_row : string array -> unit
(** [print_row row] takes in row and prints each row of the grid*)

val print_row_ai : string array -> unit
(** [print_row_ai row] takes in row and prints each row of the grid for the ai*)

val print_column_label : 'a array list -> unit
(**[print_column_label array] takes in an array and prints the labels of column
   of the grid. *)

val print_column_label_ai : 'a array list -> unit
(**[print_column_label array] takes in an array and prints the labels of column for the ai
   of the grid. *)

val print_grid : string array list -> int -> unit
(**[print_grid array row_idx] takes in an array and int row_idx which represents
   the index of a row and prints the entire grid with row and column labels. *)

val print_grid_ai : string array list -> int -> unit
(**[print_grid_ai array row_idx] takes in an array and int row_idx which
   represents the index of a row and prints the entire grid with row and column
   labels. *)

val player_grid : string array list
(**[player_grid] is a representation of the player grid. *)

val make_play : string array list
(**[make_play] allows the user to begin playing by printing the player grid to
   begin playing. *)

val playership1 : ships
(** [playership1] creates the first playership with length 2. *)

val playership2 : ships
(** [playership2] creates the first playership with length 3. *)

val playership3 : ships
(** [playership3] creates the first playership with length 3. *)

val playership4 : ships
(** [playership4] creates the first playership with length 4. *)

val playership5 : ships
(**[playership5] creates the first playership with length 5. *)

type direction =
  | Left
  | Right
  | Up
  | Down

val index : char -> int
(** [index c ] accesses the index or position of a char c and returns the
    integer representation of the char.*)

val inverse_index : int -> char
(** [inverse_index i] acesses the inverse index i and outputs a char based on
    the index.*)

val create_endcoords_shiplength2 : direction -> char * int -> char * int
(**[create_endcoords_shiplength2 direction (char,int)] takes in a valid
   direction (Up,Down,Left,Right) and a pair of valid coordinates (char,int) and
   outputs the endcoordinates of a ship of length two that starts at the
   coordinate and extends in the input direction. *)

val create_endcoords_shiplength3 : direction -> char * int -> char * int
(**[create_endcoords_shiplength3 direction (char,int)] takes in a valid
   direction (Up,Down,Left,Right) and a pair of valid coordinates (char,int) and
   outputs the endcoordinates of a ship of length three that starts at the
   coordinate and extends in the input direction. *)

val create_endcoords_shiplength4 : direction -> char * int -> char * int
(**[create_endcoords_shiplength4 direction (char,int)] takes in a valid
   direction (Up,Down,Left,Right) and a pair of valid coordinates (char,int) and
   outputs the endcoordinates of a ship of length four that starts at the
   coordinate and extends in the input direction. *)

val create_endcoords_shiplength5 : direction -> char * int -> char * int
(**[create_endcoords_shiplength5 direction (char,int)] takes in a valid
   direction (Up,Down,Left,Right) and a pair of valid coordinates (char,int) and
   outputs the endcoordinates of a ship of length four that starts at the
   coordinate and extends in the input direction. *)

val print_ship : string array list -> int -> int -> int -> int -> unit list
(** [print_ship input_grid start_row start_col end_row end_col] takes in input
    grid with a valid grid with ship locations and misses and hits, takes in
    start_row, end_row, start_col, end_col which represent the end points of the
    ship on the grid as valid coordinates, and prints the updated input_grid
    with the ship location marked with #. *)

val print_ship1 : string array list -> direction -> char * int -> unit list list
(**[print_ship1 input_grid direction (char,int)] takes in a valid input_grid and
   a valid direction (Up,Down,Left,Right) and a pair of valid coordinates
   (char,int) which is a starting postition for a ship on the board and prints
   the updated input_grid. *)

val print_ship2 : string array list -> direction -> char * int -> unit list list
(**[print_ship2 input_grid direction (char,int)] takes in a valid input_grid and
   a valid direction (Up,Down,Left,Right) and a pair of valid coordinates
   (char,int) which is a starting postition for a ship on the board and prints
   the updated input_grid. *)

val print_ship3 : string array list -> direction -> char * int -> unit list list
(**[print_ship3 input_grid direction (char,int)] takes in a valid input_grid and
   a valid direction (Up,Down,Left,Right) and a pair of valid coordinates
   (char,int) which is a starting postition for a ship on the board and prints
   the updated input_grid. *)

val print_ship4 : string array list -> direction -> char * int -> unit list list
(**[print_ship4 input_grid direction (char,int)] takes in a valid input_grid and
   a valid direction (Up,Down,Left,Right) and a pair of valid coordinates
   (char,int) which is a starting postition for a ship on the board and prints
   the updated input_grid. *)

val print_ship5 : string array list -> direction -> char * int -> unit list list
(**[print_ship5 input_grid direction (char,int)] takes in a valid input_grid and
   a valid direction (Up,Down,Left,Right) and a pair of valid coordinates
   (char,int) which is a starting postition for a ship on the board and prints
   the updated input_grid. *)

val check_hit_count : string array list -> bool
(**[check_hit_count grid] takes in a grid which represents the number of states
   on the board and returns true if all the ships have been hit when the total
   number of "x"'s equal 17 or false otherwise. *)
