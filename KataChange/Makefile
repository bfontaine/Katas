BIN ?= kata_change

$(BIN): kata_change.pl kata_change_cli.pl
	gplc $^

test:
	./kata_change_tests.pl

clean:
	rm -f $(BIN)
