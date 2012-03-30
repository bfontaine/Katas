# KataArgs makefile
# v0.1

CC=gcc -Wall

default: KataArgs_tests

KataArgs : KataArgs.c KataArgs.h
	${CC} KataArgs.c -o KataArgs

KataArgs_test : KataArgs_test.c
	${CC} KataArgs_test.c -o KataArgs_test

clean:
	rm -f *~

