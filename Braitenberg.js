var game = new Phaser.Game(800, 800, Phaser.CANVAS, null, {
  preload: preload, create: create, update: update});

var car, dist1, dist2, dist3, dist4
var sensor1
var sensor2
var w1
var w2
var w3

function preload() {
    game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    game.stage.backgroundColor = '#555';
    game.load.image('car', 'img/Audi.png');
    game.load.image('light', 'img/Light.png');
    game.load.image('sensor', 'img/sensor.png');
}

function create() {
	game.world.setBounds(0,0,800,800);
	game.physics.startSystem(Phaser.Physics.ARCADE);
	
	car = game.add.sprite(300, 300, 'car');
	car.scale.setTo(.25, .25);
	
	game.physics.arcade.enable(car);
	car.body.collideWorldBounds = true;
	
	s1 = new Phaser.Point(car.x + car.width/4, car.y);
	s2 = new Phaser.Point(car.x + 3*car.width/4, car.y);
	
	light = game.add.sprite(100,100, 'light');
	light.scale.setTo(.5,.5);
	light2 = game.add.sprite(400,400, 'light');
	light2.scale.setTo(.5,.5); 
	
	//car.body.velocity.x = 20;
	//car.body.velocity.y = -50;
	s1.setTo(car.x + car.width/4, car.y);
	s2.setTo(car.x + 3*car.width/4, car.y);
	dist1 = s1.distance(light);
	dist2 = s2.distance(light);
	dist3 = s1.distance(light2);
	dist4 = s2.distance(light2);
	var sum = 100/dist1 + 100/dist3;
	var sum2 = 100/dist2 + 100/dist4;
	
	var magMatrix = [sum, sum2];
	var kMatrix = [[1, 0], [0,1]];	
	
	var angleDeg = Math.atan2(s1.y - (car.y + car.height/2), s1.x - car.x) * 180 / Math.PI; //angle between left sensor and middle of car
	var angleDeg = Math.atan2(s2.y - (car.y + car.height/2), s2.x - car.x) * 180 / Math.PI; //angle between right sensor and middle of car
	
	console.log("matrix = " + 	math.multiply(kMatrix, magMatrix));
	console.log("dist1 = " + sum);
	console.log("dist2 = " + sum2);
	console.log("dist3 = " + dist3);
	console.log("dist4 = " + dist4);
}

function update() {

}

function braitenberg() {  

}
