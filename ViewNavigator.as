package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	
	import transitions.TransitionModel;
	 
	[Event(name="viewNavigatorChange", type="ViewNavigatorEvent")]
	[Event(name="viewNavigatorChanged", type="ViewNavigatorEvent")]
	 
	public class ViewNavigator extends Sprite
	{		
		/**
		 * Constructor.
		 */
		public function ViewNavigator()
		{
		}

		/**
		 * @private
		 */
		private var _activeViewID:String;

		/**
		 * The string identifier for the currently active view.
		 */
		public function get activeViewID():String
		{
			return _activeViewID;
		}

		/**
		 * @private
		 */
		private var _activeView:DisplayObject;

		/**
		 * A reference to the currently active view.
		 */
		public function get activeView():DisplayObject
		{
			return _activeView;
		}

		/**
		 * @private
		 */
		private var _clipContent:Boolean = false;

		/**
		 * Determines if the navigator's content should be clipped to the width
		 * and height.
		 */
		public function get clipContent():Boolean
		{
			return _clipContent;
		}

		/**
		 * @private
		 */
		public function set clipContent(value:Boolean):void
		{
			if(_clipContent == value)
			{
				return;
			}
			_clipContent = value;
		}
		
		/**
		 * A function that is called when the <code>ViewNavigator</code> is
		 * changing views.
		 */
		public var transition:Function = defaultTransition;

		private var _views:Object = {};

		/**
		 * The identifier of the "default" view.
		 *
		 * @see #showDefaultView()
		 */
		public var defaultViewID:String;

		private var _transitionIsActive:Boolean = false;
		private var _previousViewInTransitionID:String;
		private var _previousViewInTransition:DisplayObject;
		private var _nextViewID:String = null;
		private var _clearAfterTransition:Boolean = false;

		/**
		 * Displays a view and returns a reference to it. If a previous
		 * transition is running, the new view will be queued, and no
		 * reference will be returned.
		 */
		public function showView(id:String, model:TransitionModel = null):DisplayObject
		{
			if(!_views.hasOwnProperty(id))
			{
				throw new IllegalOperationError("View with id '" + id + "' cannot be shown because it has not been defined.");
			}

			if(_activeViewID == id)
			{
				return _activeView;
			}
			
			if(_transitionIsActive)
			{
				_nextViewID = id;
				_clearAfterTransition = false;
				
				return null;
			}
			
			if (_activeView)
			{
				return _activeView;
			}
			

			_previousViewInTransition = _activeView;
			_previousViewInTransitionID = _activeViewID;
			 
			if(_activeView)
			{
				clearViewInternal(false);
			}

			const item:ViewNavigatorItem = ViewNavigatorItem(_views[id]);
			_activeView = item.getView();
			_activeViewID = id;
			addChild(_activeView);

			_transitionIsActive = true;
			transition(_previousViewInTransition, _activeView, transitionComplete, model);
			
			dispatchEvent(new ViewNavigatorEvent(ViewNavigatorEvent.CHANGE));
			
			return _activeView;
		}

		/**
		 * Shows the "default" view.
		 *
		 * @see #defaultViewID
		 */
		public function showDefaultView():DisplayObject
		{
			if(!defaultViewID)
			{
				throw new IllegalOperationError("Cannot show default view because the default view ID has not been defined.");
			}
			
			return showView(defaultViewID);
		}

		/**
		 * Removes the current view, leaving the <code>ViewNavigator</code>
		 * empty.
		 */
		public function clearView():void
		{
			if(_transitionIsActive)
			{
				_nextViewID = null;
				_clearAfterTransition = true;
				return;
			}

			clearViewInternal(true);
		}

		/**
		 * @private
		 */
		private function clearViewInternal(displayTransition:Boolean):void
		{
			if(!_activeView)
			{
				//no view visible.
				return;
			}

			if(displayTransition)
			{
				_transitionIsActive = true;
				_previousViewInTransition = _activeView;
				_previousViewInTransitionID = _activeViewID;
				transition(_previousViewInTransition, null, transitionComplete);
			}
			
			_activeView = null;
			_activeViewID = null;
		}

		/**
		 * Registers a new view by its identifier.
		 */
		public function addView(id:String, item:ViewNavigatorItem):void
		{
			if(_views.hasOwnProperty(id))
			{
				throw new IllegalOperationError("View with id '" + id + "' already defined. Cannot add two views with the same id.");
			}

			if(!defaultViewID)
			{
				//the first view will set the default ID if it is not set already
				defaultViewID = id;
			}

			_views[id] = item;
		}

		/**
		 * Removes an existing view using its identifier.
		 */
		public function removeView(id:String):void
		{
			if(!_views.hasOwnProperty(id))
			{
				throw new IllegalOperationError("View '" + id + "' cannot be removed because it has not been added.");
			}
			
			delete _views[id];
		}

		private function defaultTransition(oldView:DisplayObject, newView:DisplayObject, completeHandler:Function, model:TransitionModel = null):void
		{
			//in short, do nothing
			completeHandler();
		}

		/**
		 * @private
		 */
		private function transitionComplete():void
		{
			if(_previousViewInTransition)
			{
				if (_previousViewInTransition is IDestroyable)
				{
					IDestroyable(_previousViewInTransition).destroy();
				}
				
				removeChild(_previousViewInTransition);
				
				_previousViewInTransition = null;
				_previousViewInTransitionID = null;
			}
			
			_transitionIsActive = false; 

			if(_clearAfterTransition)
			{
				clearView();
			} else if(_nextViewID)
			{
				showView(_nextViewID);
			}

			_nextViewID = null;
			_clearAfterTransition = false;
			
			dispatchEvent(new ViewNavigatorEvent(ViewNavigatorEvent.CHANGED));
		}
	}
}