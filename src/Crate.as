package
{
	import org.flixel.FlxSprite;
	
	public class Crate extends FlxSprite
	{
		[Embed(source="data/crate.png")] private var ImgCrate:Class;
		
		public function Crate(X:Number, Y:Number)
		{
			super(X,Y,ImgCrate);
			height = height-1;		//draw the crate 1 pixel into the floor
			acceleration.y = 400;
			drag.x = 200;
		}
	}
}