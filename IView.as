package oak.control
{
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	
	import oak.interfaces.IData;
	import oak.interfaces.IDestroyable;
	
	public interface IView extends IBitmapDrawable, IEventDispatcher, IDestroyable, IData, IViewNavigatorItem, IViewTransition
	{
		
	}
}
