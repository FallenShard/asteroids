package asteroids 
{
	import engine.Body;
	import engine.Entity;
	import engine.Health;
	import engine.Physics;
	import engine.Renderable;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Bullet extends Entity 
	{
		public var age:int;
		
		public function Bullet() 
		{
			super();
			
			var body:Body = new Body(this);
			body.radius = 5;
			addComponent(body, "Body");
			
			var physics:Physics = new Physics(this);
			addComponent(physics, "Physics");
			
			var renderable:Renderable = new Renderable(this);
			renderable.sprite = new Sprite();
			renderable.sprite.graphics.beginFill(0xFFFFFF);
			renderable.sprite.graphics.drawCircle(0, 0, body.radius);
			addComponent(renderable, "Renderable");
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
						var targetHealth:Health = target.getComponent("Health");
						if (targetHealth)
						{
							targetHealth.hit(1);
							destroy();
							return;
						}
					}
				}
			}
			
			age++;
			if (age > 20)
			{
				var rend:Renderable = getComponent("Renderable");
				rend.alpha -= 0.2;
			}
			
			if (age > 25)
			{
				destroy();
			}
		}
	}

}