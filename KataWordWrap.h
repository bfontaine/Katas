#ifndef _KATAWORDWRAP_H
#define _KATAWORDWRAP_H 1

#include <iostream>
#include <string>
using namespace std;

class Wrapper {
    public:
        static string wrap(string *s, int cols);
};

#endif
