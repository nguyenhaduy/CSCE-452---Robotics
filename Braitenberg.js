var game = new Phaser.Game(800, 800, Phaser.CANVAS, null, {
  preload: preload, create: create, update: update});

var car, dist1, dist2, dist3, dist4, sensor1, sensor2, magMatrix, kMatrix, wMatrix, sum, sum2, sensorAngle, centerPoint, robot, vL, vR

function preload() {
    game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    game.stage.backgroundColor = '#555';
    game.load.image('car', 'img/robot.png');
    game.load.image('light', 'img/Light.png');
    game.load.image('sensor', 'img/sensor.png');
}

function create() {
	game.world.setBounds(0,0,800,800);
	game.physics.startSystem(Phaser.Physics.ARCADE);
	
	robot = game.add.group();
	
	robot.x = 300;
	robot.y = 300;
	
	robot.create(300,300, 'car');
	robot.create(325, 290, 'light');
	robot.create(425, 290, 'light');
	// robot.create(robot.children[0], 380, 'light');

	robot.scale.setTo(.25,.25);
	
	game.physics.arcade.enable(robot);
	robot.collideWorldBounds = true;
	
	
	// robot.create(robot.children[0].x + robot.children[0].width/4, robot.children[0].y, Phaser.Point());
	// robot.create(robot.children[0].x + 3*robot.children[0].width/4, robot.children[0].y, Phaser.Point());
	
	// robot.create(robot.children[0].x + robot.children[0].width/2, robot.children[0].y + robot.children[0].height/2, Phaser.Point());
	
	// robot.scale.setTo(.25,.25);
	
	// game.physics.arcade.enable(robot);
	// robot.collideWorldBounds = true;
	
	// light = game.add.sprite(100,100, 'light');
	// light.scale.setTo(.5,.5);
	// light2 = game.add.sprite(400,400, 'light');
	// light2.scale.setTo(.5,.5); 
	
	// sensorAngle = Math.atan2(robot.children[2].y - (robot.children[0].y + robot.children[0].y.height/2), robot.children[2].x - robot.children[0].y.x) * 180 / Math.PI;
}

function update() {	
		
	l = 48;
	vL = -400;
	vR = -10;
	
	R = (l/2) * ((vL + vR)/(vR - vL));
	w = (vR - vL) / l
	
	theta = robot.angle;
	
	// pivotPointX =  robot.centerX - R*Math.sin(theta);
	// pivotPointY =  robot.centerY + R*Math.cos(theta);
	
	robot.pivot.x = robot.centerX;
	robot.pivot.y = robot.centerY;
	
	robot.setAll('body.angularVelocity',w);
	
	console.log(robot.children[1].world)

	
	// robot.rotation += 0.02;
	
	// console.log(robot.children[1])
	
	// dist1 = robot.children[1].distance(light);
	// dist2 = robot.children[2].distance(light);
	// dist3 = robot.children[1].distance(light2);
	// dist4 = robot.children[2].distance(light2);
	// sum = 100/dist1 + 100/dist3;
	// sum2 = 100/dist2 + 100/dist4;
	
	// magMatrix = [sum, sum2];
	// kMatrix = [[1, 0], [0,1]];	
	// wMatrix = math.multiply(kMatrix, magMatrix);
	
	// w1 = wMatrix[0];
	// w2 = wMatrix[1];
	
	// v1x = w1*Math.sin(-sensorAngle);
	// v1y = w1*Math.cos(-sensorAngle);
	// v2x = w2*Math.sin(sensorAngle);
	// v2y = w2*Math.cos(sensorAngle);
	
	// vRx = v1x + v2x;
	// vRy = v1y + v2y;
	
	// rotationAngle = Math.atan2(vRx,vRy) * 180 / Math.PI;
	
	// vRx = vRx * 8;
	// vRy = vRy * 8;
	
	// robot.angle = rotationAngle;
	// car.body.velocity.x = vRx;
	// car.body.velocity.y = vRy;
	
	// rotateAbout(sensor1.x, sensor1.y, centerPoint.x, centerPoint.y, rotationAngle, 1);
	// rotateAbout(sensor2.x, sensor2.y, centerPoint.x, centerPoint.y, rotationAngle, 0);
	
	// console.log(sensor1.x);
}

// function braitenberg() {  

// }

// function rotateAbout(tempX, tempY, cx, cy, theta, whichSensor) {
	// rotatedX = tempX*Math.cos(theta) - tempY*Math.sin(theta);
	// rotatedY = tempX*Math.sin(theta) + tempY*Math.cos(theta);
	
	// if(whichSensor) {
		// sensor1.x = rotatedX;
		// sensor1.y = rotatedY;
	// }
		
	// else {
		// sensor2.x = rotatedX;
		// sensor2.y = rotatedY;
	// }
// }
