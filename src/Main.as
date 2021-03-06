﻿package {
	import game.map.tilemap.TileMap;
	import flash.events.Event;
	import game.GameScene;
	import game.MenuScene;
	import scene.SceneController;
	import flash.display.Sprite;
	
	[SWF(width=550, height=400, frameRate=25)]
	public class Main extends Sprite {
		private var _tileMap:TileMap;
		
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			_tileMap = new TileMap();
			//this.alpha = .03;
			start();
		}
		
		private function start():void {
			const sceneController:SceneController = new SceneController();
			const menuScene:MenuScene = new MenuScene(this);
			const gameScene:GameScene = new GameScene(this, _tileMap);
			sceneController.addScene(menuScene, true);
			sceneController.addScene(gameScene);
			sceneController.addSceneDependence(menuScene, gameScene, true);
		}
		
	}
}
