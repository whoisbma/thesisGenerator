public class Node {
  String text; 
  //Node[] nodeNodes;
  ArrayList<Node> nodeNodes; 
  //  int maxNodes;
  int currentNodeNodes;
  PVector pos;
  int r; 

  Node(String text) {
    pos = new PVector(200+random(-5, 5), height/2+random(-5, 5));
    //pos = new PVector(200+random(-5,5),height/2+random(-5,5), random(-100,100));
    r = 120;//text.length() * 15; 
    this.text = text;
    nodeNodes = new ArrayList<Node>(); 
    currentNodeNodes = 0; 
    //    maxNodes = 5;
    //    nodeNodes = new Node[maxNodes];
    //    for (int i = 0; i < maxNodes; i++) { 
    //      nodeNodes[i] = null; 
    //    }
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
      for (Node childNode : nodeNodes) {
        if (otherNode == childNode) {
          if (mode == 0) {
            stroke(255,100);
          } else {
            stroke(0, 60);
          }
          line(pos.x, pos.y, otherNode.pos.x, otherNode.pos.y);
          //line(pos.x,pos.y,pos.z,otherNode.pos.x, otherNode.pos.y, otherNode.pos.z);
        }
      }
    }
  } 

  public void display() {
    //ellipse(pos.x,pos.y,r,r);
    if (mode == 0) {
      fill(255,100);
    } else {
      fill(0);
    }
    textAlign(CENTER, CENTER);
    textFont(fontXS);
    text(text, pos.x, pos.y, pos.z);
    update();
  }
}

