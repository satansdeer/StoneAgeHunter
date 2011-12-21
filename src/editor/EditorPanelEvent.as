/**
 * User: dima
 * Date: 21/12/11
 * Time: 5:51 PM
 */
package editor {
import flash.events.Event;

import game.DecorativeObject;


public class EditorPanelEvent extends Event{
	public static const PUT_ELEMENT:String = "putElement";

	private var _element:DecorativeObject;

	public function EditorPanelEvent(type:String, element:DecorativeObject) {
		super(type);
		_element = element;
	}

	public function get element():DecorativeObject { return _element; }
}
}
