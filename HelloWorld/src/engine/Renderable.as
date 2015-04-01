package engine 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Renderable implements IComponent 
	{
		public var entity:Entity;
		public var scale:Number = 1;
		public var alpha:Number = 1;
		public var sprite:Sprite;
		
		public function Renderable(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function render():void
		{
			var body:Body = entity.getComponent("Body");
			if (body)
			{
 
				sprite.x = body.x;
				sprite.y = body.y;
				sprite.rotation = body.angle * (180 / Math.PI);
				sprite.alpha = alpha;
				sprite.scaleX = scale;
				sprite.scaleY = scale;
			}
		}
	}

}