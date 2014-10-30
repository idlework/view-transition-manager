package transitions
{
	import com.gskinner.motion.GTween;
	
	import flash.display.DisplayObject;

	public class TransitionPushModel extends TransitionModel
	{
		public function TransitionPushModel(direction:String = "")
		{
			super(direction);
		}
		
		override public function doTransition(oldView:DisplayObject, newView:DisplayObject, onComplete:Function):void
		{
			this.oldView = oldView;
			this.newView = newView;
			savedCompleteHandler = onComplete;
			
			oldView.x = oldView.y = 0;
			
			switch (direction)
			{
				case TransitionDirections.LEFT:
				{
					newView.x = oldView.width;
					break;
				}
				case TransitionDirections.RIGHT:
				{
					newView.x = -oldView.width;
					break;
				}
				case TransitionDirections.TOP:
				{
					newView.y = -oldView.height;
					break;
				}
				case TransitionDirections.BOTTOM:
				{
					newView.y = oldView.height;
					
					break;
				}
			}
			
			activeTransition = new GTween(newView, duration,
				{
					x: 0,
					y: 0
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
			switch (direction)
			{
				case TransitionDirections.LEFT:
				{
					oldView.x = newView.x - oldView.width;
					break;
				}
				case TransitionDirections.RIGHT:
				{
					oldView.x = newView.x + oldView.width;
					break;
				}
				case TransitionDirections.TOP:
				{
					oldView.y = newView.y + oldView.height;
					break;
				}
				case TransitionDirections.BOTTOM:
				{
					oldView.y = newView.y - oldView.height;
					break;
				}
			}
		}
	}
}