var game = new Phaser.Game(800, 800, Phaser.CANVAS, null, {
  preload: preload, create: create});

// , update: update, render: render

var car;
var cars;
var Lights;


// Sensor Object
Sensor = function(x, y, scale){

	Phaser.Sprite.call(this, game, x, y, 'sensor');
	this.anchor.setTo(0.5, 0.5);
	this.ScaleNumber = scale;
    this.scale.setTo(scale, scale)
	game.add.existing(this);
}
Sensor.prototype = Object.create(Phaser.Sprite.prototype);
Sensor.prototype.constructor = Sensor;
Sensor.prototype.rotateAbout = function(tempX, tempY, cx, cy, theta){

	//apply rotation
	rotatedX = tempX*Math.cos(theta) - tempY*Math.sin(theta);
	rotatedY = tempX*Math.sin(theta) + tempY*Math.cos(theta);
	// translate back
	this.x = rotatedX + cx;
	this.y = rotatedY + cy;
}


// Car Object
Car = function (game, x, y, scale, K11, K12, K21, K22, rotation) {

    Phaser.Sprite.call(this, game, x, y, 'car');

    this.k11 = K11;
    this.k12 = K12;
    this.k21 = K21;
    this.k22 = K22;

    this.rightSensor = new Sensor(x+64*scale, y-128*scale, scale);
    this.leftSensor = new Sensor(x-64*scale, y-128*scale, scale);

    this.rightSpeed = 0;
    this.leftSpeed = 0;

    this.anchor.setTo(0.5, 0.5);
    this.rotation = rotation;
    this.size = 256*scale;
    this.scale.setTo(scale, scale)
    this.ScaleNumber = scale;

    game.physics.enable(this, Phaser.Physics.ARCADE);
  	this.body.drag.set(0.2);
  	this.body.maxVelocity.setTo(200,200);
    this.body.velocity.set(150, 100);
    this.body.collideWorldBounds = true;
    this.body.bounce.set(1);

    game.add.existing(this);
};
Car.prototype = Object.create(Phaser.Sprite.prototype);
Car.prototype.constructor = Car;
Car.prototype.update = function() {
	this.rotation = Math.atan2(this.body.velocity.x, -this.body.velocity.y); 	
	this.body.width = this.size;  
	this.body.height = this.size;

	// Calculate position of left sensor
	tempX = -64*this.ScaleNumber;
	tempY = -128*this.ScaleNumber;
	this.leftSensor.rotateAbout(tempX, tempY, this.x, this.y, this.rotation);

	// Calculate position of right sensor
	tempX = 64*this.ScaleNumber;
	tempY = -128*this.ScaleNumber;
	this.rightSensor.rotateAbout(tempX, tempY, this.x, this.y, this.rotation);

	//
	// Lights.children[i].destroy();
};
Car.prototype.setWheelSpeed = function() {
    s1 = 0.0;
    s2 = 0.0;
    
    for (var i = 0; i < Lights.children.length; i++) { 
    	s1 += Lights.children[i].intensityToLightSource(leftSensor);
        s2 += Lights.children[i].intensityToLightSource(rightSensor);
	}

    this.rightSpeed = this.k11*s1 + this.k12*s2;
    this.leftSpeed = this.k21*s1 + this.k22*s2;
    }


//Light Object
Light = function (game, x, y, scale) {
    Phaser.Sprite.call(this, game, x, y, 'light');
    this.anchor.setTo(0.5, 0.5);
    this.scale.setTo(scale, scale)
    this.intensity = 100;
    game.add.existing(this);
};
Light.prototype = Object.create(Phaser.Sprite.prototype);
Light.prototype.constructor = Light;
Light.prototype.intensityToLightSource = function(sensor) {
	distance = Phaser.Math.distance(this.x, this.y, sensor.x, sensor.y);
	return (this.intensity/distance);
};



function preload() {
    game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    game.stage.backgroundColor = '#555';
    game.load.image('car', 'img/Audi.png');
    game.load.image('light', 'img/Light.png');
    game.load.image('sensor', 'img/Sensor.png');
}

function create() {
	game.world.setBounds(0,0,800,800);
	game.physics.startSystem(Phaser.Physics.ARCADE);

 	// car = game.add.sprite(game.world.randomX, game.world.randomY,  'car');
  // 	// Pick a random number between -2 and 6
  // 	var rand = game.rnd.realInRange(-2, 6);
  // 	// Set the scale of the sprite to the ramdom value
  // 	car.scale.setTo(0.25, 0.25);
  // 	car.anchor.setTo(0.5, 0.5);

  // 	game.physics.enable(car, Phaser.Physics.ARCADE);
  // 	car.body.drag.set(0.2);
  // 	car.body.maxVelocity.setTo(200,200);
  //   car.body.velocity.set(150, 100);
  //   car.body.collideWorldBounds = true;
  //   car.body.bounce.set(1);

    sensor1 = game.add.sprite(-200, -200,  'sensor');

  	new Car(game, game.world.randomX, game.world.randomX, 0.25, 0, 0, 0, 0, 0);

  	Lights = game.add.group();
  	for(r=0; r<10; r++) {
        newLight = new Light(game, game.world.randomX, game.world.randomX, 1);
        Lights.add(newLight);
    }
}

function update() {
	// car.rotation = Math.atan2(car.body.velocity.x, -car.body.velocity.y);  
	// car.body.width = 64;  
	// car.body.height =64;

}

function render() {  
	// game.debug.body(car);
}

function newCar(){

}

function newLight(){

}