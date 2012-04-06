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
        case _   => r1_str.toInt
      }
    }

    var roll_2:Int = if ((is_strike) || turn.length == 1) 0 else {
      val r2_str = turn.tail // last char
      r2_str match {
        case "/" => is_spare=true;10
        case "-" => 0
        case _   => r2_str.toInt
      }
    }

    override def toString = turn
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

    var score = 0

    val rolls_list = parseGame(stringToList(rolls))

    score
  }

}
