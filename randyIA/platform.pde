  class Platform {
    PVector pos;
    float vel;
    float altura, largura;
    boolean up, down, auto;
    
    
    Platform(float x, float y, float altura, float largura, float vel) {
      auto = true;
      pos = new PVector(x, y);
      this.altura = altura;
      this.largura = largura;
      this.vel = vel;
    }
    
    void update(){    
      if (auto){
        if (pos.y - (altura/2) <= 0){ // bateu teto
          pos.y = altura/2;
          vel *= -1;
        }else if (pos.y + (altura/2) >= height){
          pos.y = height - (altura/2);
          vel *= -1;
        }
      }else if (pos.y+vel - (altura/2) <= 0 || pos.y + vel + (altura/2) >= height){
        vel = 0;
      }
      
      pos.y += vel;
      
    }
    
    void show() {
      rectMode(CENTER);
      noStroke();
      fill(255);
      rect(pos.x, pos.y, largura, altura);
    }
  }
