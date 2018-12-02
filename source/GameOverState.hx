package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxSpriteButton;
import flixel.FlxG;
class GameOverState extends FlxState
{
	override public function create():Void
	{
		
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/gameover.png");
		add(bg);
		super.create();
	}

	

    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		var contactPoint = null;
        #if (desktop || web)
		if(FlxG.mouse.justPressed) {
			FlxG.resetGame();
		}
		#elseif mobile
		if(FlxG.touches.getFirst() != null && FlxG.touches.getFirst().justReleased) {
			FlxG.resetGame();
		}
		#end
	}

}
