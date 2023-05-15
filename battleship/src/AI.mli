open Random
open Char 

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

val randomgrid : string array list
(** [randomgrid] is a string array list which creates the grid for the ai*)
val ywing : ships
(**[ywing] generates ship1 with length 2 for the grid*)
val xwing : ships
(**[xwing] generates ship2 with length 3 for the grid*)
val mfalcon : ship
(**[mfalcon] generates ship3 with length 3 for the grid*)
val delta7 : ships
(**[delta7] generates ship4 with length 4 for the grid  *)
val stardestroyer : ships
(**[stardestroyer] generates ship5 with length 5 for the grid*)
val shipList : ships list
(** [shiplist] is a list that contains all five ships with lengths 2,3,4,5*)
val letter_randomizer : unit -> t
(**[letter_randomizer ()] takes in unit and randomizes the letters for the ai grid*)
val number_randomizer : unit -> int
(**[number_randomizer ()] takes in unit and randomizes the numbers for the ai grid*)
val is_occupied : string array list -> t * int -> bool
(** [is_occupied grid (col,row)] takes in the grid for the battleship and a pair
    (col,row) representing the column and row of the cell to check. If the cell
    is occupied by a ship it returns true else false *)
val coord : unit -> t * int
(**[coord ()] takes in unit and generates a random coordinate pair (column 
    letter, row number) for the ai*)
val generate_ship_coords : int -> t * int -> t -> (t*int) list -> (t*int) list
(** [generate_ship_coords len coord dir acc] takes in len which represents the 
    length of the ship, coord which is a tuple that represents the start of the 
    ship, dir which represents the direction of the ship, acc which represents 
    the current list of ship coordinates being generated which all outputs 
    the final list of ship coordinates generated. *)
val place_ship : string array list -> ships -> (t*int) list -> (t* int) list 
(** [place_ships grid ships ship_coords] takes in a grid which represents the 
    battleship grid, a ship to be placed on the grid, and ship_coords which is 
    a list of coordinates that have already been place on the grid which outputs
     a list of coordinates for the new ship being placed. *)
val ywingCoords: (t*int) list
(** [ywingCoords] places ywing on the random grid by 
    calling place_ship passing ywing and [] to represent the occupied 
    coordinates from before which all returns the current coordinates 
    of the ship *)
val xwingCoords : (t*int) list 
(** [xwingCoords] places xwing on the random grid by calling place_ship passing
    xwing and ywing to represent the occupied coordinates from before which 
    all returns the current coordinates of the ship*)
val mfalconCoords : (t*int) list
(** [mfalconCoords] places mfalcon on the random grid by calling 
    place_ship passing mfalcon and (xwing @ ywing) to represent the occupied 
    coordinates from before which all returns the current coordinates of the 
    ship*)
val delta7Coords: (t*int) list
(**[delta7Coords] places delta7 on the random grid by calling place_ship passing
    delta7 and (mfalcon @ xwing @ ywing) to represent the occupied coordinates
    from before which all returns the current coordinates of the ship*)
val stardestroyerCoords : (t*int) list
(**[stardestroyer] places stardestroyer on the random grid by calling place_ship
    by passing stardestroyer and (delta7 @ mfalcon @ xwing @ ywing) to represent 
    the occupied coordinates from before which all returns the current 
    coordinates of the ship*)
val place_ship_on_grid: string array list -> (t *int) list -> unit 
(**[place_ship_on_grid grid ship_coords] which takes in a grid and a list of the 
 pairs of ship coordinates which all updates the input grid with the coordinates
    of the ship which is represented by the ship_coords list*)
val random_coord : unit -> (t*int)
(**[random_coord ()] takes in unit and generates a random column letter from A-J
    and a random row number from 1-10 to create a random pair of coordinates. *)
val neighboring_points : string array list -> (int*int) list
(**[neighboring_points board] which picks the neighboring points*)
val pick_random_point : string array list -> (t*int * string)
(** [pick_random_point board] which picks a random point on the board, updates 
    the point with "x" if hit or "o" if missed and outputs the updated 
      coordinate with its symbol. *)
