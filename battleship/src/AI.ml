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

let randomgrid =
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

let () = Random.self_init ()
let ywing = { ship = Ship1; length = 2 }
let xwing = { ship = Ship2; length = 3 }
let mfalcon = { ship = Ship3; length = 3 }
let delta7 = { ship = Ship4; length = 4 }
let stardestroyer = { ship = Ship5; length = 5 }
let shipList = [ ywing; xwing; mfalcon; delta7; stardestroyer ]

let letter_randomizer () =
  let random_int = Random.int 10 + 65 in
  chr random_int

let number_randomizer () =
  let random_int = Random.int 10 in
  random_int + 1

let is_occupied grid (col, row) =
  let char_code = Char.code col in
  if row >= 1 && row <= 10 && char_code >= 65 && char_code <= 74 then
    let row_arr = List.nth grid (row - 1) in
    row_arr.(char_code - 65) = "#"
  else false

let coord () = (letter_randomizer (), number_randomizer ())

let rec generate_ship_coords len coord dir acc =
  match (len, coord, dir) with
  | 0, _, _ -> acc
  | _, (c, n), 'h' when Char.code c < Char.code 'J' ->
      let new_coord = (Char.chr (Char.code c + 1), n) in
      if Char.code (fst new_coord) <= Char.code 'J' then
        generate_ship_coords (len - 1) new_coord 'h' (new_coord :: acc)
      else acc
  | _, (c, n), 'v' when n < 10 ->
      let new_coord = (c, n + 1) in
      if snd new_coord <= 10 then
        generate_ship_coords (len - 1) new_coord 'v' (new_coord :: acc)
      else acc
  | _, _, _ -> acc

let rec place_ship grid (ship : ships) ship_coords =
  let length = ship.length in
  let col, row = coord () in
  let direction = if Random.bool () then 'h' else 'v' in
  let coords =
    (col, row) :: generate_ship_coords (length - 1) (col, row) direction []
  in
  if
    List.length coords = length
    && List.for_all (fun c -> not (is_occupied grid c)) coords
    && not (List.exists (fun coord -> List.mem coord ship_coords) coords)
  then coords
  else place_ship grid ship ship_coords

let ywingCoords = place_ship randomgrid ywing []
let xwingCoords = place_ship randomgrid xwing ywingCoords
let mfalconCoords = place_ship randomgrid mfalcon (ywingCoords @ xwingCoords)

let delta7Coords =
  place_ship randomgrid delta7 (ywingCoords @ xwingCoords @ mfalconCoords)

let stardestroyerCoords =
  place_ship randomgrid stardestroyer
    (ywingCoords @ xwingCoords @ mfalconCoords @ delta7Coords)

let place_ship_on_grid grid ship_coords =
  let update_grid row col =
    let row_arr = List.nth grid row in
    row_arr.(col) <- "#"
  in
  let rec loop coords =
    match coords with
    | [] -> ()
    | (col, row) :: rest ->
        let char_code = Char.code col in
        if row >= 1 && row <= 10 && char_code >= 65 && char_code <= 74 then
          update_grid (row - 1) (char_code - 65);
        loop rest
  in
  loop ship_coords

let _ = place_ship_on_grid randomgrid ywingCoords
let _ = place_ship_on_grid randomgrid xwingCoords
let _ = place_ship_on_grid randomgrid mfalconCoords
let _ = place_ship_on_grid randomgrid delta7Coords
let _ = place_ship_on_grid randomgrid stardestroyerCoords

(*----------------------------------------------------------------------------------------------------------------
  OPPOSING PLAYER MOVEMENT
  --------------------------------------------------------------------------------------------------------------*)

let random_coord () =
  let random_col = Random.int 10 + 65 in
  let random_row = Random.int 10 in
  (chr random_col, random_row)

let neighboring_points board =
  let neighbors (col, row) =
    let char_code = Char.code col in
    let directions = [ (-1, 0); (1, 0); (0, -1); (0, 1) ] in
    List.filter
      (fun (c, r) ->
        r >= 0 && r <= 9 && c >= 65 && c <= 74
        && (List.nth board r).(c - 65) <> "o"
        && (List.nth board r).(c - 65) <> "x")
      (List.map (fun (dc, dr) -> (char_code + dc, row + dr)) directions)
  in
  List.fold_left
    (fun acc row_arr ->
      List.fold_left
        (fun inner_acc cell ->
          let col, row = cell in
          if (List.nth board row).(Char.code col - 65) = "x" then
            inner_acc @ neighbors (col, row)
          else inner_acc)
        acc (Array.to_list row_arr))
    []
    (List.mapi
       (fun i row -> Array.mapi (fun j cell -> (Char.chr (j + 65), i)) row)
       board)

let rec pick_random_point board =
  let available_neighbors = neighboring_points board in
  let col_code, row =
    if List.length available_neighbors > 0 then
      List.nth available_neighbors
        (Random.int (List.length available_neighbors))
    else
      let col, row = random_coord () in
      (Char.code col, row)
  in
  match (List.nth board row).(col_code - 65) with
  | "o" | "x" -> pick_random_point board
  | "#" ->
      (List.nth board row).(col_code - 65) <- "x";
      (Char.chr col_code, row + 1, "x")
      (* Return the updated coordinate and the symbol placed *)
  | _ ->
      (List.nth board row).(col_code - 65) <- "o";
      (Char.chr col_code, row + 1, "o")
(* Return the updated coordinate and the symbol placed *)
