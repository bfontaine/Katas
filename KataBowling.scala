import scala.util.matching.Regex

object KataBowling {

  class BowlingTurn(turn:String) {

    var is_strike:Boolean = false
    var is_spare:Boolean = false

    val roll_1:Int = {
      val r1_str = turn.head
      r1_str match {
        case 'X' => is_strike=true;10
        case '-' => 0
        case _   => (""+r1_str).toInt
      }
    }

    val roll_2:Int = if ((is_strike) || turn.length == 1) 0 else {
      val r2_str = turn.tail // last char
      r2_str match {
        case "/" => is_spare=true;10
        case "-" => 0
        case _   => (""+r2_str).toInt
      }
    }

    val points:Int = if (is_strike || is_spare) 10 else roll_1+roll_2
  }

  def stringToList(s:String):List[Char] = s match {
    case "" => List[Char]()
    case _  => s.head::stringToList(s.tail)
  }

  val digit, digit2 = new Regex("\\d")

  // parseGame(stringToList(...))
  def parseGame(game:List[Char]):List[BowlingTurn] = game match {
      case Nil              => List[BowlingTurn]()
      case 'X'::_           => new BowlingTurn("X")::parseGame(game.tail)
      case digit::'/'::_    => new BowlingTurn(""+game.head+'/')::parseGame(game.tail.tail)
      case digit::digit2::_ => new BowlingTurn(""+game.head+game.tail.head)::parseGame(game.tail.tail)
      case digit::Nil       => new BowlingTurn(""+game.head)::parseGame(game.tail)
      case _                => Nil // should not happen
  }

  def score(rolls:String):Int = {

    var score:Int = 0

    val rolls_list:Array[BowlingTurn] = parseGame(stringToList(rolls)).toArray

    var i:Int = 0

    while ((i != rolls_list.length) && (i < 10)) {

      // normal turn
      if (!rolls_list(i).is_strike && !rolls_list(i).is_spare) {
        score += rolls_list(i).points;
      }
      // strike & spare
      else {
        score += 10

        // normal (no bonus) strike & spare
        if (i < rolls_list.length-1) {
          score += rolls_list(i+1).roll_1

          if (rolls_list(i).is_strike) { // strike only
            
            // if next turn is not a strike or a spare, we take its second roll
            if (!rolls_list(i+1).is_strike && !rolls_list(i+1).is_spare) {
              score += rolls_list(i+1).roll_2
            
            // else we take the next next turn's first roll
            } else if (i < rolls_list.length-2) {
              score += rolls_list(i+2).roll_1
            }
          }
        }
      }
      i += 1
    }

    score
  }
}
