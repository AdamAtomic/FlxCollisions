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
			
			//Add game objects
			add(new Elevator(208,80,112));
			add(new Pusher(96,208,56));
			_player = new Player(32,176);
			add(_player);
			add(new Crate(64,208));
			add(new Crate(108,176));
			add(new Crate(140,176));
			add(new Crate(192,208));
			add(new Crate(272,48));
			
			//This is the thing that spews nuts and bolts
			var dispenser:FlxEmitter = new FlxEmitter(32,40);
			dispenser.setSize(30,10);
			dispenser.setXSpeed(100,300);
			dispenser.setYSpeed(-50,50);
			dispenser.gravity = 300;
			dispenser.bounce = 0.1;
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
					_player.followPath(path,80);
				}
			}//*/
			
			super.update();
			FlxG.collide();
			if(FlxG.keys.justReleased("ENTER"))
				FlxG.switchState(new PlayState2());
		}
	}
}
