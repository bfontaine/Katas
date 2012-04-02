#include "KataArgs_tests.h"

char  char_value;
char* string_value;
int   int_value;
float float_value;

char* schema_file;

int main(int argc, char** argv) {

    if (argc == 0) {
        return -1;
    }

    arg* config = NULL;

    /* the first argument is the schema file */
    schema_file = strdup(argv[0]);
    argv++;
    argc--;

    int config_length = read_config_file(schema_file, config);

    read_args(argc, argv, config, config_length);

    /* assertions */

    assert( bad_schema_file(&char_value) == BAD_SCHEMA    );

    assert( not_in_schema(&char_value)   == NOT_IN_SCHEMA );

    assert( no_args(&char_value)         == 0             );

    char_value = '\0';
    assert( should_set_char_c(&char_value) );
    assert( char_value == 'c'              );

    char_value = '\0';
    assert( should_set_char_c(&char_value) );
    assert( char_value == 'z'              );

    assert( should_set_char_null(&char_value) );
    assert( char_value == '\0'                );

    string_value = NULL;
    assert( should_set_string_foo(&string_value) );
    assert( strcmp(string_value, "foo") == 0     );

    /* free(string_value); <-- ? */
    string_value = NULL;
    assert( should_set_string_bar_foo(&string_value) );
    assert( strcmp(string_value, "foo-bar") == 0     );

    assert( should_set_string_null(&string_value) );
    assert( string_value == NULL                  );

    int_value = 1;
    assert( should_set_int_0(&int_value) );
    assert( int_value == 0               );

    assert( should_set_int_1(&int_value) );
    assert( int_value == 1               );

    assert( should_set_int_minus_1(&int_value) );
    assert( int_value == -1                    );

    float_value = 1;
    assert( should_set_float_0(&float_value) );
    assert( float_value == 0                 );

    assert( should_set_float_3_14(&float_value) );
    assert( float_value == 3.14                 );

    assert( should_set_float_minus_1_7(&float_value) );
    assert( float_value == -1.7                      );

    return 0;
}

int bad_schema_file(void* p) {
    return 0; /* TODO */
}

int not_in_schema(void* p) {
    return 0; /* TODO */
}

int no_args(void* p) {
    return 0; /* TODO */
}


int should_set_char_c(char* c) {
    return 0; /* TODO */
}

int should_set_char_z(char* c) {
    return 0; /* TODO */
}

int should_set_char_null(char* c) {
    return 0; /* TODO */
}


int should_set_string_foo(char** s) {
    return 0; /* TODO */
}

int should_set_string_bar_foo(char** s) {
    return 0; /* TODO */
}

int should_set_string_null(char** s) {
    return 0; /* TODO */
}


int should_set_int_0(int* i) {
    return 0; /* TODO */
}

int should_set_int_1(int* i) {
    return 0; /* TODO */
}

int should_set_int_minus_1(int* i) {
    return 0; /* TODO */
}


int should_set_float_0(float* f) {
    return 0; /* TODO */
}

int should_set_float_3_14(float* f) {
    return 0; /* TODO */
}

int should_set_float_minus_1_7(float* f) {
    return 0; /* TODO */
}

