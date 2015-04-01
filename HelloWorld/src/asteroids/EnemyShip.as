package asteroids 
{
	import engine.Body;
	import engine.Entity;
	import engine.Health;
	import engine.Physics;
	import engine.Renderable;
	import engine.Weapon;
	import flash.display.GraphicsPathWinding;
    import flash.display.Sprite;
	
	/**
	 * ...
	 * @author FallenShard
	 */
	public class EnemyShip extends Entity 
	{
		protected var turnDirection:Number = 1;
		
		public function EnemyShip() 
		{	
			var body:Body = new Body(this);
			body.x = 750;
			body.y = 550;
			addComponent(body, "Body");
			
			var physics:Physics = new Physics(this);
			physics.drag = 0.9;
			addComponent(physics, "Physics");
			
			var rend:Renderable = new Renderable(this);
            rend.sprite = new Sprite();
            rend.sprite.graphics.lineStyle(1.5, 0xFFFFFF);
            rend.sprite.graphics.drawPath(Vector.<int>([1, 2, 2, 2, 2]), 
                                          Vector.<Number>([ 0, 10, 10, -10, 0, 0, -10, -10, 0, 10]),
                                          GraphicsPathWinding.NON_ZERO);
			addComponent(rend, "Renderable");
			
			var health:Health = new Health(this);
			health.hitPoints = 3;
			health.died.add(onDied);
			addComponent(health, "Health");
			
			var weapon:Weapon = new Gun(this);
			addComponent(weapon, "Weapon");
		}
		
		override public function update():void
		{
			super.update();
			
			if (Math.random() < 0.1) turnDirection = -turnDirection;
			
			var body:Body = getComponent("Body");
			if (body)
			{
				body.angle += turnDirection * 0.1;
				
				var physics:Physics = getComponent("Physics");
				if (physics)
				{
					physics.thrust(Math.random());
				}
				
				
				if (Math.random() < 0.05)
				{
					var weapon:Weapon = getComponent("Weapon");
					weapon.fire();
				}
			}
		}
		
		protected function onDied(entity:Entity):void
		{
			destroy();
		}
		
	}

}