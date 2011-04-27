package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;

	public class PlayState extends FlxState
	{
		[Embed(source="data/map.png")] private var ImgMap:Class;
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/bg.png")] private var ImgBG:Class;
		[Embed(source="data/gibs.png")] private var ImgGibs:Class;
		
		[Embed(source="data/pusher.png")] private var ImgPusher:Class;
		[Embed(source="data/elevator.png")] private var ImgElevator:Class;
		[Embed(source="data/crate.png")] private var ImgCrate:Class;
		
		protected var _level:FlxTilemap;
		protected var _player:Player;
		
		override public function create():void
		{			
			//Background
			FlxG.bgColor = 0xffacbcd7;
			var decoration:FlxSprite = new FlxSprite(256,159,ImgBG);
			decoration.moves = false;
			decoration.solid = false;
			add(decoration);
			add(new FlxText(32,36,96,"collision").setFormat(null,16,0x778ea1,"center"));
			add(new FlxText(32,60,96,"DEMO").setFormat(null,24,0x778ea1,"center"));
			
			var path:FlxPath;
			var sprite:FlxSprite;
			var destination:FlxPoint;
			
			//Create the elevator and put it on a up and down path
			sprite = new FlxSprite(208,80,ImgElevator);
			sprite.immovable = true;
			destination = sprite.getMidpoint();
			destination.y += 112;
			path = new FlxPath([sprite.getMidpoint(),destination]);
			sprite.followPath(path,40,FlxObject.PATH_YOYO);
			add(sprite);
			
			//Create the side-to-side pusher object and put it on a different path
			sprite = new FlxSprite(96,208,ImgPusher);
			sprite.immovable = true;
			destination = sprite.getMidpoint();
			destination.x += 56;
			path = new FlxPath([sprite.getMidpoint(),destination]);
			sprite.followPath(path,40,FlxObject.PATH_YOYO);
			add(sprite);
			
			//Then add the player, its own class with its own logic
			_player = new Player(32,176);
			add(_player);
			
			//Then create the crates that are sprinkled around the level
			var crates:Array = [new FlxPoint(64,208),
								new FlxPoint(108,176),
								new FlxPoint(140,176),
								new FlxPoint(192,208),
								new FlxPoint(272,48)];
			for(var i:uint = 0; i < crates.length; i++)
			{
				sprite = new FlxSprite((crates[i] as FlxPoint).x,(crates[i] as FlxPoint).y,ImgCrate);
				sprite.height = sprite.height-1;
				sprite.acceleration.y = 400;
				sprite.drag.x = 200;
				add(sprite);
			}
			
			//This is the thing that spews nuts and bolts
			var dispenser:FlxEmitter = new FlxEmitter(32,40);
			dispenser.setSize(8,40);
			dispenser.setXSpeed(100,240);
			dispenser.setYSpeed(-50,50);
			dispenser.gravity = 300;
			dispenser.bounce = 0.3;
			dispenser.makeParticles(ImgGibs,100,16,true,0.8);
			dispenser.start(false,10,0.035);
			add(dispenser);
			
			//Basic level structure
			_level = new FlxTilemap();
			_level.loadMap(FlxTilemap.imageToCSV(ImgMap,false,2),ImgTiles,0,0,FlxTilemap.ALT);
			_level.follow();
			add(_level);
			
			//Library label in upper left
			var tx:FlxText;
			tx = new FlxText(2,0,FlxG.width/4,FlxG.getLibraryName());
			tx.scrollFactor.x = tx.scrollFactor.y = 0;
			tx.color = 0x778ea1;
			tx.shadow = 0x233e58;
			add(tx);
			
			//Instructions
			tx = new FlxText(2,FlxG.height-12,FlxG.width,"Interact with ARROWS + SPACE, or press ENTER for next demo.");
			tx.scrollFactor.x = tx.scrollFactor.y = 0;
			tx.color = 0x778ea1;
			tx.shadow = 0x233e58;
			add(tx);
			
			/*part of silly path-finding test
			FlxG.mouse.show();
			FlxG.visualDebug = true;//*/
		}
		
		override public function destroy():void
		{
			super.destroy();
			_level = null;
			_player = null;
		}
		
		override public function update():void
		{
			/*silly path-finding test
			if(FlxG.mouse.justPressed())
			{
				var path:FlxPath = _level.findPath(_player.getMidpoint(),FlxG.mouse,true,true);
				if(path != null)
				{
					if(_player.path != null)
						_player.path.destroy();
					_player.followPath(path,80,FlxObject.PATH_FORWARD|FlxObject.PATH_HORIZONTAL_ONLY);
				}
			}//*/
			
			super.update();
			FlxG.collide();
			if(FlxG.keys.justReleased("ENTER"))
				FlxG.switchState(new PlayState2());
		}
	}
}
