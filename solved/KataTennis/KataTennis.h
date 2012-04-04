#include <stdio.h>
#include <stdlib.h>

#define LOVE "love"
#define NORMAL "%d - %d"
#define DEUCE "deuce"

#define SCORES_LEN 4

typedef struct {
    int game_score; /* score of current game */
    int score;      /* total score */
    short has_advantage; /* advantage when game is deuce (0 or 1) */
} player;

/**
 * Initialize scores for a new turn.
 **/
void new_turn(player*, player*);

/**
 * Initialize scores for a new tennis game.
 **/
void new_tennis(player*, player*);

/**
 * Update scores of players when player beats player for
 * the current set
 **/
void beat(player*, player*);

/**
 * Compare scores and returns "love", "[score 1] - [score 2]", "deuce",
 * or "player 1 (or 2) won !"
 **/
char* compare_scores(player*, player*);
