public class Node {
  String text; 
  //Node[] nodeNodes;
  ArrayList<Node> nodeNodes; 
  //  int maxNodes;
  int currentNodeNodes;
  PVector pos;
  int r; 
  int circleR = 26;
  boolean selected = false; 
  boolean moving = false;
  boolean canDelete = false;
  boolean deleted = false; 

  Node(String text) {
    pos = new PVector(200+random(-5, 5), height/2+random(-5, 5));
    //pos = new PVector(200+random(-5,5),height/2+random(-5,5), random(-100,100));
    r = 100;//text.length() * 15; 
    this.text = text;
    nodeNodes = new ArrayList<Node>(); 
    currentNodeNodes = 0;
  }

  public void update() {
    for (Node otherNode : nodes) {
      float distance = dist(pos.x, pos.y, otherNode.pos.x, otherNode.pos.y);
      if (distance <= (r + otherNode.r)/2) {
        PVector escape = new PVector(pos.x - otherNode.pos.x, pos.y - otherNode.pos.y);
        escape.normalize();
        pos.x += escape.x * 1.1;
        pos.y += escape.y * 1.1;
      }
    }
    if (isPressed() && mode == 1 && movingNode == false) {
      movingNode = true;
      moving = true;
      if (nodes.size() > 0) {
        for (Node node : nodes) {
          node.canDelete = false;
        }
        canDelete = true;
      }
    }
    if (movingNode == true && moving == true) {
      pos.x = mouseX-dragX; 
      pos.y = mouseY-dragY;
      for (Node childNode : nodeNodes) {
        float distance = dist(pos.x, pos.y, childNode.pos.x, childNode.pos.y);
        if (distance > ((r + childNode.r)/2)-3) {
          PVector dir = new PVector(pos.x - childNode.pos.x, pos.y - childNode.pos.y);
          dir.normalize();
          childNode.pos.x += dir.x * .5;
          childNode.pos.y += dir.y * .5;
        }
      }
    }
    if (canDelete == true) {
      if (keyPressed) {
        //println(keyCode);
        if (key == BACKSPACE || key == DELETE) {
          deleted = true;
          println("pls delete this node thx");
        }
      }
      if (mousePressed) {
        if (deleteNode.visible && deleteNode.isPressed()) {
          deleted = true;
          println("pls delete this node thx");
        }
      }
    }
  }

  public void displayLines() {
    for (Node otherNode : nodes) {
      for (Node childNode : nodeNodes) {
        if (otherNode == childNode) {
          float distance = dist(pos.x, pos.y, otherNode.pos.x, otherNode.pos.y);
          if (mode == 0) {
            float c = map(distance, 100, 700, 80, 10);
            stroke(c, 90);
          } else {
            float c = map(distance, 100, 700, 150, 250);
            stroke(c);
          }
          line(pos.x, pos.y, otherNode.pos.x, otherNode.pos.y);
        }
      }
    }
  }

  public void displayText() {
    if (mode == 0) {
      fill(10);
      noStroke();
      rectMode(CENTER);
      rect(pos.x, pos.y+1, text.length() * 7.5, 14);
      //ellipse(pos.x, pos.y, circleR, circleR);
      if (text == nodes.get(currentParent).text) {
        fill(255, 90);
      } else {
        fill(100, 90);
      }
    } else {
      if (!isPressed()) {
        fill(250);
      } else {
        fill(210);
      }
      noStroke();
      //ellipse(pos.x, pos.y, circleR, circleR);
      rectMode(CENTER);
      rect(pos.x, pos.y+1, text.length() * 7.5, 14); 
      if (canDelete && !isPressed()) {
        //noFill();
        //stroke(150);
        fill(230);
        rect(pos.x, pos.y+1, text.length() * 7.5, 14);
        //ellipse(pos.x, pos.y, circleR-2, circleR-2);
      }
      fill(0);
    }
    textAlign(CENTER, CENTER);
    textFont(fontXS);
    text(text, pos.x, pos.y);//, pos.z);
  }

  public boolean isPressed() {
    //float d = dist(mouseX, mouseY, pos.x+dragX, pos.y+dragY);
    //  if (d < circleR * 0.5 && mousePressed) {
    if ( mouseX > pos.x+dragX-(text.length() * 7.5)/2 && mouseX < pos.x+dragX+(text.length() * 7.5)/2 &&
      mouseY > pos.y+dragY+1 - 14/2 && mouseY < pos.y+dragY+1 + 14/2 && 
      mousePressed) {
      return true;
    }
    return false;
  }
}

