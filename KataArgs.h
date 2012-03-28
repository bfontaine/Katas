#include <stdio.h>
#include <stdlib.h>

#define NONE_VALUE 0
#define INT_VALUE 1
#define STR_VALUE 2
#define INT_L_VALUE 3
#define STR_L_VALUE 4

#define VERBOSE_FLAG 1

typedef struct {
    char label;       /* letter associated with the arg */
    short value_type; /* type of value:
                       *    0: none
                       *    1: int
                       *    2: string
                       *    3: int list
                       *    4: string list
                       */
    void* value;      /* pointer on the value of this arg */
    int value_length; /* length of the value (used for lists) */
} arg;

/**
 * Return* an `arg` array, with NULL value and label/value_type
 * filled with the informations specified in the schema file
 * given.
 * (*): by filling `config` and returning its length.
 **/
int read_config_file(char* path, arg* config);
int read_config_file_f(char* path, arg* config, int FLAGS);

/**
 * Fill a given `arg` array with args values read
 * from command-line arguments given with `argc` and `argv`.
 **/
void read_args(int argc, char** argv, arg* config,
        int config_length);
void read_args_f(int argc, char** argv, arg* config,
        int config_length, int FLAGS);

