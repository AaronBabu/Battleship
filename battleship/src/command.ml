type object_phrase = string * string

type command =
  | Shoot of object_phrase
  | Quit

exception Empty
exception Malformed
exception Quit 



let parse string : string * string =
  let start_lst = String.split_on_char ' ' string in
  let end_list = List.filter (fun x -> String.length x != 0) start_lst in
  let m_list = List.map (fun x -> String.lowercase_ascii x) end_list in
  match m_list with
  | [] -> raise Empty
  | [ "quit" ] -> raise Quit 
  | "shoot" :: tl1 :: tl2 -> (tl1, List.hd tl2)
  | _ -> raise Malformed

(* let quit string = 
  let start_lst = String.split_on_char ' ' string in
  let end_list = List.filter (fun x -> String.length x != 0) start_lst in
  match end_list with
  | [] -> raise Empty
  | [ "quit" ] -> "\003"
  |  *)

(* let change_command (tuple : string * string) = let com_list = List.nth lst 0
   in match com_list with | "shoot" -> Shoot (List.nth lst 1, List.nth lst 2) |
   "quit" -> Quit | _ -> raise Malformed *)

(* let parse str = string_to_command str *)
(* let parse string : string * string = let start_lst = String.split_on_char ' '
   string in let end_list = List.filter (fun x -> String.length x != 0)
   start_lst in match end_list with | [] -> raise Empty | [ "quit" ] -> ("a",
   "b") | "shoot" :: tl1 :: tl2 -> (tl1, List.hd tl2) | _ -> raise Malformed *)
