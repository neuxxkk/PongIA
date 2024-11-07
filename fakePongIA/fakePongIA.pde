Platform platform;
Ball ball;

int pontuacao;

final int LARGURA_PLATFORM = 10;
final int ALTURA_PLATFORM = 70;
final float VELOCIDADE_PLATFORM = 1.5;

final float RAIO_BALL = 20;

void setup(){
  size(800,600);
  platform =  new Platform(20, height/2, ALTURA_PLATFORM, LARGURA_PLATFORM, VELOCIDADE_PLATFORM);
  ball = new Ball(width/2, height/2, RAIO_BALL, 2);
  pontuacao = 0;
}


void draw(){
  
  platform.update();
  ball.update();
  fill(255);
  textSize(32);
  text("Pontuação: " + pontuacao, 10, 40);
  background(255,255,255,25);
}

void keyPressed(){
  platform.auto = false;
  if (keyCode == UP) platform.vel = -7;
  if (keyCode == DOWN) platform.vel = 7;
  if (key == 'q'){
    platform.vel = 1.5;
    platform.auto = true;
  }
}

void keyReleased(){
  if (!platform.auto) platform.vel = 0;
}
