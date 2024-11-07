class Ball {
  PVector pos, vel;
  float size;

  Ball(float x, float y, float size, float speed) {
    pos = new PVector(x, y);
    vel = new PVector(-1, -1);
    vel.mult(speed);
    this.size = size;
  }

  void update() {
    
    pos.add(vel);
    
    // Se atingir parede
    if (pos.x - (size/2) <= 0){ // Esquerda: morreu
      fimDeJogo = true;
      pos.x = size/2; // Não ultrapassa
      vel.x *= -1; // Inverte direção
    }else if(pos.x + (size/2) >= width){
      pos.x = width - (size/2);
      vel.x *= -1;
    }
     
    // Se atingir teto/chão
    if (pos.y - (size/2) <= 0){
      pos.y = size/2; // Não ultrapassa
      vel.y *= -1; // Inverte direção
    }else if(pos.y + (size/2) >= height){
      pos.y = height - (size/2);
      vel.y *= -1;
    }

    if ( pos.y + (size/2) >= platform.pos.y - (platform.altura/2) && pos.y - (size/2) <= platform.pos.y + (platform.altura/2)) { // Verifica colisão do eixo Y da ball com platform
      if (pos.x - (size/2) <= platform.pos.x + (platform.largura/2) && pos.x + (size/2) >= platform.pos.x - (platform.largura/2)) {
        vel.x *= -1;
        
        float hitPos = (ball.pos.y - platform.pos.y) / platform.altura - 0.5; // Valor entre -0.5 e 0.5
        vel.y += hitPos * 1;
        
        jogo.pontuacao++;
      }
    }
    
    this.show();
  }

  void show() {
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
