class Jogo {
  AgenteRL agente;

  float velocidadepaddleIA = 5;
  PVector velocidadeBall = new PVector(-1, 1);

  int pontuacao;
  int quadroAtual;
  int quadroUltimaAcao;
  String estadoUltimaAcao;
  int ultimaAcao;

  Jogo() {
    paddleIA = new Platform(20, height/2, ALTURA_PLATFORM, LARGURA_PLATFORM, VELOCIDADE_PLATFORM);
    ball = new Ball(width/2, height/2, RAIO_BALL, speed);
    agente = new AgenteRL(0.1, 0.99, 1.0, 0.01, 0.001);
    reiniciar();
  }

  void reiniciar() {
    paddleIA = new Platform(20, height/2, ALTURA_PLATFORM, LARGURA_PLATFORM, VELOCIDADE_PLATFORM);
    ball = new Ball(width/2, height/2, 10, speed);
    pontuacao = 0;
    fimDeJogo = false;
    quadroAtual = 0;
    quadroUltimaAcao = 0;
    estadoUltimaAcao = obterEstado();
    ultimaAcao = round(random(2));
  }

  String obterEstado() {
    // estado ruim
    int ballX =  round(map(ball.pos.x, 0, width, 0, 10));
    int aberturaErro = round(map(ball.pos.y - paddleIA.pos.y, 0, height, 0, 20));
    return  ballX + "," + aberturaErro;
    // estado bom
    // int aberturaErro = round(map(ball.pos.y - paddleIA.pos.y, 0, height, 0, 50));
    // return ""+aberturaErro;
  }

  void atualizar() {
    quadroAtual++;

    // Ação do RL
    if (quadroAtual - quadroUltimaAcao >= 0) {
  
      float recompensa = 0;
      if (fimDeJogo){
        recompensa = -100;
      }else if (acertou){
        recompensa = 50;
      }else{
        recompensa = min(ball.pos.x, paddleIA.pos.x) / max(ball.pos.x, paddleIA.pos.x);
      }
      
      String estadoAtual = obterEstado();
      agente.atualizarValorQ(estadoUltimaAcao, ultimaAcao, recompensa, estadoAtual);

      ultimaAcao = agente.escolherAcao(estadoAtual);

      if (ultimaAcao == 1) paddleIA.vel = - VELOCIDADE_PLATFORM; // Up
      else if (ultimaAcao == 2) paddleIA.vel = VELOCIDADE_PLATFORM; // Down
      else paddleIA.vel = 0;

      estadoUltimaAcao = estadoAtual;
      quadroUltimaAcao = quadroAtual;
    }
    
    fimDeJogo = false;
    acertou = false;

    paddleIA.update();
    ball.update(); 
  }

  void desenhar() {
    //background(bgColor);
    surface.setTitle(estadoUltimaAcao);

    ball.update();
    paddleIA.update();
    ball.show();
    paddleIA.show();

    // Exibe pontuação
    fill(255);
    textSize(32);
    text("Pontuação: " + pontuacao, width - 220, 40);
    text("Average: " + nf(float(total)/float(pontuacoes.size()),1,2),  width - 220, 70);

    if (fimDeJogo) {
      text("Fim de Jogo", width/2 - 70, height/2);
    }
  }
}
