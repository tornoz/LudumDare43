package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxSpriteButton;
import flixel.FlxG;
class WinState extends FlxState
{

	var score:Int;
	var dialogSubState:DialogSubState;
	public function new(score:Int) {
		super();
		this.score = score;
	}

	override public function create():Void
	{
		var bg = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/win.png");
		add(bg);

		addDialog(["You Win", "Score " + score + ". Click to restart."], FlxG.resetGame);
		super.create();
	}

	

    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}


	public function addDialog(text:Array<String>, callback:Void -> Void) {
		dialogSubState = new DialogSubState(text);
		dialogSubState.closeCallback = callback;
		openSubState(this.dialogSubState);
	}

}
