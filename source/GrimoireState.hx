package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxSpriteButton;
class GrimoireState extends FlxState
{
	override public function create():Void
	{
		
		var grimoire = new FlxSprite(0,0);
		grimoire.loadGraphic("assets/images/grimoire.png");
		add(grimoire);
		var text = new FlxText(0, 0, 300, "coucou", 14, false);
		var spriteButton = new FlxSpriteButton(100,100, text);
		add(spriteButton);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
