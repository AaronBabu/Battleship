## Setting up Ocaml

To install Ocaml on your machine, visit (https://cs3110.github.io/textbook/chapters/preface/install.html) for step by step instrctions.
Credit for these instructions and the whole textbook goes to Cornell Professor Michael Clarkson, who was once a professor for CS 3110. 

## Packages

Here are the following packages that must be installed for our program to run on your machine:
-OUnit
-ANSITerminal

You can use the command ``opam install [package name]``. If there are any other necessary packages that you were warned are missing by a
message in terminal, you can run the command above to install them. 

## Make and Run
- cd into the battleship folder 
- ``make build`` which runs dune build
- `` make play`` and then choose a target by typing and entering "shoot capital-letter(A-J) number(1-10)" (example "shoot B 4" to hit coordinate B4) to shoot into desired position
- `` make test`` to run unit tests
- `` make linecount`` which runs `` cloc --by-file --include-lang=OCaml.``to count the number of OCaml code lines for grading purposes and also runs `` ocamlbuild --clean``, which cleans out the directory you are in including build if you'll need to build up the project again before going through with the project.