import org.scalatest.FunSuite
import scala.collection.mutable.Stack

class KataBowlingTest extends FunSuite {

  /* suggested test cases */

  test("12 rolls: 12 strikes") {

    val score = KataBowling.score("X"*12)

      assert(score == 300);
  }

  test("20 rolls: 10 pairs of 9 and miss") {

    val score = KataBowling.score("9-"*10)

      assert(score == 90);
  }

  test("21 rolls: 10 pairs of 5 and spare, with a final 5") {

    val score = KataBowling.score("5/"*10+"5")

      assert(score == 150);
  }

}
