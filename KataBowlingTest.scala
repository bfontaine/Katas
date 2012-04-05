import org.scalatest.FunSuite
import scala.collection.mutable.Stack

class KataBowlingTest extends FunSuite {

  /* suggested test cases */

  test("12 rolls: 12 strikes") {

    val score = KataBowling.score("X"*12)

      expect(300) {score}
  }

  test("20 rolls: 10 pairs of 9 and miss") {

    val score = KataBowling.score("9-"*10)

      expect(90) {score}
  }

  test("21 rolls: 10 pairs of 5 and spare, with a final 5") {

    val score = KataBowling.score("5/"*10+"5")

      expect(150) {score}
  }

  /* simple test cases */

  test("10 rolls: 10 pairs of miss") {

    val score = KataBowling.score("--"*10)

      expect(0) {score}
  }

  test("10 rolls: 10 pairs of 1 and miss") {

    val score = KataBowling.score("1-"*10)

      expect(10) {score}
  }

  test("10 rolls: 10 pairs of 4 and 2") {

    val score = KataBowling.score("42"*10)

      expect(60) {score}
  }

  /* medium test cases */

  test("10 rolls: 9 pairs of 7 and 1, a 3 and spare, and a final 8") {

    val score = KataBowling.score("71"*9+"3/8")

      /* 9*(7+1) points, + a spare (10 points + 2 * next turn (8) )
         = 9*8+10+16 = 98 */
      expect(98) {score}
  }

}
