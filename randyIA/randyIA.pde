Platform platform;
Ball ball;

final int LARGURA_PLATFORM = 10;
final int ALTURA_PLATFORM = 70;
final float VELOCIDADE_PLATFORM = 1.5;

final float RAIO_BALL = 20;

float speed = 5;
boolean fimDeJogo;

Jogo jogo;
int pontuacaoMax = 0;

ArrayList<Integer> pontuacoes;

boolean isGraph;
float graphOffset = 0;
float graphOffsetScale = 10;
float graphScale = 10;

color bgColor = #16212E;
color graphColor = #447BC1;

void showGraph() {
  //float l = width/(float)pontuacoes.size();
  graphScale = width/(float)pontuacoes.size();
  stroke(graphColor);
  strokeWeight(1);
  fill(#447BC1);
  //beginShape();
  //vertex(0, height);
  for (int i = 0; i < pontuacoes.size()-1; ++i) {
    line(graphScale*i-graphOffset, height/2.0-pontuacoes.get(i)*10, graphScale*(i+1)-graphOffset, height/2.0-pontuacoes.get(i+1)*10);
  }
  //ellipse(width-l, height/2.0-pontuacoes.get(pontuacoes.size()-1)*10, 5, 5);
  int mx = round(mouseX/graphScale);
  if (mouseX>=width/100.0 && mouseX<width-width/100.0) {
    fill(255);
    noStroke();
    ellipse(graphScale*mx, height/2.0-pontuacoes.get(mx+round(graphOffset/graphScale))*10, 5, 5);
    textSize(10);
    text(pontuacoes.get(mx+round(graphOffset/graphScale)), graphScale*mx, height/2.0-pontuacoes.get(mx+round(graphOffset/graphScale))*10+10);
    //vertex(width, height/2.0+pontuacoes.get(pontuacoes.size()-1)*10);
    //vertex(width, height);
    //endShape();
  }
}

void keyReleased() {
  switch(key) {
  case 'b':
    ball.vel = new PVector(constrain(random(-1, 1)*10, -1, 1), constrain(random(-1, 1)*10, -1, 1));
    break;
  case 'g':
    if (isGraph) isGraph = false;
    else isGraph = true;
    break;
  case 'r':
    setup();
    break;
  }
}

void keyPressed() {
  switch(keyCode) {
  case RIGHT:
    if (isGraph) graphOffset+=graphOffsetScale;
    break;
  case LEFT:
    if (isGraph) graphOffset-=graphOffsetScale;
    break;
  }
  
  switch(key) {
  case '-':
    //if (isGraph) graphScale = constrain(graphScale-graphScale/10.0, 0.001, width);
    break;
  case '=':
    //if (isGraph) graphScale = constrain(graphScale+graphScale/10.0, 0.001, width);
    break;
  }
}

void setup() {
  size(1000, 500);
  frameRate(120);
  jogo = new Jogo();
  pontuacoes = new ArrayList<Integer>();
  for (int i = 0; i < 1000000; i++) {
    jogo.atualizar();
    if (fimDeJogo) {
      pontuacoes.add(jogo.pontuacao);
      pontuacaoMax = max(pontuacaoMax, jogo.pontuacao);
      jogo.reiniciar();
    }
  }
  background(bgColor);
  println(pontuacaoMax);
}

void draw() {
  background(bgColor);

  jogo.atualizar();
  jogo.desenhar();
  if (isGraph) showGraph();


  if (fimDeJogo) {
    pontuacoes.add(jogo.pontuacao);
    pontuacaoMax = max(pontuacaoMax, jogo.pontuacao);
    println(jogo.pontuacao);
    jogo.reiniciar();
    //setup();
  }
}
