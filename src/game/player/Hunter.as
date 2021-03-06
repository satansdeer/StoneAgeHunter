package game.player {
	import animation.IcSprite;

import flash.display.Sprite;

import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import game.player.HpLine;
	import game.armor.Stone;
	import game.gameActor.IcActor;
import game.gameActor.IcActerEvent;

public class Hunter extends IcActor {
		private var _pathParts:Vector.<Sprite>;

		/* hitpoints line */
		private var _hp:HpLine;
		
		/* stone, witch took the hunter */
		private var _stone:Stone;

		/* hunter's color of glow and path */
		private var _baseColor:uint;

		/* point where hunter moving now */
		private var _targetPoint:Point;
		
		private var _debug:Boolean;
		
		public function Hunter(debug:Boolean) {
			super();
			_debug = debug;
			_baseColor = Math.random() * 0xffffff;
			path.setLinksColor(_baseColor);
			setScale(.3);
			_hp = new HpLine(2);
			_hp.y = -20;
			addAnimations();
			play(ANIMATE_STAY);
		}
		
		/* API */

		public function set targetPoint(value:Point):void { _targetPoint = value; }
		public function get targetPoint():Point { return _targetPoint; }
		
		// for debug
		public function setScale(value:Number):void {
			animationScale = value;
		}
		
		public function get hp():Number { return _hp.value; }
		public function set hp(value:Number):void {
			_hp.value = value;
		}

		//for debug
		public function get hpBar():Sprite { return _hp; }

		public function get baseColor():uint { return _baseColor; }
		
		public function damage(value:Number = 1):void {
			_hp.damage(value);
		}
		
		public function get hasStone():Boolean {
			return _stone != null;
		}
		
		public function putStone(stone:Stone):void {
			_stone = stone;
			stone.x = this.width/5;
			stone.y = this.height/4;
			this.addChild(stone);
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
		
		public function startFollowPath():void {
			trace("[Hunter.startFollowPath]");
			removePrevTween();
			move();
		}

		public function get pathParts():Vector.<Sprite> { return _pathParts; }

		public function addPathPart(pathPart:Sprite):void {
			if (!_pathParts) { _pathParts = new Vector.<Sprite>(); }
			_pathParts.push(pathPart);
			 super.addWayPoint(new Point(pathPart.x,  pathPart.y));
		}


		public function needDrawLine(x:Number,  y:Number):Boolean {
			if (_pathParts && _pathParts.length > 0) {
				if ( (_pathParts[_pathParts.length-1].x - x < 6 &&
					_pathParts[_pathParts.length-1].x - x > -6) &&
					(_pathParts[_pathParts.length-1].y - y < 6 &&
						_pathParts[_pathParts.length-1].y - y > -6) ) {
							return false;
						}
			}
			return true;
		}

		override public function move():void {
			super.move();
			play(ANIMATE_MOVE);
		}
		
		override public function stop():void {
			play(ANIMATE_STAY);
		}

		override protected function onStartTween(point:Point):void {
			play(ANIMATE_MOVE);
			super.onStartTween(point);
		}
		
		override public function pauseMove():void {
			super.pauseMove();
			if (pathTimeline) { play(ANIMATE_STAY); }
		}
		
		/* Internal functions */
		
		private function addAnimations():void {
			addAnimation(ANIMATE_STAY, new ManStayD(), new ManStayU());
			addAnimation(ANIMATE_MOVE, new ManRunD(), new ManRunU());
		}
		
	}
}
