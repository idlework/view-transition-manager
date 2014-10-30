package transitions
{
	public class TransitionDirections
	{
		static public const NONE:String = "none";
		
		static public const LEFT:String = "left";
		static public const RIGHT:String = "right";
		static public const TOP:String = "top";
		static public const BOTTOM:String = "bottom";

		static public const FORWARD:String = "forward";
		static public const BACKWARD:String = "backward";

		static public const TURN_LEFT:String = "turnLeft";
		static public const TURN_RIGHT:String = "turnRight";
		
		static public const ALL_TYPES:Array = [LEFT, RIGHT, TOP, BOTTOM, FORWARD, BACKWARD, TURN_LEFT, TURN_RIGHT];
	}
}   