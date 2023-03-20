type object_phrase = string * string
(** The type [object_phrase] represents the object phrase that can be part of a
    player command. Each element of the list represents a part of the object
    phrase position, where a "position" is defined as a letter then a number. 
    Thus, no element of the list should contain any leading,
    internal, or trailing spaces. The list is in the same order as the words in
    the original player command. For example:

    - If the player command is ["shoot A3"], then the object phrase is
      [("A", "3")].

    - If the player command is ["shoot   A3     "], then the object phrase is
      again [("A", "3")]. *)

(** The type [command] represents a player command that is decomposed into a
    verb and possibly an object phrase. Invariant: the [object_phrase] carried
    by [Shoot] must not be empty. *)
type command = 
  | Shoot of object_phrase
  | Quit

exception Empty
(** Raised when an empty command is parsed. *)

exception Malformed
(** Raised when a malformed command is parsed. *)

val parse : string -> command
(** [parse str] parses a player's input into a [command], as follows. The first
    word (i.e., consecutive sequence of non-space characters) of [str] becomes
    the verb. The rest, if any, become the object phrase. Examples:

    - [parse "    shoot   B4  "] is [Shoot ("B", "4")]
    - [parse "quit"] is [Quit].

    Requires: [str] contains only alphanumeric (A-Z, a-z, 0-9) and space
    characters (only ASCII character code 32; not tabs or newlines, etc.).

    Raises: [Empty] if [str] is the empty string or contains only spaces.

    Raises: [Malformed] if the command is malformed. A command is malformed if
        -the verb is neither "quit" nor "shoot"
        -the object phrase is an invalid position (z19)
        -there is an object phrase after quit like [parse "quit a4"] *)



  