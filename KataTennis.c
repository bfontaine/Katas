#include "KataTennis.h"

int scores[SCORES_LEN] = {0, 15, 30, 40};

void new_turn(player* p1, player* p2) {
    p1->game_score = 0;
    p1->has_advantage = 0;

    p2->game_score = 0;
    p2->has_advantage = 0;
}


void new_tennis(player* p1, player* p2) {
    p1->score = 0;
    p2->score = 0;
    new_turn(p1, p2);
}

void beat(player* p1, player* p2) {

    if ((p1->game_score == 40) && (p2->game_score == 40)) {
        if (p1->has_advantage) {
            p1->score++;
            new_turn(p1, p2);
        } else if (p2->has_advantage) {
            p2->has_advantage = 0;
        } else {
            p1->has_advantage = 1;
        }
        return;
    }

    int i;

    for (i=0; i<SCORES_LEN-1; i++) {
        if (scores[i] == p1->game_score) {
            p1->game_score = scores[i+1];
            return;
        }
    }

}

char* compare_scores(player* p1, player* p2) {
    
    if ((p1->game_score == 0) && (p2->game_score == 0)) {
        return LOVE;
    }

    if ((p1->game_score == 40) && (p2->game_score == 40)) {
        return DEUCE;
    }

    char *s = malloc(100*sizeof(char));

    sprintf(s, NORMAL, p1->game_score, p2->game_score);

    return s;
}
