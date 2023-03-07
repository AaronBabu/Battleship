type object_phrase = string list

type command =
  | Shoot of object_phrase
  | Quit

exception Empty
exception Malformed