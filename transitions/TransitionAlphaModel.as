package transitions
{
	import com.gskinner.motion.GTween;
	
	import flash.display.DisplayObject;

	public class TransitionAlphaModel extends TransitionModel
	{
		public function TransitionAlphaModel(direction:String = TransitionDirections.NONE)
		{
			super(direction);
		}
		
		override public function doTransition(oldView:DisplayObject, newView:DisplayObject, onComplete:Function):void
		{
			this.oldView = oldView;
			this.newView = newView;
			savedCompleteHandler = onComplete;
			
			activeTransition = new GTween(newView, duration,
				{
					alpha: 1
				},
				{
					ease: ease,
					onInit: startHandler,
					onChange: _changeHandler,
					onComplete: completeHandler
				});
		}
		
		private function _changeHandler(tween:GTween):void
		{
			oldView.alpha = 1 - newView.alpha;
		}
	}
}