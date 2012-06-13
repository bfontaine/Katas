#include "KataWordWrap.h"
using namespace std;

string Wrapper::wrap(const string *s, int cols) {

    if ((s->length() == 0) || (cols <= 1)) {
        return *s;
    }

    string s2 = *s;

    unsigned int i = 0;
    unsigned int len = s2.length();
    int last_space = -1;

    const string newline = "\n";

    /* FIXME */
    for (; i < len; i++) {
        if ((i%cols == 0) && (i!=0)) {
            if (::isspace(s2[i])) {
                s2[i] = '\n';
            } else if (last_space == -1) {
                return s2;
            } else {
                s2.insert(last_space, newline);
                len = s2.length();
            }
            last_space = -1;
        }
        else if (::isspace(s2[i])) {
            last_space = i;
        }
    }

    return s2;
}

