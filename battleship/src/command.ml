type object_phrase = string list

type command =
  | Shoot of object_phrase
  | Quit

exception Empty
exception Malformed

let string_to_list string :string list =
  let start_lst = String.split_on_char ' ' string in let
   end_list = List.filter(fun x-> String.length x !=0 ) start_lst in 
   match end_list with 
   | [] -> raise Empty
   | _ -> end_list

let change_command lst: string list = 
  let com_list = List.nth lst 0 in 
  match com_list with
  | "shoot" -> Shoot (List.tl lst)
  | "quit" -> Quit
  | _ -> raise Malformed
  
  let parse str = let parse_lst = string_to_list str in change_command parse_lst 