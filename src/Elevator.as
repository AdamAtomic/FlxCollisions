package
{
	import org.flixel.*;
	
	public class Elevator extends FlxSprite
	{
		[Embed(source="data/elevator.png")] private var ImgElevator:Class;
		
		protected var _y:int;
		protected var _height:int;
		
		public function Elevator(X:Number, Y:Number, Height:Number)
		{
			super(X, Y, ImgElevator);
			width = 48;			//Minor bounding box adjustment
			_y = Y;				//The starting height
			_height = Height;	//How far down to travel
			fixed = true;		//We want the elevator to be "solid" and not shift during collisions
			velocity.y = 40;	//Basic elevator speed
		}
		
		override public function update():void
		{
			//Update the elevator's motion
			super.update();
			
			//Turn around if necessary
			if(y > _y + _height)
			{
				y = _y + _height;
				velocity.y = -velocity.y;
			}
			else if(y < _y)
			{
				y = _y; 
				velocity.y = -velocity.y;
			}
		}
	}
}