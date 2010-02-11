package
{
	import org.flixel.*;
	
	public class Pusher extends FlxSprite
	{
		[Embed(source="data/pusher.png")] private var ImgPusher:Class;
		
		protected var _x:int;
		protected var _width:int;
		
		public function Pusher(X:Number, Y:Number, Width:Number)
		{
			super(X, Y, ImgPusher);
			_x = X;				//The starting height
			_width = Width;		//How far over to travel
			fixed = true;		//We want the pusher to be "solid" and not shift during collisions
			velocity.x = 40;	//Basic pusher speed
		}
		
		override public function update():void
		{
			//Update the elevator's motion
			super.update();
			
			//Turn around if necessary
			if(x > _x + _width)
			{
				x = _x + _width;
				velocity.x = -velocity.x;
			}
			else if(x < _x)
			{
				x = _x;
				velocity.x = -velocity.x;
			}
		}
	}
}