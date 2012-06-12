
CC=g++
OPT=-Wall -pedantic -Wextra
LINKS=-lcppunit -ldl
OBJ=KataWordWrap.o KataWordWrap_tests.o
TESTS=KataWordWrap_tests

default: tests
	@# do nothing
	@:

tests: ${TESTS}
	./${TESTS}

${TESTS}: ${OBJ}
	${CC} ${OPT} ${LINKS} $^ -o $@

KataWordWrap.o: KataWordWrap.cpp KataWordWrap.h
KataWordWrap_tests.o: KataWordWrap_tests.cpp

%.o :
	${CC} ${OPT} -c $< -o $@

clean:
	rm -f ${OBJ}
	rm -f ${TESTS}
	rm -f *~

