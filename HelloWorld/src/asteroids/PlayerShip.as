package asteroids 
{
	import engine.Game;
	import com.iainlobb.gamepad.Gamepad;
	import com.iainlobb.gamepad.KeyCode;
	import engine.Body;
	import engine.Entity;
	import engine.Health;
	import engine.Physics;
	import engine.Renderable;
	import engine.Weapon;
	import flash.display.Sprite;
	import flash.display.GraphicsPathWinding;
	
	/**
	 * ...
	 * @author FallenShard
	 */
	public class PlayerShip extends Entity 
	{
		protected var gamepad:Gamepad;
		
		public function PlayerShip() 
		{	
			var body:Body = new Body(this);
			body.x = 400;
			body.y = 300;
			addComponent(body, "Body");
			
			var physics:Physics = new Physics(this);
			physics.drag = 0.9;
			addComponent(physics, "Physics");
			
			var renderable:Renderable = new Renderable(this);
			renderable.sprite = new Sprite();
			renderable.sprite.graphics.lineStyle(1.5, 0xFFFFFF);
			renderable.sprite.graphics.drawPath(Vector.<int>([1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]), 
                                          Vector.<Number>([ -7.3, 10.3, -5.5, 10.3, -7, 0.6, -0.5, -2.8, 6.2, 0.3, 4.5, 10.3, 6.3, 10.3, 11.1, -1.4, -0.2, -9.6, -11.9, -1.3, -7.3, 10.3]),
                                          GraphicsPathWinding.NON_ZERO);
			addComponent(renderable, "Renderable");
			
			var health:Health = new Health(this);
			health.hitPoints = 5;
			health.died.add(onDied);
			addComponent(health, "Health");
			
			var weapon:Weapon = new Gun(this);
			addComponent(weapon, "Weapon");
			
			gamepad = new Gamepad(Game.stage, false);
			gamepad.fire1.mapKey(KeyCode.SPACEBAR);
		}
		
		override public function update():void
		{
			super.update();
			
			var body:Body = getComponent("Body");
			if (body)
			{
				body.angle += gamepad.x * 0.1;
				
				var physics:Physics = getComponent("Physics");
				if (physics)
				{
					physics.thrust( -gamepad.y);
				}
				
				if (gamepad.fire1.isPressed)
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