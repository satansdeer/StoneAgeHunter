package game.player {
	import animation.IcSprite;
	
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import game.HpLine;
	import game.gameActor.IcActer;

	public class Hunter extends IcActer {
		private var _hp:HpLine;
		
		private var _baseColor:uint;
		
		private var _debug:Boolean;
		
		private const ANIMATE_MOVE:String = "move";
		private const ANIMATE_STAY:String = "stay";
		
		public function Hunter(debug:Boolean) {
			super();
			_debug = debug;
			_baseColor = Math.random() * 0xffffff;
			path.setLinksColor(_baseColor);
			this.scaleX = .3;
			this.scaleY = .3;
			_hp = new HpLine(2);
			_hp.y = -20;
			addChild(_hp);
			addChild(new ManStayD());
			play(ANIMATE_STAY);
		}
		
		/* API */
		
		public function get hp():Number { return _hp.value; }
		public function set hp(value:Number):void {
			_hp.value = value;
		}
		
		public function damage(value:Number = 1):void {
			_hp.damage(value);
		}
		
		public function castStone():void {
		}
		
		override public function getAlternativeCopy(copyName:String=""):IcSprite {
			if (copyName == "") {
				const res:IcSprite = new IcSprite();
				res.graphics.beginFill(0xafafaf);
				res.graphics.drawRect(this.x, this.y, this.width, this.height);
				res.graphics.endFill();
				return res;
			}
			return this;
		}
		
		override public function move():void {
			super.move();
			if (pathTimeline && path) { play(ANIMATE_MOVE);}
		}
		
		override public function pauseMove():void {
			super.pauseMove();
			if (pathTimeline) { play(ANIMATE_STAY);}
		}
		
		public function onClick():void {
			startPath(new Point(this.x, this.y));
			filters = [new GlowFilter(_baseColor)];
		}
		public function unselect():void {
			filters = [];
		}
		
		/* Internal functions */
		
		override protected function stopMove():void {
			super.stopMove();
			play(ANIMATE_STAY);
		}

	}
}
