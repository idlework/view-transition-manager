package
{
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;

	/**
	 * Data for an individual view that will be used by a <code>viewNavigator</code>
	 * object.

	 */
  public class ViewNavigatorItem 
  {
		/**
		 * Creates a new viewNavigatorItem instance.
		 * 
		 * @param view		Sets the view property.
		 * @param events		Sets the events property.
		 * 
		 * @see #view
		 * @see #events
		 */
    public function ViewNavigatorItem(view:Object, events:Object = null, initializer:Object = null )
    {
      this.view = view;
      this.events = events ? events : {};
      this.initializer = initializer ? initializer : {};
    }

		/**
		 * A DisplayObject instance or a Class that creates a display object.
		 */
    public var view:Object;

		/**
		 * A hash of events to which the viewNavigator will listen. Keys in
		 * the hash are event types, and values are one of two possible types.
		 * If the value is a String, it must refer to a view ID for the
		 * viewNavigator to display. If the value is a Function, it must
		 * be a listener for the view's event. 
		 */
    public var events:Object;

		/**
		 * A hash of properties to set on the view.
		 */
    public var initializer:Object;

  	/**
  	 * Creates and instance of the view type (or uses the view directly
  	 * if it isn't a class).
     */
    internal function getView():DisplayObject
    {
      var viewInstance:DisplayObject;

      if (this.view is Class)
      {
        var viewType:Class = Class(this.view);
        viewInstance = new viewType();
      } else if (this.view is DisplayObject)
      {
        viewInstance = DisplayObject(this.view);
      } else {
        throw new IllegalOperationError("viewNavigatorItem \"view\" must be a Class or a display object.");
      }

      if (this.initializer)
      {
        for (var property:String in this.initializer)
        {
          viewInstance[property] = this.initializer[property];
        }
      }

      return viewInstance;
    }
  }
}