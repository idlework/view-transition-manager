package transitions
{
	import com.gskinner.motion.GTween;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class TransitionStackModel extends TransitionModel
	{
		public function TransitionStackModel(direction:String = "")
		{
			super(direction);
		}
		
		override public function doTransition(oldView:DisplayObject, newView:DisplayObject, onComplete:Function):void
		{
			this.oldView = oldView;
			this.newView = newView;
			savedCompleteHandler = onComplete;
			
			var target:DisplayObject;
			var nonTarget:DisplayObject;
			var position:Point = new Point();
			
			oldView.x = oldView.y = 0;
			
			switch (type)
			{
				case TransitionTypes.OVERLAY:
				{
					target = newView;
					nonTarget = oldView;
					
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
					break;
				}
				default:
				case TransitionTypes.UNDERLAY:
				{
					target = oldView;
					nonTarget = newView;
					
					switch (direction)
					{
						case TransitionDirections.LEFT:
						{
							position.x = oldView.width;
							break;
						}
						case TransitionDirections.RIGHT:
						{
							position.x = -oldView.width;
							break;
						}
						case TransitionDirections.TOP:
						{
							position.y = -oldView.height;
							break;
						}
						case TransitionDirections.BOTTOM:
						{
							position.y = oldView.height;
							break;
						}
					}
					
					oldView.parent.swapChildren(newView, oldView);
					break;
				}
			}
			
			activeTransition = new GTween(target, duration,
				{
					x: position.x,
					y: position.y
				},
				{
					data: nonTarget,
					ease: ease,
					onInit: startHandler,
					onComplete: completeHandler
				});
		}
	}
}