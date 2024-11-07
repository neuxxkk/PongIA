class Jogo {
  AgenteRL agente;

  float velocidadePlatform = 5;
  PVector velocidadeBall = new PVector(-1, 1);

  int pontuacao;
  int quadroAtual;
  int quadroUltimaAcao;
  String estadoUltimaAcao;
  int ultimaAcao;

  Jogo() {
    platform = new Platform(20, height/2, ALTURA_PLATFORM, LARGURA_PLATFORM, VELOCIDADE_PLATFORM);
    ball = new Ball(width/2, height/2, RAIO_BALL, speed);
    agente = new AgenteRL(0.1, 0.99, 1.0, 0.01, 0.001);
    reiniciar();
  }

  void reiniciar() {
    platform = new Platform(20, height/2, ALTURA_PLATFORM, LARGURA_PLATFORM, VELOCIDADE_PLATFORM);
    ball = new Ball(width/2, height/2, 10, speed);
    pontuacao = 0;
    fimDeJogo = false;
    quadroAtual = 0;
    quadroUltimaAcao = 0;
    estadoUltimaAcao = obterEstado();
    ultimaAcao = round(random(2));
  }

  String obterEstado() {
    int ballX =  round(map(ball.pos.x, 0, width, 0, 10));
    int aberturaErro = round(map(ball.pos.y - platform.pos.y, 0, height, 0, 20));
    return  ballX + "," + aberturaErro;
  }

  void atualizar() {
    quadroAtual++;

    // Ação do RL
    if (quadroAtual - quadroUltimaAcao >= 5) {
  
      float recompensa = fimDeJogo ? -100 : min(ball.pos.y, platform.pos.y) / max(ball.pos.y, platform.pos.y);
      
      String estadoAtual = obterEstado();
      agente.atualizarValorQ(estadoUltimaAcao, ultimaAcao, recompensa, estadoAtual);

      ultimaAcao = agente.escolherAcao(estadoAtual);

      if (ultimaAcao == 1) platform.vel = - VELOCIDADE_PLATFORM; // Up
      else if (ultimaAcao == 2) platform.vel = VELOCIDADE_PLATFORM; // Down


      estadoUltimaAcao = estadoAtual;
      quadroUltimaAcao = quadroAtual;
    }
    
    fimDeJogo = false;

    platform.update();
    ball.update(); 
  }

  void desenhar() {
    //background(bgColor);
    surface.setTitle(estadoUltimaAcao);

    ball.update();
    platform.update();

    // Exibe pontuação
    fill(255);
    textSize(32);
    text("Pontuação: " + pontuacao, 10, 40);

    if (fimDeJogo) {
      text("Fim de Jogo", width/2 - 70, height/2);
    }
  }
}
