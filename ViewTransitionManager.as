package
{
	import com.gskinner.motion.easing.Sine;
	
	import flash.display.DisplayObject;
	
	import transitions.TransitionModel;
	
	/**
	 * A transition for <code>ViewNavigator</code> that slides out the old
	 * view and slides in the new view at the same time. The slide starts
	 * from the right, left, top, bottom, forth or back depending on if the manager determines if the
	 * transition is a push or a pop.
	 */
	public class ViewTransitionManager
	{
		/**
		 * Constructor.
		 */
		public function ViewTransitionManager(navigator:ViewNavigator, quickStack:Class = null)
		{
			if(!navigator)
			{
				throw new ArgumentError("ViewNavigator cannot be null.");
			}
			
			_navigator = navigator;
			
			if(quickStack)
			{
				_stack.push(quickStack);
			}
			
			_navigator.transition = onTransition;
		}
		
		protected var _navigator:ViewNavigator;
		protected var _stack:Vector.<Class> = new <Class>[];
		protected var _model:TransitionModel;
		
		/**
		 * The duration of the transition.
		 */
		public var duration:Number = 0.25;
		
		/**
		 * The GTween easing function to use.
		 */
		public var ease:Function = Sine.easeOut;

		/**
		 * used during trasition to en / disabled user interaction
		 */
		public var userInteractionEnabledDuringTransition:Boolean = false;
		
		/**
		 * Removes all saved classes from the stack that are used to determine
		 * which side of the <code>ViewNavigator</code> the new view will
		 * slide in from.
		 */
		public function clearStack():void
		{
			_stack.length = 0;
		}
		
		/**
		 *  check if there is a valid transition, check for old animation and then start the animation.
		 */
		protected function onTransition(oldView:DisplayObject, newView:DisplayObject, onComplete:Function, model:TransitionModel = null):void
		{
			if(!oldView || !newView || !model || !model.direction)
			{
				if(newView)
				{
					newView.x = newView.y = 0;
				}
				
				if(oldView)
				{
					oldView.x = oldView.y = 0;
				}
				
				onComplete();
				
				return;
			}
			
			if(_model)
			{
				if (_model.activeTransition)
				{
					_model.activeTransition.paused = true;
				}
				
				_model = null;
			}
			
			_model = model;
			
			if (_model.ease == null)
			{
				_model.ease = ease;
			}
			
			if (!_model.duration)
			{
				_model.duration = duration;
			}
			
			_model.doTransition(oldView, newView, onComplete);
		}
		
		public function get isRunning():Boolean
		{
			return _model && _model.activeTransition ? !_model.activeTransition.paused : false;
		}
	}
}