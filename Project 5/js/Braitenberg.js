var game = new Phaser.Game(800, 800, Phaser.CANVAS, null, {
  preload: preload, create: create});

// , update: update, render: render

var car;
var cars;

var Lights;
var cars;

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


// Wheel Object
Wheel = function(X, Y, scale){
  this.x = X;
  this.y = Y;
}
Wheel.prototype.constructor = Sensor;
Wheel.prototype.rotateAbout = function(tempX, tempY, cx, cy, theta){

  //apply rotation
  rotatedX = tempX*Math.cos(theta) - tempY*Math.sin(theta);
  rotatedY = tempX*Math.sin(theta) + tempY*Math.cos(theta);
  // translate back
  this.x = rotatedX + cx;
  this.y = rotatedY + cy;
}


// Car Object
Car = function (game, x, y, scale, K11, K12, K21, K22, rotation, carType) {

    
    Phaser.Sprite.call(this, game, x, y, 'car');
    // console.log(this.x);
    // console.log(this.y);

    this.type = carType;
    this.k11 = K11;
    this.k12 = K12;
    this.k21 = K21;
    this.k22 = K22;

    this.rightSensor = new Sensor(x+64*scale, y+128*scale, scale);
    this.leftSensor = new Sensor(x-64*scale, y+128*scale, scale);

    this.rightWheel = new Wheel(x+32*scale, y, scale);
    this.leftWheel = new Wheel(x-32*scale, y, scale);

    this.rightSpeed = 0;
    this.leftSpeed = 0;

    this.theta = 0;

    this.anchor.setTo(0.5, 0.5);
    this.rotation = rotation;
    this.size = 256*scale;
    this.carWidth = 32*scale;
    this.scale.setTo(scale, scale)
    this.ScaleNumber = scale;

    game.physics.enable(this, Phaser.Physics.ARCADE);
    // this.body.drag.set(0.2);
    this.body.maxVelocity.setTo(200,200);
   //  this.body.velocity.set(150, 100);
    this.body.collideWorldBounds = true;
    this.body.bounce.set(1);

    game.add.existing(this);
};
Car.prototype = Object.create(Phaser.Sprite.prototype);
Car.prototype.constructor = Car;
Car.prototype.update = function() {
  // this.rotation = Math.atan2(this.body.velocity.x, -this.body.velocity.y);   
  this.body.width = this.size;  
  this.body.height = this.size;
  this.setWheelSpeed();
  // console.log('rightSpeed: ');
  // console.log(this.rightSpeed);
 //    console.log('leftSpeed :');
 //    console.log(this.leftSpeed);


  dt = 1/60;
  da = (this.rightSpeed - this.leftSpeed)/(this.carWidth);

  s = (this.rightSpeed + this.leftSpeed)/2;
  this.rotation = (this.rotation + da);
  // console.log(this.rotation);
  // this.theta = (this.rightSpeed - this.leftSpeed)/this.carWidth + this.theta;
  this.x = this.x + s*Math.cos((Math.PI/2 + this.rotation));
  this.y = this.y + s*Math.sin((Math.PI/2 + this.rotation));
  // this.rotation = this.theta;
  
  this.body.width = this.size;  
  this.body.height = this.size;

  // Calculate position of left sensor
  tempX = -64*this.ScaleNumber;
  tempY = 128*this.ScaleNumber;
  this.leftSensor.rotateAbout(tempX, tempY, this.x, this.y, this.rotation);

  // Calculate position of right sensor
  tempX = 64*this.ScaleNumber;
  tempY = 128*this.ScaleNumber;
  this.rightSensor.rotateAbout(tempX, tempY, this.x, this.y, this.rotation);

  // Calculate position of left wheel
  tempX = -32*this.ScaleNumber;
  tempY = 64*this.ScaleNumber;
  this.leftWheel.rotateAbout(tempX, tempY, this.x, this.y, this.rotation);

  // Calculate position of right sensor
  tempX = 32*this.ScaleNumber;
  tempY = 64*this.ScaleNumber;
  this.rightWheel.rotateAbout(tempX, tempY, this.x, this.y, this.rotation);

  
};
Car.prototype.setWheelSpeed = function() {
  len = Lights.children.length;
  if (len != 0){
    s1 = 0.0;
    s2 = 0.0;
            
    for (var i = 0; i < len; i++) { 

      // if(Light.children[i].length)
      s1 += Lights.children[i].intensityToLightSource(this.leftSensor);
      s2 += Lights.children[i].intensityToLightSource(this.rightSensor);
    }
    s1 = s1/len;
    s2 = s2/len;
    // console.log(s1);
    // console.log(s2);

    if (this.type == 2){
      this.leftSpeed = this.k11*s1 + this.k12*s2;
      this.rightSpeed = this.k21*s1 + this.k22*s2;
    } else if (this.type == 3) {
      this.leftSpeed = this.k11*(1-s1) + this.k12*(1-s2);
      this.rightSpeed = this.k21*(1-s1) + this.k22*(1-s2);
    }
   
    // console.log(this.rightSpeed);
    // console.log(this.leftSpeed);
  }
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
  // console.log(distance);
  return (this.intensity/Math.abs(distance));
};



function preload() {
    game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    game.stage.backgroundColor = '#555';
    game.load.image('car', 'img/Audi.png');
    game.load.image('light', 'img/Light.png');
    game.load.image('sensor', 'img/Sensor.png');
    game.load.image('background', 'img/background.jpg');

}

function create() {
  game.world.setBounds(0,0,800,800);
  game.physics.startSystem(Phaser.Physics.ARCADE);
  game.add.image(game.world.centerX, game.world.centerY, 'background').anchor.set(0.5);

  // car = game.add.sprite(game.world.randomX, game.world.randomY,  'car');
  //  // Pick a random number between -2 and 6
  //  var rand = game.rnd.realInRange(-2, 6);
  //  // Set the scale of the sprite to the ramdom value
  //  car.scale.setTo(0.25, 0.25);
  //  car.anchor.setTo(0.5, 0.5);

  //  game.physics.enable(car, Phaser.Physics.ARCADE);
  //  car.body.drag.set(0.2);
  //  car.body.maxVelocity.setTo(200,200);
  //   car.body.velocity.set(150, 100);
  //   car.body.collideWorldBounds = true;
  //   car.body.bounce.set(1);

    sensor1 = game.add.sprite(-200, -200,  'sensor');

  Lights = game.add.group();
  Cars = game.add.group();

    // new Car(game, game.world.randomX, game.world.randomY, 0.25, 0, 5, 5, 0, 0);

    // for(r=0; r<1; r++) {
    //     newLight = new Light(game, 400, 400, 1);
    //     Lights.add(newLight);
    // }
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