open Battleship

type object_phrase = string * string
type command = Shoot of object_phrase

exception Empty
exception Malformed
exception Quit
exception Win
exception Lose

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
