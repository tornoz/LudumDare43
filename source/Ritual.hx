package;

import flixel.math.FlxRandom;


class Ritual {

    var animal:String;
    var incenseColor:String;
    var pentagram:String;

    public static inline var INCENSE_GREEN = "green";
    public static inline var INCENSE_BLUE = "blue";
    public static inline var INCENSE_PURPLE = "purple";


    public static inline var ANIMAL_SHEEP = "sheep";
    public static inline var ANIMAL_CROW = "crow";
    public static inline var ANIMAL_MOUSE = "mouse";


    public static inline var STAR_1 = "star1";
    public static inline var STAR_2 = "star2";
    public static inline var STAR_3 = "star3";

    var random:FlxRandom;

    public function new() {
        random = new FlxRandom();
    }

    public function pickIncense() {
        var pick_incense = [
            INCENSE_GREEN,
            INCENSE_BLUE,
            INCENSE_PURPLE
        ];
        incenseColor = pick_incense[random.int(0,2)];
    } 
    public function pickAnimal() {
        var pick_animal = [
            ANIMAL_SHEEP,
            ANIMAL_CROW,
            ANIMAL_MOUSE
        ];
        animal = pick_animal[random.int(0,2)];
    } 
    public function pickPentagram() {
        var pick_pentagram = [
            STAR_1,
            STAR_2,
            STAR_3
        ];
        pentagram = pick_pentagram[random.int(0,2)];
    } 

    public function getIncense():String {
        return incenseColor;
    }
    public function getAnimal():String {
        return animal;
    }
    public function getPentagram():String {
        return pentagram;
    }
}