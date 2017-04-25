var game = new Phaser.Game(500, 500, Phaser.CANVAS, null, {
  preload: preload, create: create, update:update, render: render});

var map = [];

var easystar = new EasyStar.js();

var square1, square2, square3;
var startPoint, finishPoint;
var robot;

var collisionCheck = true;

function test(){
  console.log("Testing\n");
}

// Square Object
Square = function(x, y, sprite){

  Phaser.Sprite.call(this, game, x, y, sprite);
  this.anchor.setTo(0.5, 0.5);
  this.inputEnabled = true;
  //  Allow dragging - the 'true' parameter will make the sprite snap to the center
  this.input.enableDrag(true);
  game.physics.enable(this, Phaser.Physics.ARCADE);
  this.body.collideWorldBounds = true;
  this.body.bounce.set(1, 1);
  // this.input.mouseUpCallback = this.handleMouseUp;
  game.add.existing(this);
}
Square.prototype = Object.create(Phaser.Sprite.prototype);
Square.prototype.constructor = Square;
Square.prototype.update = function(){
  this.x = 25*Math.round(this.x /25);
  this.y = 25*Math.round(this.y /25);
}

Item = function(x, y, sprite){

  Phaser.Sprite.call(this, game, x, y, sprite);
  this.anchor.setTo(0.5, 0.5);
  this.inputEnabled = true;
  //  Allow dragging - the 'true' parameter will make the sprite snap to the center
  this.input.enableDrag(true);
  game.physics.enable(this, Phaser.Physics.ARCADE);
  this.body.collideWorldBounds = true;
  this.body.bounce.set(1, 1);
  // this.input.mouseUpCallback = this.handleMouseUp;
  game.add.existing(this);
  this.x = 25*Math.round(this.x /25) - 12.5;
  this.y = 25*Math.round(this.y /25) - 12.5;  
  this.savedX = this.x;
  this.savedY = this.y;
}
Item.prototype = Object.create(Phaser.Sprite.prototype);
Item.prototype.constructor = Item;
Item.prototype.savePosition = function(){
  console.log("saving");
  console.log(this.x);
  console.log(this.y);
}
Item.prototype.checkPosition = function(){
  console.log("checkPosition");
  // game.physics.arcade.overlap(this, square1, this.moveback, null, this);
  collisionCheck = true;
  this.savedX = this.x;
  this.savedY = this.y;
}
Item.prototype.moveback = function(){
  console.log("moveback");
  // this.input.enableDrag(false);
  console.log(this.savedX);
  console.log(this.savedY);
  console.log("moveback");


  this.x = this.savedX;
  this.y = this.savedY;
}
Item.prototype.update = function(){
  // this.x = 25*Math.round(this.x /25) - 12.5;
  // this.y = 25*Math.round(this.y /25) - 12.5;
}


function preload() {
    game.scale.scaleMode = Phaser.ScaleManager.NO_SCALE;
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    game.stage.backgroundColor = '#555';
    game.load.image('robot', 'img/Robot.png');
    game.load.image('start', 'img/Start.png');
    game.load.image('finish', 'img/Finish.png');
    game.load.image('path', 'img/Path.png');
    game.load.image('background', 'img/Background.png');
    game.load.image('square1', 'img/Square1.png');
    game.load.image('square2', 'img/Square2.png');
    game.load.image('square3', 'img/Square3.png');

    //Create map
    for(var i=0; i<20; i++) {
      map[i] = [];
      for(var j=0; j<20; j++) {
          map[i][j] = 0;
      }
    }

}

function create() {
  game.world.setBounds(0,0,500,500);
  game.physics.startSystem(Phaser.Physics.ARCADE);
  game.add.image(game.world.centerX, game.world.centerY, 'background').anchor.set(0.5);

  square1 = new Square(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'square1');
  

  square2 = new Square(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'square2');
  
  square3 = new Square(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'square3');

  // robot = new Item(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'robot');

  start = new Item(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'start');
  start.events.onDragStart.add(start.savePosition, this);
  start.events.onDragStop.add(start.checkPosition, this);

  finish = new Item(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'finish');
  
  

}

function update() {
  if (collisionCheck) {
    game.physics.arcade.overlap(start, square1, start.moveback);
  }
}

function render() {  
  // game.debug.body(car);
}