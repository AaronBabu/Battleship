type object_phrase = string * string

type command =
  | Shoot of object_phrase
  | Quit

exception Empty
exception Malformed

let parse s = raise Not_found

(*make function that parses through the users input in command to get starting
  and ending positions of ship*)
