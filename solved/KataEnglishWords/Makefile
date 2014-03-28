# Kata English Words (Rust)

CC=rustc
BASENAME=kata_english_words

TESTS_TARGET=$(BASENAME)_tests
TESTS=$(TESTS_TARGET).rs

# not sure how the name is generated
LIB=lib$(BASENAME)-c00418a7-0.0.dylib

.PHONY: tests

default: tests

$(LIB): $(BASENAME).rs
	$(CC) --lib $<

$(TESTS_TARGET): $(TESTS) $(LIB)
	$(CC) --test $<

tests: $(TESTS_TARGET)
	./$<
