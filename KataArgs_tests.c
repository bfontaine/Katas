#include "KataArgs.c"

int main(int argc, char** argv) {

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
    int config_length = read_config_file_f(SCHEMA_FILE, config, flag1);

    read_args_f(argc, argv, config, config_length, flag2);

    return 0;
}
