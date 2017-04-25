var game = new Phaser.Game(500, 500, Phaser.CANVAS, null, {
  preload: preload, create: create, update:update, render: render});

var cars;

var map = [];



// Square Object
Square = function(x, y, sprite){

  Phaser.Sprite.call(this, game, x, y, sprite);
  this.anchor.setTo(0.5, 0.5);
  this.inputEnabled = true;
  //  Allow dragging - the 'true' parameter will make the sprite snap to the center
  this.input.enableDrag(true);
  game.physics.enable(this, Phaser.Physics.ARCADE);
  this.body.collideWorldBounds = true;
  this.body.bounce.set(1);
  // this.input.mouseUpCallback = this.handleMouseUp;
  game.add.existing(this);
}
Square.prototype = Object.create(Phaser.Sprite.prototype);
Square.prototype.constructor = Square;
Square.prototype.update = function(){
  this.x = 25*Math.round(this.x /25);
  this.y = 25*Math.round(this.y /25);
}

function preload() {
    game.scale.scaleMode = Phaser.ScaleManager.NO_SCALE;
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    game.stage.backgroundColor = '#555';
    game.load.image('Link', 'img/Link.png');
    game.load.image('background', 'img/background.jpg');
    game.load.image('square1', 'img/Square1.png');
    game.load.image('square2', 'img/Square2.png');
    game.load.image('square3', 'img/Square3.png');

    //Create map
    for(var i=0; i<100; i++) {
      map[i] = [];
      for(var j=0; j<100; j++) {
          map[i][j] = 0;
      }
    }

}

function create() {
  game.world.setBounds(0,0,500,500);
  game.physics.startSystem(Phaser.Physics.ARCADE);
  game.add.image(game.world.centerX, game.world.centerY, 'background').anchor.set(0.5);

  

  // square1 = game.add.sprite(game.world.randomX, game.world.randomY,  'square1');
  // //  Input Enable the sprites
  // square1.inputEnabled = true;
  // //  Allow dragging - the 'true' parameter will make the sprite snap to the center
  // square1.input.enableDrag(true);
  // game.physics.enable(square1, Phaser.Physics.ARCADE);
  // square1.body.collideWorldBounds = true;
  // square1.body.bounce.set(1);
  // square1.input.mouse.mouseUpCallback = square1SnapToPosition;

  square1 = new Square(game.world.randomX, game.world.randomY,  'square1');

  square2 = new Square(game.world.randomX, game.world.randomY,  'square2');
  
  square3 = new Square(game.world.randomX, game.world.randomY,  'square3');

  Link = game.add.sprite(game.world.randomX, game.world.randomY,  'Link');
  Link.scale.setTo(0.05, 0.05);
  //  Input Enable the sprites
  Link.inputEnabled = true;
  //  Allow dragging - the 'true' parameter will make the sprite snap to the center
  Link.input.enableDrag(true);
  game.physics.enable(Link, Phaser.Physics.ARCADE);
  Link.body.collideWorldBounds = true;
  Link.body.bounce.set(1);

}

function update() {
}

function render() {  
  // game.debug.body(car);
}