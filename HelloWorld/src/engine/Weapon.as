package engine 
{
	/**
	 * ...
	 * @author FallenShard
	 */
	public class Weapon implements IComponent 
	{
		public var entity:Entity;
		public var ammo:int;
		
		public function Weapon(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function fire():void
		{
			ammo--;
		}
	}

}