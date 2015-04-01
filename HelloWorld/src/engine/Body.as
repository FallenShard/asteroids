package engine 
{
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Body implements IComponent 
	{
		public var entity:Entity;
		public var x:Number = 0;
		public var y:Number = 0;
		public var angle:Number = 0;
		public var radius:Number = 10;
		
		public function Body(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function testCollision(otherEntity:Entity):Boolean
		{
			var otherBody:Body = otherEntity.getComponent("Body");
			
			if (!otherBody)
				return false;
			
			var dx:Number = x - otherBody.x;
			var dy:Number = y - otherBody.y;
			
			return (dx * dx + dy * dy) <= (radius + otherBody.radius) * (radius + otherBody.radius);
		}
	}
}