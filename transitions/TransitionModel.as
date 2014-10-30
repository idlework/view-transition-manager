package transitions
{
	import com.gskinner.motion.GTween;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	import IViewTransition;

	public class TransitionModel extends EventDispatcher
	{
		private var _type:String;
		private var _direction:String;
		private var _ease:Function;
		private var _duration:Number;
		private var _userInteractionEnabledDuringTransition:Boolean;
		
		private var _activeTransition:GTween;
		private var _newView:DisplayObject;
		private var _oldView:DisplayObject;
		private var _savedCompleteHandler:Function;
		
		public function TransitionModel(direction:String = "") 
		{
			_direction = direction;
		}
		
		public function doTransition(oldView:DisplayObject, newView:DisplayObject, onComplete:Function):void
		{
			onComplete();
		}
		
		protected function startHandler(tween:GTween):void
		{
			if (!_userInteractionEnabledDuringTransition)
			{
				if (_newView is Sprite)
				{
					Sprite(_newView).mouseEnabled = false;
				}
				
				if (_oldView is Sprite)
				{
					Sprite(_oldView).mouseEnabled = false;
				}
			}
			
			if (_newView is IViewTransition)
			{
				IViewTransition(_newView).transitionStart();
			}
			
			if (_oldView is IViewTransition)
			{
				IViewTransition(_oldView).transitionStart();
			}
		}
		
		protected function completeHandler(tween:GTween):void
		{
			_activeTransition = null;
			
			if (_newView is IViewTransition)
			{
				IViewTransition(_newView).transitionEnd();
			}
			
			if (_oldView is IViewTransition)
			{
				IViewTransition(_oldView).transitionEnd();
			}
			
			if (!_userInteractionEnabledDuringTransition)
			{
				if (_newView is Sprite)
				{
					Sprite(_newView).mouseEnabled = true;
				}
				
				if (_oldView is Sprite)
				{
					Sprite(_oldView).mouseEnabled = true;
				}
			}
			
			if(_savedCompleteHandler != null)
			{
				_savedCompleteHandler();
			}
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function get duration():Number 
		{
			return _duration;
		}

		public function set duration(value:Number):void 
		{
			_duration = value;
		}

		public function get ease():Function 
		{
			return _ease;
		}

		public function set ease(value:Function):void 
		{
			_ease = value;
		}

		public function get direction():String 
		{
			return _direction;
		}

		public function set direction(value:String):void 
		{
			_direction = value;
		}
		
		public function get userInteractionEnabledDuringTransition():Boolean
		{
			return _userInteractionEnabledDuringTransition;
		}
		
		public function set userInteractionEnabledDuringTransition(value:Boolean):void
		{
			_userInteractionEnabledDuringTransition = value;
		}

		public function get activeTransition():GTween
		{
			return _activeTransition;
		}

		public function set activeTransition(value:GTween):void
		{
			_activeTransition = value;
		}

		public function get newView():DisplayObject
		{
			return _newView;
		}

		public function set newView(value:DisplayObject):void
		{
			_newView = value;
		}

		public function get oldView():DisplayObject
		{
			return _oldView;
		}

		public function set oldView(value:DisplayObject):void
		{
			_oldView = value;
		}

		public function get savedCompleteHandler():Function
		{
			return _savedCompleteHandler;
		}

		public function set savedCompleteHandler(value:Function):void
		{
			_savedCompleteHandler = value;
		}
	}
}