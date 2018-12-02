package minigames;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Incense extends MiniGame {

    var incense_green:FlxSprite;
    var incense_blue:FlxSprite;
    var incense_purple:FlxSprite;

    var choosenIncense:String;

    override public function create():Void
	{
		super.create();
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.paper__png);

        incense_green = new FlxSprite(200, 200);
        incense_blue = new FlxSprite(200, 300);
        incense_purple = new FlxSprite(200, 400);
        incense_green.loadGraphic(AssetPaths.incense_green__png);
        incense_blue.loadGraphic(AssetPaths.incense_blue__png);
        incense_purple.loadGraphic(AssetPaths.incense_purple__png);
        add(bg);
        add(incense_blue);
        add(incense_green);
        add(incense_purple);
	}
    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		var contactPoint = null;
        #if (desktop || web)
		if(FlxG.mouse.justPressed) {
			contactPoint = new FlxPoint(FlxG.mouse.getScreenPosition().x , FlxG.mouse.getScreenPosition().y );
		}
		#elseif mobile
		if(FlxG.touches.getFirst() != null && FlxG.touches.getFirst().justReleased) {
			contactPoint = new FlxPoint(FlxG.touches.getFirst().x, FlxG.touches.getFirst().y);
		}
		#end

        if(contactPoint != null) { 
            if(contactPoint.x > incense_green.x && contactPoint.x < (incense_green.x + incense_green.graphic.width)
            && contactPoint.y > incense_green.y && contactPoint.y < (incense_green.y + incense_green.graphic.height)) {
                clickIncenseGreen();
            }
            else if(contactPoint.x > incense_blue.x && contactPoint.x < (incense_blue.x + incense_blue.graphic.width)
            && contactPoint.y > incense_blue.y && contactPoint.y < (incense_blue.y + incense_blue.graphic.height)) {
                clickIncenseBlue();
            }
            else if(contactPoint.x > incense_purple.x && contactPoint.x < (incense_purple.x + incense_purple.graphic.width)
            && contactPoint.y > incense_purple.y && contactPoint.y < (incense_purple.y + incense_purple.graphic.height)) {
                clickIncensePurple();
            }
        }

	}

    public function clickIncenseGreen():Void {
        choosenIncense = Ritual.INCENSE_GREEN;
        close();

    }
    public function clickIncensePurple():Void {
        choosenIncense = Ritual.INCENSE_PURPLE;
        close();
    }
    public function clickIncenseBlue():Void {
        choosenIncense = Ritual.INCENSE_BLUE;
        close();
    }

    public function getChoosenIncense():String {
        return choosenIncense;
    }
}