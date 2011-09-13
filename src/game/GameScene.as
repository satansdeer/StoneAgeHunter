package game {
	import flash.filters.GlowFilter;
	import scene.SceneEvent;
	import com.bit101.components.PushButton;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import game.player.Hunter;
	import tilemap.TileMap;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import scene.IScene;

	public class GameScene extends EventDispatcher implements IScene {
		private var _container:Sprite;
		private var _tileMap:TileMap;
		private var _hunters:Vector.<Hunter>;
		
		private var _goBtn:PushButton;
		private var _pauseBtn:PushButton;
		private var _clearBtn:PushButton;
		private var _goMenuBtn:PushButton;
		
		private var _drawingContainer:Sprite;
		private var _drawing:Boolean;
		private var _moving:Boolean;
		private var _selectedHunter:Hunter;
		
		public function GameScene(container:Sprite, tileMap:TileMap):void {
			super();
			_container = container;
			_tileMap = tileMap;
			_drawingContainer = new Sprite();
		}
		
		public function open():void {
			_drawing = false;
			_moving = false;
			_container.addChild(_tileMap);
			createHunters();
			addButtons();
			_container.addChild(_drawingContainer);
			addListeners();
		}
		public function close():void {
			removeListeners();
			_container.removeChild(_tileMap);
			removeHunters();
			removeButtons();
			_container.removeChild(_drawingContainer);
		}
		
		/* Internal functions */
		
		private function createHunter():Hunter {
			const hunter:Hunter = new Hunter();
			hunter.x = Math.random() * 250 + 50;
			hunter.y = Math.random() * 150 + 50;
			_container.addChild(hunter);
			addHunterListeners(hunter);
			return hunter;
		}
		
		private function createHunters():void {
			_hunters = new Vector.<Hunter>();
			for (var i:int = 0; i < 5; ++i) {
				_hunters.push(createHunter());
			}
		}
		
		private function removeHunters():void {
			for each (var hunter:Hunter in _hunters) {
				removeHunterListeners(hunter);
				_container.removeChild(hunter);
				hunter.remove();
			}
			_hunters = null;
		}
		
		private function addHunterListeners(hunter:Hunter):void {
			hunter.addEventListener(MouseEvent.CLICK, onHunterClick);
		}
		private function removeHunterListeners(hunter:Hunter):void {
			hunter.removeEventListener(MouseEvent.CLICK, onHunterClick);
		}
		
		private function addListeners():void {
			_tileMap.addEventListener(MouseEvent.CLICK, onTileMapClick);
		}
		
		private function removeListeners():void {
			_tileMap.removeEventListener(MouseEvent.CLICK, onTileMapClick);
		}
		
		private function unClickAll():void {
			for each (var hunter:Hunter in _hunters) {
				hunter.filters = [];
			}
		}
		
		private function onHunterClick(event:MouseEvent):void {
			unClickAll();
			const hunter:Hunter = findClickedHunter(event.stageX, event.stageY);
			if (hunter) {
				_drawing = true;
				_selectedHunter = hunter;
				hunter.filters = [new GlowFilter()];
				drawHunterExistingPath();
			}
		}
		
		private function drawHunterExistingPath():void {
			if (!_selectedHunter) { return; }
			_drawingContainer.graphics.lineStyle(3, 0xffaabb);
			_drawingContainer.graphics.moveTo(_selectedHunter.x + _selectedHunter.width/2,
																					_selectedHunter.y + _selectedHunter.height/2);
			if (_selectedHunter.path &&
					_selectedHunter.path.length > 0) {
				for each (var point:Point in _selectedHunter.path) {
					_drawingContainer.graphics.lineTo(point.x, point.y);
				}
			}
		}
		
		private function findClickedHunter(x:Number, y:Number):Hunter {
			for each (var hunter:Hunter in _hunters) {
				if (hunter.hitTestPoint(x, y)) { return hunter; }
			}
			return null;
		}
		
		private function onTileMapClick(event:MouseEvent):void {
			if (_drawing) {
				if (findClickedHunter(event.stageX, event.stageY) == null) {
					_drawingContainer.graphics.lineTo(event.stageX, event.stageY);
					addToPath(new Point(event.stageX, event.stageY));
				}
			}
		}
		
		private function addToPath(point:Point):void {
			if (_selectedHunter) {
				_selectedHunter.addWayPoint(point);
			}
		}
		
		//TODO bad memory managment here, forgot remove listeners
		private function addButtons():void {
			_goBtn = new PushButton(_container, 300, 50, "lets go", onButtonGoClick);
			_pauseBtn = new PushButton(_container, 300, 70, "pause", onButtonPauseClick);
			_clearBtn = new PushButton(_container, 300, 90, "clear", onButtonClearClick);
			_goMenuBtn = new PushButton(_container, 300, 110, "go to menu", onButtonMenuClick);
		}
		
		private function removeButtons():void {
			if (_container.contains(_goBtn)) { _container.removeChild(_goBtn); }
			if (_container.contains(_pauseBtn)) { _container.removeChild(_pauseBtn); }
			if (_container.contains(_clearBtn)) { _container.removeChild(_clearBtn); }
			if (_container.contains(_goMenuBtn)) { _container.removeChild(_goMenuBtn); }
		}
		
		private function onButtonGoClick(event:MouseEvent):void {
			_drawing = false;
			for each (var hunter:Hunter in _hunters) {
				hunter.move();
			}
		}
		
		private function onButtonPauseClick(event:MouseEvent):void {
			for each (var hunter:Hunter in _hunters) {
				hunter.pauseMove();
			}
		}
		
		private function onButtonClearClick(event:MouseEvent):void {
			_drawingContainer.graphics.clear();
			_drawing = false;
		}
		
		private function onButtonMenuClick(event:MouseEvent):void {
			event.stopPropagation();
			dispatchEvent(new SceneEvent(SceneEvent.SWITCH_ME, this));
		}
		
	}
}
