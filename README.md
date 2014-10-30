A "view stack"-like container that supports transitions between views. The project already contains 3 transitions(push, overlay and underlay) but is easily extendable to create your own. look in the transition folder for how I setup the transition models.

This view transition manager depends on the transition library made by Grant Skinner and can be found [here](http://gskinner.com/libraries/gtween/). Feel free to replace it with an other one to your likings.

FYI: These classes were made years ago and don't have any support to them. But I got a lot of question about view transitions so I put this online for anyone tot see. Maybe it helps you out.

A quick example on how to use the view navigator:
	   
	private const FIRST_VIEW:String = "firstView";
	private const SECOND_VIEW:String = "secondView";
	private const THIRD_VIEW:String = "thirdView";
	private const FOURTH_VIEW:String = "fourthView";
		
	private var _views:Array = [FIRST_VIEW, SECOND_VIEW, THIRD_VIEW, FOURTH_VIEW];
		
	private var _navigator:ViewNavigator;
	private var _transitionManager:ViewTransitionManager;
		
	public function ViewSwitcher()
	{
		addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
	}
		
	private function _addedToStageHandler(event:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
		
		stage.addEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);		
		_navigator = new ViewNavigator();
		addChild(_navigator);
		
		_navigator.addView(FIRST_VIEW, new ViewNavigatorItem(FirstView));
		_navigator.addView(SECOND_VIEW, new ViewNavigatorItem(SecondView));
		_navigator.addView(THIRD_VIEW, new ViewNavigatorItem(ThirdView));
		_navigator.addView(FOURTH_VIEW, new ViewNavigatorItem(FourthView));
		_navigator.showView(FIRST_VIEW);
		
		_transitionManager = new ViewTransitionManager(_navigator);
		_transitionManager.duration = .4;
		_transitionManager.ease = Cubic.easeInOut;	}
		
	private function _keyUpHandler(event:KeyboardEvent):void
	{
		if (_transitionManager.isRunning) return;
		
		var model:TransitionStackModel = new TransitionStackModel(TransitionDirections.ALL_TYPES[Random.integer(0, 3)]);
		
		_navigator.showView(_views[Random.integer(0, 3)], model);
	}