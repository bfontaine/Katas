# KataArgs makefile
# v0.1

CC=gcc -Wall

default: KataArgs_test_file KataArgs_test_args

KataArgs : KataArgs.c KataArgs.h
	${CC} KataArgs.c -o KataArgs

KataArgs_test_file : KataArgs.c KataArgs.h KataArgs_tests.c
	${CC} -DTEST_FILE KataArgs_tests.c -o KataArgs_test_file

KataArgs_test_args : KataArgs.c KataArgs.h KataArgs_tests.c
	${CC} -DTEST_ARGS KataArgs_tests.c -o KataArgs_test_args

clean:
	rm -f KataArgs_test_args
	rm -f KataArgs_test_file
	rm -f *~

