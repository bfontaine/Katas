#! /bin/bash
ocamlfind ocamlc str.cma -o test -package oUnit -linkpkg -g kataWordQuery.ml kataWordQueryTests.ml && ./test

