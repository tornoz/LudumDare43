package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import minigames.MiniGame;
import flixel.text.FlxText;
class SpellbookSubState extends MiniGame {

    var game:Game;

    var title:FlxText;

    public function new(game:Game, incenseChoosen:Bool,burn:FlxSprite) {
        super(incenseChoosen, burn);
        this.game = game;
    }

     override public function create():Void
	{
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.grimoire__png);

        add(bg);
		super.create();
        addText(190,100, 0, "How to invoke Satan", 25);
        addText(190,150, 300, "A comprehensive guide to help you invite the lord of darkness to your house", 15);
        addText(170,210, 0, "By Juliet Smith", 15);

        addText(170,240, 350, "In order to invoke Satan, you must first invoke lesser demons. The order does not matter. The guidelines for every demon and Satan themself is described on the right page. Please follow the instructions very carefully or unwanted events might happen. Also remember that you must light the incense first and do the rest of the invocation before it consumes.", 15);


        addText(550,100, 0, "Azazel", 15);
        var azazel = game.getAzazel();
        addIncense(490, 115,azazel.getIncense());
        addAnimal(490, 120,azazel.getAnimal());

        addText(550,180, 0, "Abaddon", 15);
        var abaddon = game.getAbaddon();
        addIncense(490, 195,abaddon.getIncense());
        addAnimal(490, 200,abaddon.getAnimal());
        addPentagram(520, 200,abaddon.getPentagram());


        addText(550,270, 0, "Baphomet", 15);
        var baphomet = game.getBaphomet();
        addIncense(490, 285,baphomet.getIncense());
        addAnimal(490, 290,baphomet.getAnimal());
        addPentagram(520, 290,baphomet.getPentagram());

        addText(550,360, 0, "Satan", 15);
        var satan = game.getSatan();
        addIncense(490, 375,satan.getIncense());
        addAnimal(490, 380,satan.getAnimal());
        addPentagram(520, 380,satan.getPentagram());







	}

    private function addText(x:Int, y:Int, width: Int, text:String, size:Int) {
        var text = new FlxText(x,y, width, text, size);
        text.borderColor = FlxColor.BLACK;
        text.borderSize = 3;
        text.borderStyle = flixel.text.FlxTextBorderStyle.OUTLINE;
        add(text);
    }

    private function addIncense(x:Int, y:Int, incense:String) {
        var incenseSprite = new FlxSprite(x, y);
        switch(incense) {
            case Ritual.INCENSE_GREEN:
                incenseSprite.loadGraphic(AssetPaths.incense_green__png);
            case Ritual.INCENSE_PURPLE:
                incenseSprite.loadGraphic(AssetPaths.incense_purple__png);
            case Ritual.INCENSE_BLUE:
                incenseSprite.loadGraphic(AssetPaths.incense_blue__png);
        }
        incenseSprite.setGraphicSize(300,17);
        incenseSprite.x = x -200;
        incenseSprite.y = y -5;
        add(incenseSprite);
    }
    private function addAnimal(x:Int, y:Int, animal:String) {
        var animalSprite = new FlxSprite(x, y);
        switch(animal) {
            case Ritual.ANIMAL_CROW:
                animalSprite.loadGraphic(AssetPaths.crow_icon__png);
            case Ritual.ANIMAL_MOUSE:
                animalSprite.loadGraphic(AssetPaths.mouse_icon__png);
            case Ritual.ANIMAL_SHEEP:
                animalSprite.loadGraphic(AssetPaths.sheep_icon__png);
        }
        animalSprite.setGraphicSize(50,50);
        animalSprite.x = x-25;
        animalSprite.y = y-60;
        add(animalSprite);

    }
    private function addPentagram(x:Int, y:Int, pentagram:String) {
        var pentagramSprite = new FlxSprite(x, y);
        switch(pentagram) {
            case Ritual.STAR_1:
                pentagramSprite.loadGraphic(AssetPaths.star__png);
            case Ritual.STAR_2:
                pentagramSprite.loadGraphic(AssetPaths.star2__png);
            case Ritual.STAR_3:
                pentagramSprite.loadGraphic(AssetPaths.star3__png);
        }

        pentagramSprite.setGraphicSize(85,64);
        pentagramSprite.x = x-410;
        pentagramSprite.y = y-340;
        add(pentagramSprite);

    }

}