#! /bin/bash
ocamlfind ocamlc -o test -package oUnit -linkpkg -g index_query.ml index_query_tests.ml && ./test

