package engine 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Health implements IComponent 
	{
		public var entity:Entity;
		public var hitPoints:int;
		public var died:Signal;
		public var hurt:Signal;
		
		public function Health(entity:Entity) 
		{
			this.entity = entity;
			
			died = new Signal(Entity);
			hurt = new Signal(Entity);
		}
		
		public function hit(damage:int):void
		{
			hitPoints -= damage;
			
			hurt.dispatch(entity);
			
			if (hitPoints <= 0)
				died.dispatch(entity);
		}
		
	}

}