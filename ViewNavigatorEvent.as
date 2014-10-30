package oak.control
{
	import flash.events.Event;
	/**
	 * @author JHaneveld
	 */
	public class ViewNavigatorEvent extends Event
	{
		static public const CHANGE:String = "viewNavigatorChange";
		static public const CHANGED:String = "viewNavigatorChanged";
		
		public function ViewNavigatorEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event
		{
			return new ViewNavigatorEvent(type, bubbles, cancelable);
		}
	}
}
