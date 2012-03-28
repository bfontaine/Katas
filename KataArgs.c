#include "KataArgs.h"

#define SCHEMA_FILE ""

arg* last_config = NULL;
int  last_config_length = 0;

/* Aliases */

int read_config_file(char* path, arg* config) {
    return read_config_file_f(path, config, 0);
}

void read_args(int argc, char** argv, arg* config,
                    int config_length) {
    read_args_f(argc, argv, config, config_length, 0);
}

/* ------ */

int read_config_file_f(char* path, arg* config, int FLAGS) {
    /* TODO */
    return 0;
}


void read_args_f(int argc, char** argv, arg* config,
                    int config_length, int FLAGS) {
    /* TODO */
}
