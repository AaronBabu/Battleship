type object_phrase = string * string

type command =
  | Shoot of object_phrase
  | Quit

exception Empty
exception Malformed

let parse string : string * string =
  let upper_case = String.uppercase_ascii string in
  let start_lst = String.split_on_char ' ' upper_case in
  let end_list = List.filter (fun x -> String.length x != 0) start_lst in
  match end_list with
  | [] -> raise Empty
  | [ "QUIT" ] -> ("a", "b")
  | "SHOOT" :: tl1 :: tl2 -> (tl1, List.hd tl2)
  | _ -> raise Malformed

(* let change_command (tuple : string * string) = let com_list = List.nth lst 0
   in match com_list with | "shoot" -> Shoot (List.nth lst 1, List.nth lst 2) |
   "quit" -> Quit | _ -> raise Malformed *)

(* let parse str = string_to_command str *)
