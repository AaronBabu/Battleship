open Lib
(** [play_game f] starts the game with state [g]. *)

open Battleship
open AI
open State
open Parse
open ANSITerminal

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

let reset_board () = List.map (fun row -> Array.copy row) randomgrid
let player_board () = List.map (fun row -> Array.copy row) player_grid
let print_score score = print_string [green] ("Your score is: " ^ string_of_int score ^ "\n")
let print_score_ai score = print_string [green] ("AI score is: " ^ string_of_int score ^ "\n")
let print_misses score = print_string [green] ("Missed shots: " ^ string_of_int score ^ "\n")

(* let print_phrase p = if p then print_endline "Ouch! You hit my ship :(" else
   print_endline "Haha you missed!" *)
(* let colorize_ship (s : ship) : string = let open ANSITerminal in match s with
   | Ship1 -> sprintf [ Bold; blue ] "C" | Ship2 -> sprintf [ Bold; green ] "B"
   | Ship3 -> sprintf [ Bold; magenta ] "R" | Ship4 -> sprintf [ Bold; yellow ]
   "S" | Ship5 -> sprintf [ Bold; red ] "D" *)

   let ai_phrases = [
    "Nice shot";
    "You'll never find my ships";
    "Better lookout";
    "Is that the best you can do?";
    "You're going to need a bigger boat";
    "Missed me by a mile!";
    "You're not even close";
    "I can do this all day";
    "You're sailing in the wrong direction";
    "You couldn't hit water if you fell out of a boat";
    "My turn, prepare yourself!";
    "You seem lost at sea";
    "That was close, but not close enough";
    "You won't sink me that easily";
    "Try again, captain!";
    "A swing and a miss!";
    "You're out of your depth";
    "Better luck next time";
    "Watch and learn";
    "Is this your first time playing?";
    "Don't quit your day job";
    "You're in over your head";
    "Looks like you're lost at sea";
    "I'm still afloat"
  ]

let random ai_phrases =
  let random_index = Random.int (List.length ai_phrases) in
  List.nth ai_phrases random_index

let rec play_game grid grid2 string =
  try
    if check_hit_count grid then raise Win else ();
    if check_hit_count grid2 then raise Lose else ();
    let move2 = parse string in
    new_turn grid move2;
    let _ = pick_random_point grid2 in
    print_endline "\n AI board \n";
    print_column_label_ai grid;
    print_grid_ai grid 1;
    print_endline "\n Player board \n";
    print_column_label grid2;
    print_grid grid2 1;
    print_endline "\n";
    let score = current_score () in
    print_score score;
    let misses1 = count_o grid in 
    print_misses misses1;
    print_endline "\n";
    let score2 = count_x grid2 in
    print_score_ai score2;
    let misses2 = count_o grid2 in 
    print_misses misses2;
    print_endline "\n";
    let phrase = random ai_phrases in
    print_string [red] ("AI: " ^ phrase);
    print_endline "\n";
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
  print_string [white]
    "Hello and welcome to Battleship!\n\
    \    Before you start your battle we must run you through everything you \
     as a player need to know.\n\n\
    \    To start off:\n\
    \      The objective of the game is to sink all 5 of your opponent's ships.\n\
    \    \n\
    \    Rules:\n\
    \      You are going to choose where you would like to place all 5 of your \
     ships.\n\
    \      To place your ships type “place <left/right/up/down> <column \
     letter> <row number>”.\n\
    \      It's important to note that you must place ships in valid positions.\n\
    \      For example, you cannot ask to place left or up if you are choosing \
     position A 1. \n\
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
     <row letter> <column number>” \n\
    \      If the ammo hits an empty spot and O will appear.\n\
    \      If a ship is hit at one of the points, an X will appear at that \
     exact point \n\
    \      Once you hit all parts of the ship a point will be added to your \
     score. \n\
    \      When your score hits zero you win the game. \n\
    \      If you want to quit at anytime press ctrl + c on your keyboard.\n\n\
    \    Warning:\n\
    \      Your opponent will also try to hit your ships.\n\
    \      If your opponent hits your ship an X will appear on your board.";

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
  let s = current_score () in
  print_score s;
  let miss1 = count_o grid1 in 
  print_misses miss1;
  print_endline "\n";
  let s2 = count_x grid2 in
  print_score_ai s2;
  let miss2 = count_o grid2 in 
  print_misses miss2;
  print_endline "Choose a target:";
  let line = read_line () in
  play_game grid1 grid2 line

let () = main ()
