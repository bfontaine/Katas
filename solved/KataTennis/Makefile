# Makefile for KataTennis
# v0.1

CC=gcc
OPT=-Wall
TESTS=KataTennis_tests
ALL=KataTennis_tests.c KataTennis.c KataTennis.h

default: all
all: ${TESTS}

${TESTS}: ${ALL}
	${CC} ${OPT} KataTennis_tests.c -o $@

clean:
	rm -f *~
