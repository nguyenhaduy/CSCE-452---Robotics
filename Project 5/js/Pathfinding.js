var game = new Phaser.Game(500, 500, Phaser.CANVAS, null, {
  preload: preload, create: create, update:update, render: render});

var map = [];

// var easystar = new EasyStar.js();

var square1, square2, square3;
var startPoint, finishPoint;
var robot;

var positionCheckS = false;
var positionCheckF = false;
var positionCheckSq1 = false;
var positionCheckSq2 = false;
var positionCheckSq3 = false;

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
  this.savedX = this.x;
  this.savedY = this.y;
}
Square.prototype = Object.create(Phaser.Sprite.prototype);
Square.prototype.constructor = Square;
Square.prototype.update = function(){
  this.x = 25*Math.round(this.x /25);
  this.y = 25*Math.round(this.y /25);
}

Square.prototype.checkPositionSq1 = function(){
  positionCheckSq1 = true;
}

Square.prototype.checkPositionSq2 = function(){
  positionCheckSq2 = true;
}

Square.prototype.checkPositionSq3 = function(){
  positionCheckSq3 = true;
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

Item.prototype.checkPositionS = function(){
  positionCheckS = true;
}

Item.prototype.checkPositionF = function(){
  positionCheckF = true;
}

Item.prototype.update = function(){
  this.x = 25*Math.round(this.x /25) - 12.5;
  this.y = 25*Math.round(this.y /25) - 12.5;
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

  square1 = new Square(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25), 'square1');
  square1.events.onDragStop.add(square1.checkPositionSq1, this);  

  square2 = new Square(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25), 'square2');
  square2.events.onDragStop.add(square2.checkPositionSq2, this);

  square3 = new Square(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25), 'square3');
  square3.events.onDragStop.add(square3.checkPositionSq3, this);
  
  squares = game.add.group();
  squares.add(square1);
  squares.add(square2);
  squares.add(square3);

  // robot = new Item(25*Math.round(game.world.randomX/25), 25*Math.round(game.world.randomY/25),  'robot');

  start = new Item(50, 50, 'start');
  start.events.onDragStop.add(start.checkPositionS, this);

  finish = new Item(475, 475, 'finish');
  finish.events.onDragStop.add(finish.checkPositionF, this);
  
  items = game.add.group();
  items.add(start);
  items.add(finish);
  
  

}

function update() {
  if (positionCheckS) {
    if(game.physics.arcade.overlap(start, squares)) {
		start.x = start.savedX;
		start.y = start.savedY;
	}
	
	else {
		start.savedX = start.x;
		start.savedY = start.y;
	}
		
	positionCheckS = false;
  }
  
  else if (positionCheckF) {
    if(game.physics.arcade.overlap(finish, squares)) {
		finish.x = finish.savedX;
		finish.y = finish.savedY;
	}
	
	else {
		finish.savedX = finish.x;
		finish.savedY = finish.y;
	}
		
	positionCheckF = false;
  }
  
  else if (positionCheckSq1) {
		if(game.physics.arcade.overlap(square1, items)) {
			square1.x = square1.savedX;
			square1.y = square1.savedY;
		}
		
		else {
			square1.savedX = square1.x;
			square1.savedY = square1.y;
		}
			
		positionCheckSq1 = false;
	}
	
	else if (positionCheckSq2) {
		if(game.physics.arcade.overlap(square2, items)) {
			square2.x = square2.savedX;
			square2.y = square2.savedY;
		}
		
		else {
			square2.savedX = square2.x;
			square2.savedY = square2.y;
		}
			
		positionCheckSq2 = false;
	}
	
	else if (positionCheckSq3) {
		if(game.physics.arcade.overlap(square3, items)) {
			square3.x = square3.savedX;
			square3.y = square3.savedY;
		}
		
		else {
			square3.savedX = square3.x;
			square3.savedY = square3.y;
		}
			
		positionCheckSq3 = false;
	}
}

function render() {  
  // game.debug.body(car);
}
