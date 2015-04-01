package engine 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Game extends Sprite
	{
		public var entities:Vector.<Entity> = new Vector.<Entity>();
		
		public var isPaused:Boolean;
		
		static public var stage:Stage;
		
		public function Game() 
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			if (isPaused) return;
			
			update();
			
			render();
		}
		
		protected function update():void
		{
			for each (var entity:Entity in entities) entity.update();
		}
		
		protected function render():void
		{
			for each (var entity:Entity in entities) entity.render();
		}
		
		protected function onAddedToStage(event:Event):void
		{
			Game.stage = stage;
			
			startGame();
		}
		
		protected function startGame():void
		{
			
		}
		
		protected function stopGame():void
		{
			for each (var entity:Entity in entities)
			{
				var rend:Renderable = entity.getComponent("Renderable");
				if (rend) removeChild(rend.sprite);
			}
			
			entities.length = 0;
		}
		
		public function addEntity(entity:Entity):Entity
		{
			entities.push(entity);
			
			entity.destroyed.add(onEntityDestroyed);
			entity.entityCreated.add(addEntity);
			
			var rend:Renderable = entity.getComponent("Renderable");
			if (rend)
			{
				addChild(rend.sprite);
			}
			
			return entity;
		}
		
		protected function onEntityDestroyed(entity:Entity):void
		{
			entities.splice(entities.indexOf(entity), 1);
			
			var rend:Renderable = entity.getComponent("Renderable");
			if (rend)
			{
				removeChild(rend.sprite);
			}
				
		    entity.destroyed.remove(onEntityDestroyed);
		}
		
	}

}