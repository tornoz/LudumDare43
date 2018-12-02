package minigames;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

class SacrificeChoice extends MiniGame {


    var choosenAnimal:String;

    var sheepIcon:FlxSprite;
    var crowIcon:FlxSprite;
    var mouseIcon:FlxSprite;

    override public function create():Void
	{
		super.create();
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.autel__png);

        sheepIcon = new FlxSprite(200, 300);
        crowIcon = new FlxSprite(400, 300);
        mouseIcon = new FlxSprite(600, 300);
        sheepIcon.loadGraphic(AssetPaths.sheep_icon__png);
        crowIcon.loadGraphic(AssetPaths.crow_icon__png);
        mouseIcon.loadGraphic(AssetPaths.mouse_icon__png);

        add(bg);
        add(crowIcon);
        add(sheepIcon);
        add(mouseIcon);
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
			if(contactPoint.x > sheepIcon.x && contactPoint.x < (sheepIcon.x + sheepIcon.graphic.width)
			&& contactPoint.y > sheepIcon.y && contactPoint.y < (sheepIcon.y + sheepIcon.graphic.height)) {
				clickSheep();
			}
			else if(contactPoint.x > crowIcon.x && contactPoint.x < (crowIcon.x + crowIcon.graphic.width)
			&& contactPoint.y > crowIcon.y && contactPoint.y < (crowIcon.y + crowIcon.graphic.height)) {
				clickCrow();
			}
            else if(contactPoint.x > mouseIcon.x && contactPoint.x < (mouseIcon.x + mouseIcon.graphic.width)
			&& contactPoint.y > mouseIcon.y && contactPoint.y < (mouseIcon.y + mouseIcon.graphic.height)) {
				clickMouse();
			}
			
		}

	}

    public function clickSheep():Void {
        choosenAnimal = Ritual.ANIMAL_SHEEP;
        close();

    }
    public function clickCrow():Void {
        choosenAnimal = Ritual.ANIMAL_CROW;
        close();
    }
    public function clickMouse():Void {
        choosenAnimal = Ritual.ANIMAL_MOUSE;
        close();
    }

    public function getChoosenAnimal():String {
        return choosenAnimal;
    }
}