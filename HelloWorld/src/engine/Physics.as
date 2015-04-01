package engine 
{
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Physics implements IComponent 
	{
		public var entity:Entity;
		public var drag:Number = 1;
		public var velocityX:Number = 0;
		public var velocityY:Number = 0;
		
		public function Physics(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function update():void
		{
			var body:Body = entity.getComponent("Body");
			if (body)
			{
				body.x += velocityX;
				body.y += velocityY;
				
				velocityX *= drag;
				velocityY *= drag;
			}
		}
		
		public function thrust(power:Number):void
		{
			var body:Body = entity.getComponent("Body");
			if (body)
			{
				velocityX += Math.sin( -body.angle) * power;
				velocityY += Math.cos( -body.angle) * power;
			}
		}
		
	}

}