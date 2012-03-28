#include "KataArgs.c"
#include <string.h>

int main(int argc, char** argv) {

    if (argc == 0) {
        return -1;
    }

    int flag1 = 0,
        flag2 = 0;

/* Test schema file reading */
#ifdef TEST_FILE
    flag1 = VERBOSE_FLAG;
#endif

/* Test command-line args parsing */
#ifdef TEST_ARGS
    flag2 = VERBOSE_FLAG;
#endif

    arg* config = NULL;

    /* the first argument is the schema file */
    char* schema_file = strdup(argv[0]);
    argv++;
    argc--;

    int config_length = read_config_file_f(schema_file, config, flag1);

    read_args_f(argc, argv, config, config_length, flag2);

    return 0;
}
