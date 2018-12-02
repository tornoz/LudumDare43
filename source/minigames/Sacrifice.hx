package minigames;

import flixel.addons.display.FlxExtendedSprite;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Sacrifice extends MiniGame {


    var chosenAnimal:String;

    var start:FlxPoint;
    var end:FlxPoint;
    var canvas:FlxSprite;

    var angle:Float;
    var sliceTime:Float = 0;
    var sacrificeScore: Float;
    var text:FlxSprite;
    var struck = false;

    static var sliceDuration:Float = 1.0;


    public function new(uncenseChoosen:Bool,burn:FlxSprite) {
        super(incenseChoosen, burn);
    }

    override public function create():Void
	{
		super.create();
		
        var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.autel__png);

        var animal = new FlxSprite(0, 0);
        switch(chosenAnimal) {
			case Ritual.ANIMAL_MOUSE:
				animal.loadGraphic(AssetPaths.mouse__png);
                start = new FlxPoint(643,317);
                end = new FlxPoint(641,419);
                angle = -173.883;
			case Ritual.ANIMAL_SHEEP:
				animal.loadGraphic(AssetPaths.sheep__png);
                start = new FlxPoint(701,289);
                end = new FlxPoint(734,362);
                angle = 134.4;
			case Ritual.ANIMAL_CROW:
				animal.loadGraphic(AssetPaths.crow__png);
                start = new FlxPoint(535,261);
                end = new FlxPoint(588,342);
                angle = 143.878;
		}
        canvas = new FlxSprite();
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

        var truc = new FlxText(300, 610, 0, "Cut the head by swiping down on the neck!", 15);
        add(bg);
        add(animal);
        add(canvas);
        add(truc);
        text = new FlxSprite(262, 284);
        text.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
        add(text);
        FlxG.watch.addMouse();

	}

    
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        if(sliceTime <= 0) {
            for (s in FlxG.swipes) {
                FlxG.camera.shake(0.01, 0.2);
                var xStartDiff = s.startPosition.x - start.x; 
                var yStartDiff = s.startPosition.y - start.y; 
                var xEndDiff = s.endPosition.x - end.x; 
                var yEndDiff = s.endPosition.y - end.y;
                var phi = Math.abs(s.angle - angle) % 360;
                var angleDiff = phi > 180 ? 360 - phi : phi;
                FlxG.log.notice("angleDiff: " + angleDiff);
                sacrificeScore = Math.abs(xStartDiff + yStartDiff * 0.25 + xEndDiff + yEndDiff * 0.25 + angleDiff * 2);

                var lineStyle:LineStyle = { color: FlxColor.RED, thickness: 3 };
                var drawStyle:DrawStyle = { smoothing: true };
                canvas.fill(FlxColor.TRANSPARENT);
                canvas.alpha = 1.0;
                canvas.drawLine(s.startPosition.x , s.startPosition.y, s.endPosition.x, s.endPosition.y, lineStyle);
                sliceTime = sliceDuration;
                text.fill(FlxColor.TRANSPARENT);
                text.alpha = 1.0;
                if(sacrificeScore < 20) {
                    text.loadGraphic(AssetPaths.perfect__png);
                } else if (sacrificeScore < 90) {
                    text.loadGraphic(AssetPaths.nice__png);
                }else if (sacrificeScore < 150) {
                    text.loadGraphic(AssetPaths.ok__png);
                } else if(sacrificeScore >= 150) {
                    text.loadGraphic(AssetPaths.bad__png);
                }
                FlxG.log.notice("score: " + sacrificeScore);
                struck = true;
            }
        } else if (struck){
            sliceTime -= elapsed;
            canvas.alpha = sliceTime;
            text.alpha = sliceTime;
            if(sliceTime <= 0) {
                close();
            }
        }
        
    }

    public function setChosenAnimal(chosenAnimal: String):Void {
        this.chosenAnimal = chosenAnimal;
    }

    public function getSacrificeScore():Float {
        return sacrificeScore;
    }
}