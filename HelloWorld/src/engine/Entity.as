package engine 
{
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Entity implements IEntity 
	{
		private var _components:Dictionary;
		
		private var _entityCreated:Signal;
		private var _destroyed:Signal;
		
		private var _targets:Vector.<Entity>;
		private var _group:Vector.<Entity>;
		
		public function Entity() 
		{
			_components = new Dictionary();
			
			entityCreated = new Signal(Entity);
			destroyed = new Signal(Entity);
		}
		
		public function update():void 
		{
			var physics:Physics = _components["Physics"];
			if (physics) physics.update();
		}
		
		public function render():void 
		{
			var renderable:Renderable = _components["Renderable"];
			if (renderable) renderable.render();
		}
		
		public function destroy():void 
		{
			destroyed.dispatch(this);
			
			if (group) group.splice(group.indexOf(this), 1);
		}
		
		public function addComponent(component:IComponent, name:String):void 
		{
			_components[name] = component;
		}
		
		public function getComponent(name:String):* 
		{
			return _components[name];
		}
		
		public function removeComponent(name:String):* 
		{
			var comp:* = _components[name];
			_components[name] = null;
			return comp;
		}
		
		public function get entityCreated():Signal 
		{
			return _entityCreated;
		}
		
		public function set entityCreated(value:Signal):void 
		{
			_entityCreated = value;
		}
		
		public function get destroyed():Signal 
		{
			return _destroyed;
		}
		
		public function set destroyed(value:Signal):void 
		{
			_destroyed = value;
		}
		
		public function get targets():Vector.<Entity> 
		{
			return _targets;
		}
		
		public function set targets(value:Vector.<Entity>):void 
		{
			_targets = value;
		}
		
		public function get group():Vector.<Entity> 
		{
			return _group;
		}
		
		public function set group(value:Vector.<Entity>):void 
		{
			_group = value;
		}
		
	}

}