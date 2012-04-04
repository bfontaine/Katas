#include "KataTennis.c"
#include <assert.h>
#include <string.h>

int main(void) {

   player *p1 = malloc(sizeof(player));
   player *p2 = malloc(sizeof(player));


   /* New game */
   new_tennis(p1, p2);

   assert(p1->score      == 0);
   assert(p1->game_score == 0);
   assert(p2->score      == 0);
   assert(p2->score      == 0);

   assert(strcmp(compare_scores(p1, p2), "love") == 0);

   /* 15 - 0 */
   beat(p1, p2);
   assert(p1->game_score == 15);
   assert(p2->game_score == 0);

   assert(strcmp(compare_scores(p1, p2), "15 - 0") == 0);

   assert(p1->has_advantage == 0);
   assert(p2->has_advantage == 0);

   /* 15 - 15 */
   beat(p2, p1);
   assert(p1->game_score == 15);
   assert(p2->game_score == 15);

   assert(strcmp(compare_scores(p1, p2), "15 - 15") == 0);

   /* 15 - 30 */
   beat(p2, p1);
   assert(p1->game_score == 15);
   assert(p2->game_score == 30);

   assert(strcmp(compare_scores(p1, p2), "15 - 30") == 0);

   /* 15 - 40 */
   beat(p2, p1);
   assert(p1->game_score == 15);
   assert(p2->game_score == 40);

   assert(strcmp(compare_scores(p1, p2), "15 - 40") == 0);
   assert(strcmp(compare_scores(p2, p1), "40 - 15") == 0);

   /* 30 - 40 */
   beat(p1, p2);
   assert(p1->game_score == 30);
   assert(p2->game_score == 40);

   assert(strcmp(compare_scores(p1, p2), "30 - 40") == 0);

   /* 40 - 40 */
   beat(p1, p2);
   assert(p1->game_score == 40);
   assert(p2->game_score == 40);

   assert(strcmp(compare_scores(p1, p2), "deuce") == 0);

   /* 40 - 40 (player 1 has advantage) */
   beat(p1, p2);
   assert(p1->game_score == 40);
   assert(p2->game_score == 40);

   assert(strcmp(compare_scores(p1, p2), "deuce") == 0);
   assert(strcmp(compare_scores(p2, p1), "deuce") == 0);

   assert(p1->has_advantage == 1);
   assert(p2->has_advantage == 0);

   /* player 1 won the game */
   beat(p1, p2);
   assert(p1->game_score == 0);
   assert(p1->score      == 1);
   assert(p2->game_score == 0);
   assert(p2->score      == 0);

   assert(strcmp(compare_scores(p1, p2), "love") == 0);

   /* new turn */

   /* TODO continue */

   /* end of tests */
   free(p1);
   free(p2);

   return 0;
}
