package
{
	import org.flixel.*;
	
	public class PlayState2 extends FlxState
	{
		[Embed(source="data/map2.png")] private var ImgMap:Class;
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/bg.png")] private var ImgBG:Class;
		[Embed(source="data/gibs.png")] private var ImgGibs:Class;
		
		protected var _fps:FlxText;
		
		protected var _camera:FlxSprite;
		
		override public function create():void
		{
			//Background
			FlxState.bgColor = 0xffacbcd7;
			
			//A bunch of blocks
			var block:FlxSprite;
			for(var i:uint = 0; i < 100; i++)
			{
				block = new FlxSprite(FlxU.floor(FlxU.random(false)*40)*16,FlxU.floor(FlxU.random(false)*30)*16).createGraphic(16,16,0xff233e58);
				block.fixed = true;
				block.moves = false;
				add(block);
			}
			
			//Shoot nuts and bolts all over
			var dispenser:FlxEmitter = new FlxEmitter();
			dispenser.gravity = 0;
			dispenser.setSize(640,480);
			dispenser.setXSpeed(-100,100);
			dispenser.setYSpeed(-100,100);
			dispenser.createSprites(ImgGibs,500,16,true,0.8);
			dispenser.start(false,0,0.01);
			add(dispenser);
			
			//Camera tracker
			_camera = new FlxSprite(FlxG.width/2,FlxG.height/2).loadGraphic(ImgGibs,true);
			_camera.frame = 3;
			_camera.solid = false;
			FlxG.follow(_camera,5);
			FlxG.followBounds(0,0,640,480);
			add(_camera);
			
			//Instructions and stuff
			_fps = new FlxText(FlxG.width-40,0,40).setFormat(null,8,0x49637a,"right");
			_fps.scrollFactor.x = _fps.scrollFactor.y = 0;
			add(_fps);
			var tx:FlxText;
			tx = new FlxText(2,FlxG.height-12,FlxG.width,"Interact with ARROWS + SPACE, or press ENTER for next demo.");
			tx.scrollFactor.x = tx.scrollFactor.y = 0;
			tx.color = 0x49637a;
			add(tx);
		}
		
		override public function update():void
		{
			_fps.text = FlxU.floor(1/FlxG.elapsed)+" fps";
			
			//camera controls
			_camera.velocity.x = 0;
			_camera.velocity.y = 0;
			if(FlxG.keys.LEFT)
				_camera.velocity.x -= 100;
			if(FlxG.keys.RIGHT)
				_camera.velocity.x += 100;
			if(FlxG.keys.UP)
				_camera.velocity.y -= 100;
			if(FlxG.keys.DOWN)
				_camera.velocity.y += 100;
			
			super.update();
			collide();
			if(FlxG.keys.justReleased("ENTER"))
				FlxG.state = new PlayState3();
		}
	}
}
