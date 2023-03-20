type object_phrase = string * string

type command =
  | Shoot of object_phrase
  | Quit

exception Empty
exception Malformed

let parse s = raise Not_found
