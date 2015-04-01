package asteroids 
{
	import engine.Body;
	import engine.Entity;
	import engine.Game;
	import engine.Health;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author FallenShard
	 */
	[SWF(backgroundColor="0x000044")]
	public class AsteroidsGame extends Game 
	{
		public var players:Vector.<Entity> = new Vector.<Entity>();
		public var enemies:Vector.<Entity> = new Vector.<Entity>();
		public var messageField:TextField;
		public var hitpoints:TextField;
		
		public function AsteroidsGame() 
		{
			this.graphics.clear();
		}
		
		override protected function startGame():void
		{
			var asteroid:Asteroid;
			for (var i:int = 0; i < 10; i++)
			{
				asteroid = new Asteroid();
				asteroid.targets = players;
				asteroid.group = enemies;
				enemies.push(asteroid);
				addEntity(asteroid);
			}
			
			var player:PlayerShip = new PlayerShip();
			player.targets = enemies;
			player.destroyed.add(onPlayerDestroyed);
			players.push(player);
			addEntity(player);
			
			var enemy:EnemyShip = new EnemyShip();
			enemy.targets = players;
			enemy.group = enemies;
			enemies.push(enemy);
			addEntity(enemy);
			
			filters = [new GlowFilter(0xFFFFFF, 0.8, 6, 6, 1)];
			
			update();
			
			render();
			
			isPaused = true;
			
			if (messageField)
			{
				addChild(messageField);
			}
			else
			{
				createMessage();
			}
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, start);
		}
		
		protected function createMessage():void
		{
			messageField = new TextField();
			messageField.selectable = false;
			messageField.textColor = 0xFF0000;
			messageField.width = 600;
			messageField.scaleX = 2;
			messageField.scaleY = 3;
			messageField.text = "CLICK TO START";
			messageField.x = 400 - messageField.textWidth;
			messageField.y = 240;
			addChild(messageField);
		}
		
		protected function createHitpointsView():void
		{
			if (hitpoints && contains(hitpoints))
				removeChild(hitpoints);
			hitpoints = new TextField();
			hitpoints.x = 20;
			hitpoints.y = 20;
			hitpoints.textColor = 0xFFFFFF;
			addChild(hitpoints);
			
			var hp:Health = players[0].getComponent("Health");
			hp.hurt.add(onPlayerHurt);
			hitpoints.text = "Hitpoints: " + hp.hitPoints;
		}
		
		protected function start(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, start);
			isPaused = false;
			createHitpointsView();
			removeChild(messageField);
			stage.focus = stage;
		}
		
		protected function onPlayerDestroyed(entity:Entity):void
		{
			gameOver();
		}
		
		protected function gameOver():void
		{
			removeChild(hitpoints);
			addChild(messageField);
			isPaused = true;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, restart);
		}
		
		protected function restart(event:MouseEvent):void
		{
			stopGame();
			startGame();
			
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, restart);
			isPaused = false;
			createHitpointsView();
			removeChild(messageField);
			stage.focus = stage;
		}
		
		override protected function stopGame():void
        {
            super.stopGame();
             
            players.length = 0;
            enemies.length = 0;
        }
         
        override protected function update():void
        {
            super.update();
             
            for each (var entity:Entity in entities)
            {
				var body:Body = entity.getComponent("Body");
				if (body)
				{
					if (body.x > 850) body.x -= 900;
					if (body.x < -50) body.x += 900;
				 
					if (body.y > 650) body.y -= 700;
					if (body.y < -50) body.y += 700;
				}
				
                
            }
             
            if (enemies.length == 0) gameOver();
        }
		
		protected function onPlayerHurt(entity:Entity):void
		{
			var hp:Health = entity.getComponent("Health");

			hitpoints.text = "Hitpoints: " + hp.hitPoints;

		}
		
	}

}