#include "KataWordWrap.h"
using namespace std;

string Wrapper::wrap(const string *s, int cols) {

    if ((s->length() == 0) || (cols <= 1)) {
        return *s;
    }

    string s2 = *s;

    unsigned int i = 0;
    unsigned int len = s2.length();
    unsigned int lastBreak = 0;
    int last_space = -1;

    bool breakOnNextSpace = false;

    const char newline = '\n';

    for (; i < len; i++) {

        if (breakOnNextSpace && ::isspace(s2[i])) {
            s2[i] = newline;
            lastBreak = i;
            breakOnNextSpace = false;
        }
        else if (((i-lastBreak)%cols == 0) && (i!=0)) {

            if (::isspace(s2[i])) {
                s2[i] = newline;
                lastBreak = i;
            }
            else if (last_space == -1) {
                breakOnNextSpace = true;
            }
            else {
                s2[last_space] = newline;
                lastBreak = last_space;
            }

            last_space = -1;
        }
        else if (::isspace(s2[i])) {
            last_space = i;
        }
    }

    return s2;
}

