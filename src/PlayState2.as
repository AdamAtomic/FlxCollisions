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
		protected var _focus:FlxSprite;
		
		public var blocks:FlxGroup;
		public var dispenser:FlxEmitter;
		
		override public function create():void
		{
			//Background
			FlxG.bgColor = 0xffacbcd7;

			//A bunch of blocks
			var block:FlxSprite;
			blocks = new FlxGroup();
			for(var i:uint = 0; i < 300; i++)
			{
				block = new FlxSprite(FlxU.floor(FlxG.random()*40)*16,FlxU.floor(FlxG.random()*30)*16).makeGraphic(16,16,0xff233e58);
				block.immovable = true;
				block.moves = false;
				block.active = false;
				blocks.add(block);
			}
			add(blocks);

			//Shoot nuts and bolts all over
			dispenser = new FlxEmitter();
			dispenser.gravity = 0;
			dispenser.setSize(640,480);
			dispenser.setXSpeed(-100,100);
			dispenser.setYSpeed(-100,100);
			dispenser.bounce = 0.5;
			dispenser.makeParticles(ImgGibs,300,16,true,0.8);
			dispenser.start(false,10,0.05);
			add(dispenser);
			
			//Camera tracker
			_focus = new FlxSprite(FlxG.width/2,FlxG.height/2).loadGraphic(ImgGibs,true);
			_focus.frame = 3;
			_focus.solid = false;
			add(_focus);
			FlxG.camera.follow(_focus);
			FlxG.camera.setBounds(0,0,640,480,true);
			
			//Instructions and stuff
			var tx:FlxText;
			tx = new FlxText(2,FlxG.height-12,FlxG.width,"Interact with ARROWS + SPACE, or press ENTER for next demo.");
			tx.scrollFactor.x = tx.scrollFactor.y = 0;
			tx.color = 0x49637a;
			add(tx);
			
			FlxG.watch(FlxG,"score","collision time");
			FlxG.watch(FlxG,"level","add time");
		}
		
		override public function update():void
		{
			//camera controls
			_focus.velocity.x = 0;
			_focus.velocity.y = 0;
			var focusSpeed:Number = 200;
			if(FlxG.keys.LEFT)
				_focus.velocity.x -= focusSpeed;
			if(FlxG.keys.RIGHT)
				_focus.velocity.x += focusSpeed;
			if(FlxG.keys.UP)
				_focus.velocity.y -= focusSpeed;
			if(FlxG.keys.DOWN)
				_focus.velocity.y += focusSpeed;
			
			super.update();
			collide();
			if(FlxG.keys.justReleased("ENTER"))
				FlxG.switchState(new PlayState3());
		}
	}
}
