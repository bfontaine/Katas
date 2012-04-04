#include "KataTennis.h"

void new_turn(player* p1, player* p2) {}

void new_tennis(player* p1, player* p2) {}

void beat(player* p1, player* p2) {}

char* compare_scores(player* p1, player* p2) {
    
    if ((p1->game_score == 0) && (p2->game_score == 0)) {
        return LOVE;
    }

    return "";
}
