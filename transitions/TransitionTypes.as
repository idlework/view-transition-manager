package transitions
{
	public class TransitionTypes
	{
		// push the other view away
		static public const PUSH:String = "push";
		
		// slide in
		static public const OVERLAY:String = "overlay";
		
		// slide out
		static public const UNDERLAY:String = "underlay";
		
		static public const ALL_TYPES:Array = [PUSH, OVERLAY, UNDERLAY];
	}
}