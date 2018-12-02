package;


class Game {

    var azazel:Ritual;
    var abaddon:Ritual;
    var baphomet:Ritual;
    var satan:Ritual;

    public function new() {
        initDemons();
    }

    public function initDemons() {
        azazel = new Ritual();
        azazel.pickIncense();
        azazel.pickAnimal();


        abaddon = new Ritual();
        abaddon.pickIncense();
        abaddon.pickAnimal();
        abaddon.pickPentagram();


        baphomet = new Ritual();
        baphomet.pickIncense();
        baphomet.pickAnimal();
        baphomet.pickPentagram();


        satan = new Ritual();
        satan.pickIncense();
        satan.pickAnimal();
        satan.pickPentagram();
    }

    public function getAzazel():Ritual {
        return azazel;
    }
    public function getAbaddon():Ritual {
        return abaddon;
    }
    public function getBaphomet():Ritual {
        return baphomet;
    }
    public function getSatan():Ritual {
        return satan;
    }
}