#include "KataArgs.c"
#include <string.h>
#include <assert.h>

int bad_schema_file(void*);
int not_in_schema(void*);
int no_args(void*);

int should_set_char_c(char*);
int should_set_char_z(char*);
int should_set_char_null(char*);

int should_set_string_foo(char**);
int should_set_string_bar_foo(char**);
int should_set_string_null(char**);

int should_set_int_0(int*);
int should_set_int_1(int*);
int should_set_int_minus_1(int*);

int should_set_float_0(float*);
int should_set_float_3_14(float*);
int should_set_float_minus_1_7(float*);
