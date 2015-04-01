package engine 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author FallenShard
	 */
	public interface IEntity 
	{
		// ACTIONS
		function update():void;
		function render():void;
		function destroy():void;
		
		// COMPONENTS
		function addComponent(component:IComponent, name:String):void;
		function getComponent(name:String):*;
		function removeComponent(name:String):*;
		
		// SIGNALS
		function get entityCreated():Signal; 
		function set entityCreated(value:Signal):void;
		function get destroyed():Signal; 
		function set destroyed(value:Signal):void; 
		
		// DEPENDENCIES
		function get targets():Vector.<Entity>; 
		function set targets(value:Vector.<Entity>):void;
		function get group():Vector.<Entity>; 
		function set group(value:Vector.<Entity>):void; 
	}
	
}