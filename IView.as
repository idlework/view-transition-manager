package
{
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	
	public interface IView extends IBitmapDrawable, IEventDispatcher, IViewNavigatorItem, IViewTransition
	{
	}
}