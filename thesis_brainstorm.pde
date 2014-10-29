//whoisbma 10/2014
//thesis research inspiration/domain map generator
//click start to generate first sentence
//click on keywords near bottom of screen then press "add node" to save keyword as node
//alternatively, write with keyboard, press enter, then "add node" to save as node
//clicking on "another" generates new phrase
//use the arrow keys (up and down) to select existing node for connections

import processing.pdf.*;

ArrayList<String> nouns;
ArrayList<String> adjectives;
ArrayList<String> verbs;
ArrayList<String> interfaces;
ArrayList<String> dataSources;
BufferedReader reader;
String loadLine; 
String[] currentMix = new String[8];
String typing = "";
String wordToAdd = "";
int currentParent = 0; 
int whichText = 1; 

String[] oldWords;

ArrayList<Node> nodes; 

float dragY;
float dragX;
boolean drag = false;
boolean record = false;

boolean repeatedNode = false; 

boolean movingNode = false;

PFont font;
PFont fontS;
PFont fontXS;
PFont fontL;

Button loadNewPhrase;
Button showMap;
Button addNode; 
Button saveMap;
Button deleteNode;
Button[] texts = new Button[8];

float mapZoomScale = 3;
PVector dragFollow = new PVector(0, 0);

PImage fade;
float rWidth;
float rHeight;
float rWidthMod;
float rHeightMod; 

//color tintColor = color(200, 159, 50, 230);

int mode = 0;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void setup() {
  size(1250, 800);//, P3D);
  background(10); 
  nouns = new ArrayList<String>(); 
  adjectives = new ArrayList<String>(); 
  verbs = new ArrayList<String>(); 
  interfaces = new ArrayList<String>(); 
  dataSources = new ArrayList<String>(); 

  oldWords = loadStrings("NEWWORDS.txt");

  cursor(CROSS);

  showMap = new Button("map", 1000, 740, 17);
  loadNewPhrase = new Button("start", 1150, 740, 17);
  addNode = new Button("add node: ", 120, 740, 17);
  saveMap = new Button("save", 1150, 740, 17); 
  deleteNode = new Button("delete", 120, 740, 17);

  texts[0] = new Button("", 100, 650, 10);
  texts[1] = new Button("", 250, 650, 10);
  texts[2] = new Button("", 400, 650, 10);
  texts[3] = new Button("", 550, 650, 10);
  texts[4] = new Button("", 700, 650, 10);
  texts[5] = new Button("", 850, 650, 10);
  texts[6] = new Button("", 1000, 650, 10);
  texts[7] = new Button("", 1150, 650, 10);

  nodes = new ArrayList<Node>(); 

  font = createFont("Cousine-Regular.ttf", 30);
  fontS = createFont("Cousine-Regular.ttf", 16);
  fontXS = createFont("Cousine-Regular.ttf", 12); 
  fontL = createFont("Cousine-Regular.ttf", 40);

  noSmooth();
  for (int i = 0; i < currentMix.length; i++) {
    currentMix[i] = " ";
  }
  loadFromAll();

  rWidthMod = 1;
  rHeightMod = .995;
  rWidth = width * rWidthMod; 
  rHeight = height * rHeightMod;
  fade = get(0, 0, width, height);
}
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void draw() {
  background(10);
  if (mode == 0) {
    drawMain();
  } else if (mode == 1) {
    drawMap();
  }
}
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void drawMain() {
  background(10);
  //  if (nodes.size() > 0) {
  //    textAlign(CENTER, CENTER);
  //    textFont(fontL);
  //    textSize(150); 
  //    fill(255, 15);
  //    text(nodes.get(currentParent).text, width/2, height/2);
  //  }

  //  tint(tintColor);
  //  image(fade, 0, 1, width, height);

  drawMap();

  textFont(font);
  fill(255, 50);
  textAlign(LEFT, CENTER);
  text(wordToAdd, 200, 740);

  drawSentence();
  //  if (nodes.size() > 0) {
  //    pushMatrix();
  //    if (drag == true) {
  //      translate(dragX, dragY);
  //    }
  //    popMatrix();
  //  }
  //  fade = get(0, 0, width, height);

  textFont(font);
  loadNewPhrase.draw();
  showMap.draw();

  if (wordToAdd != "") {
    addNode.draw();
    addNode.visible = true;
  } else {
    addNode.visible = false;
  }
  drawButtons();

  textAlign(LEFT, CENTER);
  textFont(font);
  fill(255, 100);
  text("type: ", 30, 695);
  fill(255);
  text(typing, 125, 695);
}
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void drawMap() {
  pushMatrix(); 
  if (mode == 1) {
    background(250);
    saveMap.visible = true;
    if (record) {
      beginRecord(PDF, "frame-####.pdf");
    }
    //currentParent = 0;
  } else {
    saveMap.visible = false;
    deleteNode.visible = false;
    scale(mapZoomScale);
  }
  if (drag == true && movingNode == false) {
    if (mode == 0) {
      dragFollow.x += (mouseX-pmouseX) / mapZoomScale;
      dragFollow.y += (mouseY-pmouseY) / mapZoomScale;
      dragX += (mouseX-pmouseX) / mapZoomScale;
      dragY += (mouseY-pmouseY) / mapZoomScale;
    } else {
      dragX += mouseX-pmouseX;
      dragY += mouseY-pmouseY;
      dragFollow.x += mouseX-pmouseX;
      dragFollow.y += mouseY-pmouseY;
    }
  }

  pushMatrix();

  //  if (drag == true) {
  //    translate(dragX, dragY);
  //  } else {
  translate(dragFollow.x, dragFollow.y);
  //  }

  dragFollow.x += (dragX - dragFollow.x) * 0.1;
  dragFollow.y += (dragY - dragFollow.y) * 0.1;

  for (Node node : nodes) {
    node.update();
    node.displayLines();
  }
  for (Node node : nodes) {
    node.displayText();
    if (node.canDelete == true) {
      deleteNode.visible = true;
    }
  }
  popMatrix();
  popMatrix();
  //  text("dragX : " + dragX,100,height/2 - 15);
  //  text("dragY : " + dragY,100,height/2 + 15);
  if (record) {
    record = false;
    endRecord();
  }

  textAlign(CENTER);
  textFont(font);
  showMap.draw();
  if (saveMap.visible) {
    saveMap.draw();
  }
  if (deleteNode.visible) {
    deleteNode.draw();
  }

  drag = false;
  removeNodes();
} 

void removeNodes() {
  for (int i = 0; i < nodes.size (); i++) {  
    Node node = nodes.get(i);
    if (node.deleted == true) {
      for (Node otherNode : nodes) {        //this part might be fucked up aka WTF
        for (int j = 0; j < otherNode.nodeNodes.size (); j++) {
          if (otherNode.nodeNodes.get(j).text == node.text) {
            otherNode.nodeNodes.remove(j);
            otherNode.currentNodeNodes--;
          }
        }
      }
      nodes.remove(i);
      currentParent = 0; 
    }
  }
} 

