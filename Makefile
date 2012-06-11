
CC=g++
OPT=-Wall
OBJ=KataWordWrap_tests.o KataWordWrap.o
TESTS=KataWordWrap_tests

default: tests
	@# do nothing
	@:

tests: ${TESTS}
	./${TESTS}

KataWordWrap_tests: ${OBJ}
	${CC} ${OPT} $^ -o $@

KataWordWrap.o: KataWordWrap.cpp KataWordWrap.h
KataWordWrap_tests.o: KataWordWrap_tests.cpp

%.o :
	${CC} ${OPT} -c $< -o $@

clean:
	rm -f ${OBJ}
	rm -f ${TESTS}
	rm -f *~

