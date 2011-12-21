package game
{
	import flash.display.MovieClip;

public class LevelDecorationManager {
		public static const STALACTITE0:String = "stalactyte0";
		public static const STALACTITE1:String = "stalactyte1";
		public static const STALACTITE2:String = "stalactyte2";
		public static const STALACTITE3:String = "stalactyte3";
		public static const STALACTITE4:String = "stalactyte4";
		public static const STALACTITE5:String = "stalactyte5";
		public static const STALACTITE6:String = "stalactyte6";
		public static const STALACTITE7:String = "stalactyte7";
		public static const STALACTITE8:String = "stalactyte8";
		public static const STALACTITE9:String = "stalactyte9";
		public static const BACK_BACK:String = "backback";
		public static const BACKGROUND:String = "background";
		public static const STONE:String = "stone";
		public static const LITTLE_HILL:String = "littleHill";
		public static const PADDLE:String = "paddle";

		public function LevelDecorationManager() {
			
		}
		
		public static function getDecorationElement(element:String):MovieClip{
			switch(element){
			//LEVEL1
				case STALACTITE0:
					return new Stalactyte0View();
					break;
				case STALACTITE1:
					return new Stalactyte1View();
					break;
				case STALACTITE2:
					return new Stalactyte2View();
					break;
				case STALACTITE3:
					return new Stalactyte3View();
					break;
				case STALACTITE4:
					return new Stalactyte4View();
					break;
				case STALACTITE5:
					return new Stalactyte5View();
					break;
				case STALACTITE6:
					return new Stalactyte6View();
					break;
				case STALACTITE7:
					return new Stalactyte7View();
					break;
				case STALACTITE8:
					return new Stalactyte8View();
					break;
				case STALACTITE9:
					return new Stalactyte9View();
					break;
				case BACK_BACK:
					return new BackStageDecorationsBackground();
					break;
				case BACKGROUND:
					return new BackgroundView();
					break;
				case STONE:
					return new StoneView();
					break;
				case LITTLE_HILL:
					return new LittleHillView();
					break;
				case PADDLE:
					return new UsualPaddleView();
					break;
				default:
					return new MovieClip();
					break;
			}
		}
	}
}