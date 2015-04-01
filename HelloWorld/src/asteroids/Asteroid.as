package asteroids 
{
	import engine.Body;
	import engine.Health;
	import engine.Physics;
	import engine.Entity;
	import engine.Renderable;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Asteroid extends Entity 
	{
		
		public function Asteroid() 
		{
			var body:Body = new Body(this);
            body.radius = 20;
            body.x = Math.random() * 800;
            body.y = Math.random() * 600;
			addComponent(body, "Body");
           
            var physics:Physics = new Physics(this);
            physics.velocityX = (Math.random() * 10) - 5;
            physics.velocityY = (Math.random() * 10) - 5;
			addComponent(physics, "Physics");
            
            var rend:Renderable = new Renderable(this);
            rend.sprite = new Sprite();
            rend.sprite.graphics.lineStyle(1.5, 0xFFFFFF);
            rend.sprite.graphics.drawCircle(0, 0, body.radius);
			addComponent(rend, "Renderable");
             
            var health:Health = new Health(this);
            health.hitPoints = 3;
            health.hurt.add(onHurt);
			addComponent(health, "Health");
		}
		
		override public function update():void
        {
            super.update();
			
			var body:Body = getComponent("Body");
			if (body)
			{
				for each (var target:Entity in targets)
				{
					if (body.testCollision(target))
					{
						var health:Health = target.getComponent("Health");
						if (health)
						{
							health.hit(1);
							destroy();
							return;
						}
					}
				}
			}
        }
		
		protected function onHurt(entity:Entity):void
        {
			var body:Body = getComponent("Body");
			var rend:Renderable = getComponent("Renderable");
			
			if (body && rend)
			{
				body.radius *= 0.75;
				rend.scale *= 0.75;
				
				if (body.radius < 10)
				{
					destroy();
					return;
				}
				
				var asteroid:Asteroid = new Asteroid();
				
				asteroid.targets = targets;
				asteroid.group = group;
				group.push(asteroid);
				
				var astBody:Body = asteroid.getComponent("Body");
				astBody.x = body.x;
				astBody.y = body.y;
				astBody.radius = body.radius;
				
				var astRend:Renderable = asteroid.getComponent("Renderable");
				astRend.scale = rend.scale;
				
				entityCreated.dispatch(asteroid);
			}
        }
		
	}

}