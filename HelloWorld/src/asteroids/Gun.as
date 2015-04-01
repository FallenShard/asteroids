package asteroids 
{
	import engine.Body;
	import engine.Entity;
	import engine.Physics;
	import engine.Weapon;
	
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Gun extends Weapon 
	{
		
		public function Gun(entity:Entity) 
		{
			super(entity);
			
		}
		
		override public function fire():void
		{
			var bullet:Bullet = new Bullet();
			bullet.targets = entity.targets;
			
			var entityBody:Body = entity.getComponent("Body");
			var bulletBody:Body = bullet.getComponent("Body");
			
			if (entityBody && bulletBody)
			{
				bulletBody.x = entityBody.x;
				bulletBody.y = entityBody.y;
				bulletBody.angle = entityBody.angle;
				
				var bulletPhysics:Physics = bullet.getComponent("Physics");
				if (bulletPhysics)
				{
					bulletPhysics.thrust(10);
				}
				
				entity.entityCreated.dispatch(bullet);
				super.fire();
			}
		}
		
	}

}