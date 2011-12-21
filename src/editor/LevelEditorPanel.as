/**
 * User: Dmitry
 * Date: 10/22/11
 * Time: 9:15 PM
 */
package editor {
import com.bit101.components.PushButton;

import flash.display.MovieClip;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;

import game.DecorativeObject;

import game.LevelDecorationManager;

public class LevelEditorPanel extends Sprite{
	private var _stoneBtn:Sprite;
	private var _hillBtn:Sprite;

	private var _movingElement:MovieClip;
	private var _drag:Boolean;

	private var _closeBtn:PushButton;

	public function LevelEditorPanel() {
		super();
		_drag = false;
		createBtns();
		createBtns();
		addListeners();
	}

	public function get closeBtn():PushButton { return _closeBtn; }

	/* Internal functions */

	private function addListeners():void {
		this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}

	private function createBtns():void {
		_stoneBtn = new Sprite();
		_stoneBtn.addChild(LevelDecorationManager.getDecorationElement(LevelDecorationManager.STONE));
		_stoneBtn.filters = [new GlowFilter(0)];
		_stoneBtn.x = 150;
		_stoneBtn.y = 20;
		_hillBtn = new Sprite();
		_hillBtn.addChild(LevelDecorationManager.getDecorationElement(LevelDecorationManager.LITTLE_HILL));
		_hillBtn.filters = [new GlowFilter(0)];
		_hillBtn.x = 250;
		_hillBtn.y = 20;
		_stoneBtn.addEventListener(MouseEvent.MOUSE_DOWN, onStoneBtnMouseDown);
		_hillBtn.addEventListener(MouseEvent.MOUSE_DOWN, onHillBtnMouseDown);

		trace("[LevelEditorPanel.createTileBtns] tiles created");
		addChild(_stoneBtn);
		addChild(_hillBtn);
		_closeBtn = new PushButton(this, 10, 10, "close");
	}

	private function onMouseMove(event:MouseEvent):void {
		if (_drag) {
			_movingElement.x = event.stageX;
			_movingElement.y = event.stageY;
		}
	}
	private function onMouseDown(event:MouseEvent):void {
		if (_drag) {
			_drag = false;
			this.removeChild(_movingElement);
			dispatchEvent(new EditorPanelEvent(EditorPanelEvent.PUT_ELEMENT, new DecorativeObject(_movingElement)));
		}
	}

	private function onStoneBtnMouseDown(event:MouseEvent):void {
		if (_drag) { return; }
		_movingElement = LevelDecorationManager.getDecorationElement(LevelDecorationManager.STONE);
		this.addChild(_movingElement);
		_drag = true;
		event.stopPropagation();
	}
	private function onHillBtnMouseDown(event:MouseEvent):void {
		if (_drag) { return; }
		_movingElement = LevelDecorationManager.getDecorationElement(LevelDecorationManager.LITTLE_HILL);
		this.addChild(_movingElement);
		_drag = true;
		event.stopPropagation();
	}

}
}
