open Lib
(** [play_game f] starts the game with state [g]. *)

open Battleship
open AI
open State

type object_phrase = string * string
type command = Shoot of object_phrase

exception Empty
exception Malformed
exception Quit
exception Win 
exception Lose

let player_board_for_transfer =
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

let parse string : string * string =
  let start_lst = String.split_on_char ' ' string in
  let end_list = List.filter (fun x -> String.length x != 0) start_lst in
  let m_list = List.map (fun x -> String.lowercase_ascii x) end_list in
  match m_list with
  | [] -> raise Empty
  | [ "quit" ] -> raise Quit
  | "shoot" :: tl1 :: tl2 -> (tl1, List.hd tl2)
  | [ "win" ] -> ("Win", "Checker")
  | _ -> raise Malformed

let parse2 string : direction * char * int =
  let start_lst = String.split_on_char ' ' string in
  let end_list = List.filter (fun x -> String.length x != 0) start_lst in
  let m_list = List.map (fun x -> String.lowercase_ascii x) end_list in
  match m_list with
  | [] -> raise Empty
  | "place" :: dir :: col :: row -> (
      match dir with
      | "left" ->
          ( Left,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "Left" ->
          ( Left,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "right" ->
          ( Right,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "Right" ->
          ( Right,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "up" ->
          ( Up,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "Up" ->
          ( Up,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "down" ->
          ( Down,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | "Down" ->
          ( Down,
            String.get (String.uppercase_ascii col) 0,
            int_of_string (List.hd row) )
      | _ -> raise Malformed)
  | _ -> raise Malformed

let reset_board () = List.map (fun row -> Array.copy row) randomgrid
let player_board () = List.map (fun row -> Array.copy row) player_grid

let rec play_game grid grid2 string =
  try
    if check_hit_count grid then raise Win
    else ();
    if check_hit_count grid2 then raise Lose
    else ();
    let move2 = parse string in
    new_turn grid move2;
    let _ = pick_random_point grid2 in
    print_endline "\n AI board \n";
    print_column_label grid;
    print_grid_ai grid 1;
    print_endline "\n Player board \n";
    print_column_label grid2;
    print_grid grid2 1;
    print_endline "\n Choose a target: \n";
    let line = read_line () in
    play_game grid grid2 line
    
  with
  | Quit -> print_endline "Quitting"
  | Win -> print_endline "You Won!"
  | Lose -> print_endline "You Lose!"
  | _ ->
      print_endline "\n Choose a target: \n";
      let line = read_line () in
      play_game grid grid2 line

let instructions () =
  print_string
    "Hello and welcome to Battleship!\n\
    \    Before you start your battle we must run you through everything you \
     as a player need to know.\n\n\
    \    To start off:\n\
    \      The objective of the game is to sink all 5 of your opponent's ships.\n\
    \    \n\
    \    Rules:\n\
    \      You are going to choose where you would like to place all 5 of your \
     ships.\n\
    \      Everyone's ships may be placed horizontally or vertically, but \
     never diagonally.\n\
    \      These ships will all be of different lengths. One will be of length \
     2, two of length 3, \n\
    \      one of length 4, one of length 5.\n\
    \      You must hit all parts of the ship to get a point.\n\
    \      However, you do not know where your opponent's ships are located, \n\
    \      this is where the fun begins.\n\n\
    \    How to play:\n\
    \      You have ammo that can be shot at any coordinate on your opponent's \
     board. \n\
    \      To hit a spot on the board you must type in the command line “shoot \
     *row letter* *column number*” \n\
    \      If the ammo hits an empty spot and O will appear.\n\
    \      If a ship is hit at one of the points, an X will appear at that \
     exact point \n\
    \      Once you hit all parts of the ship a point will be added to your \
     score. \n\
    \      When your score hits zero you win the game. \n\
    \      If you want to quit at anytime press ctrl + c on your keyboard.\n\n\
    \    Warning:\n\
    \      Your opponent will also try to hit your ships.\n\
    \      If your opponent hits your ship “Your opponent hit part of your \
     ship” will appear.\n\
    \      If you opponent hits your entire ship “Your opponent hit your \
     entire ship. Protect the *amount of ships left* you have left” will \
     appear.";

  print_endline "\n Happy playing! \n"

let first (a, b, c) = a
let second (a, b, c) = b
let third (a, b, c) = c

let rec place_ship1 grid string =
  try
    let place = parse2 string in
    let _ = print_ship1 grid (first place) (second place, third place) in
    ()
  with exn ->
    print_endline ("Error: " ^ Printexc.to_string exn);
    let line = read_line () in
    place_ship1 grid line

let rec place_ship2 grid string =
  try
    let place = parse2 string in
    let _ = print_ship2 grid (first place) (second place, third place) in
    ()
  with _ ->
    let line = read_line () in
    place_ship2 grid line

let rec place_ship3 grid string =
  try
    let place = parse2 string in
    let _ = print_ship3 grid (first place) (second place, third place) in
    ()
  with _ ->
    let line = read_line () in
    place_ship3 grid line

let rec place_ship4 grid string =
  try
    let place = parse2 string in
    let _ = print_ship4 grid (first place) (second place, third place) in
    ()
  with _ ->
    let line = read_line () in
    place_ship4 grid line

let rec place_ship5 grid string =
  try
    let place = parse2 string in
    let _ = print_ship5 grid (first place) (second place, third place) in
    ()
  with _ ->
    let line = read_line () in
    place_ship5 grid line

let main () =
  let instruct = instructions () in
  instruct;
  let grid1 = reset_board () in
  let grid2 = player_board () in
  print_column_label grid2;
  print_grid grid2 1;
  print_endline "\n Place ship 1 - Size 2 \n";
  let line = read_line () in
  place_ship1 grid2 line;
  print_column_label grid2;
  print_grid grid2 1;
  print_endline "\n Place ship 2 - Size 3 \n";
  let line = read_line () in
  place_ship2 grid2 line;
  print_column_label grid2;
  print_grid grid2 1;
  print_endline "\n Place ship 3 - Size 3 \n";
  let line = read_line () in
  place_ship3 grid2 line;
  print_column_label grid2;
  print_grid grid2 1;
  print_endline "\n Place ship 4 - Size 4 \n";
  let line = read_line () in
  place_ship4 grid2 line;
  print_column_label grid2;
  print_grid grid2 1;
  print_endline "\n Place ship 5 - Size 5 \n";
  let line = read_line () in
  place_ship5 grid2 line;
  print_column_label grid2;
  print_grid grid2 1;
  print_endline "\n AI board \n";
  print_endline "Choose a target:";
  let line = read_line () in
  play_game grid1 grid2 line

let () = main ()
