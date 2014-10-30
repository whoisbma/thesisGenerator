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

ArrayList<String> sentences;

ArrayList<Node> nodes; 

float dragY;
float dragX;
boolean drag = false;
boolean record = false;

boolean repeatedNode = false; 

boolean movingNode = false;

String newSentence = new String("");

PFont font;
PFont fontS;
PFont fontXS;
PFont fontL;

Button loadNewPhrase;
Button showMap;
Button addNode; 
Button saveMap;
Button deleteNode;
Button cycleNodes;
Button[] texts = new Button[8];

float mapZoomScale = 3;
PVector dragFollow = new PVector(0, 0);

//String nodeSentence = new String(); 

PImage fade;
float rWidth;
float rHeight;
float rWidthMod;
float rHeightMod; 

//color tintColor = color(200, 159, 50, 230);

int mode = 0;

int prevWidth;
int prevHeight;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void setup() {
  size(1250, 800);
  if (frame != null) {
    frame.setResizable(true);
  }
  background(10); 
  nouns = new ArrayList<String>(); 
  adjectives = new ArrayList<String>(); 
  verbs = new ArrayList<String>(); 
  interfaces = new ArrayList<String>(); 
  dataSources = new ArrayList<String>(); 

  sentences = new ArrayList<String>(); 

  oldWords = loadStrings("NEWWORDS.txt");

  cursor(CROSS);

  showMap = new Button("map", width-250, height-60, 17);
  loadNewPhrase = new Button("start", width-100, height-60, 17);
  addNode = new Button("add node:", 120, height-60, 17);
  saveMap = new Button("save", width-100, height-60, 17); 
  deleteNode = new Button("delete", 120, height-60, 17);
  cycleNodes = new Button("cycle nodes", width-440, height-60, 17);


  float startX = 100;
  float div = (width-(startX/2))/texts.length;
  texts[0] = new Button("", startX, height-150, 10);
  texts[1] = new Button("", startX+div*1, height-150, 10);
  texts[2] = new Button("", startX+div*2, height-150, 10);
  texts[3] = new Button("", startX+div*3, height-150, 10);
  texts[4] = new Button("", startX+div*4, height-150, 10);
  texts[5] = new Button("", startX+div*5, height-150, 10);
  texts[6] = new Button("", startX+div*6, height-150, 10);
  texts[7] = new Button("", startX+div*7, height-150, 10);

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

  //  rWidthMod = 1;
  //  rHeightMod = .995;
  //  rWidth = width * rWidthMod; 
  //  rHeight = height * rHeightMod;
  //  fade = get(0, 0, width, height);
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
  checkFrameResize();
}
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void drawMain() {
  background(10);
  //  tint(tintColor);
  //  image(fade, 0, 1, width, height);

  drawMap();

  textFont(font);
  fill(255);
  textAlign(LEFT, CENTER);
  text(wordToAdd, 210, height-60);
  displaySentences();
  drawSentence();

  //  fade = get(0, 0, width, height);

  textFont(font);
  loadNewPhrase.draw();

  if (nodes.size() > 1) {
    cycleNodes.draw();
    showMap.draw();
    showMap.visible = true;
  } else {
    showMap.visible = false;
  }
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
  text("type: ", 30, height-105);
  fill(255);
  text(typing, 125, height-105);
}
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
void drawMap() {
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  pushMatrix(); 
  if (mode == 1) {
    background(250);
    saveMap.visible = true;
    //currentParent = 0;
//    fill(0);
//    textAlign(LEFT, TOP);
//    text(nodeSentence, 50, 100);
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
  translate(dragFollow.x, dragFollow.y);
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
  if (mode == 1) {
    showMap.draw();
  }
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
          if (otherNode.nodeNodes.get(j).equals(node.text)) {//   otherNode.nodeNodes.get(j).text == node.text  ){
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

void checkFrameResize() {
  if (width != prevWidth || height != prevHeight) {
    showMap = new Button(showMap.text, width-250, height-60, 17);
    loadNewPhrase = new Button(loadNewPhrase.text, width-100, height-60, 17);
    addNode = new Button("add node:", 120, height-60, 17);
    saveMap = new Button("save", width-100, height-60, 17); 
    deleteNode = new Button("delete", 120, height-60, 17);
    cycleNodes = new Button("cycle nodes", width-440, height-60, 17);

    float startX = 100;
    float div = (width-(startX/2))/texts.length;
    texts[0] = new Button(texts[0].text, startX, height-150, 10);
    texts[1] = new Button(texts[1].text, startX+div*1, height-150, 10);
    texts[2] = new Button(texts[2].text, startX+div*2, height-150, 10);
    texts[3] = new Button(texts[3].text, startX+div*3, height-150, 10);
    texts[4] = new Button(texts[4].text, startX+div*4, height-150, 10);
    texts[5] = new Button(texts[5].text, startX+div*5, height-150, 10);
    texts[6] = new Button(texts[6].text, startX+div*6, height-150, 10);
    texts[7] = new Button(texts[7].text, startX+div*7, height-150, 10);
  } 
  prevWidth = width;
  prevHeight = height;
}

/*
void generateNodeSentence() {
  String[] highPNodes = new String[nodes.size()];
  String[] midPNodes = new String[nodes.size()];
  String[] lowPNodes = new String[nodes.size()];
  String[] onePNode = new String[nodes.size()];
  int highIndex = 0; 
  int midIndex = 0;
  int lowIndex = 0;
  int oneIndex = 0;
  for (Node node : nodes) {
    if (node.nodeNodes.size() > 5) {
      println("thats a lot of nodes for " + node.text + " guy");
      highPNodes[highIndex] = node.text;
      highIndex++;
    } else if (node.nodeNodes.size() > 3 && node.nodeNodes.size() <= 4) {
      println("thats a few nodes for " + node.text + " guy");
      midPNodes[midIndex] = node.text;
      midIndex++;
    } else if (node.nodeNodes.size() > 1 && node.nodeNodes.size() <= 3) {
      println("thats a couple of nodes for " + node.text + " guy");
      lowPNodes[lowIndex] = node.text;
      lowIndex++;
    } else if (node.nodeNodes.size() > 0 && node.nodeNodes.size() <= 1) {
      println("thats one node for " + node.text + " guy");
      onePNode[oneIndex] = node.text;
      oneIndex++;
    } 
  }
  
  String[] articles = {" of ", " the ", " by ", " for ", " with "};
  
  if (highIndex > 1 && midIndex > 0 && lowIndex > 0 && oneIndex > 0) {
    nodeSentence = 
                    highPNodes[(int)random(highIndex)] + articles[(int)random(5)] + 
                    highPNodes[(int)random(highIndex)] + articles[(int)random(5)] + 
                    midPNodes[(int)random(midIndex)];
  } else if (highIndex > 0 && midIndex > 1 && lowIndex > 0 && oneIndex > 0) {
    nodeSentence = 
                    highPNodes[(int)random(highIndex)] + articles[(int)random(5)] + 
                    midPNodes[(int)random(midIndex)] + articles[(int)random(5)] +
                     midPNodes[(int)random(midIndex)];
  } else if (highIndex > 0 && midIndex > 0 && lowIndex > 1 && oneIndex > 0) {
    nodeSentence = 
                   highPNodes[(int)random(highIndex)] + articles[(int)random(5)] + 
                    midPNodes[(int)random(midIndex)] + articles[(int)random(5)] + 
                     lowPNodes[(int)random(lowIndex)];
  } else if (highIndex == 0 && midIndex > 0 && lowIndex > 0 && oneIndex > 0) {
    nodeSentence = 
                   midPNodes[(int)random(midIndex)] + articles[(int)random(5)] + 
                    lowPNodes[(int)random(lowIndex)] + articles[(int)random(5)] + 
                     onePNode[(int)random(oneIndex)];
  } else if (highIndex == 0 && midIndex > 1 && lowIndex > 0 && oneIndex > 0) {
    nodeSentence = 
                   midPNodes[(int)random(midIndex)] + articles[(int)random(5)] + 
                    midPNodes[(int)random(midIndex)] + articles[(int)random(5)] + 
                     lowPNodes[(int)random(lowIndex)];
  }  else if (highIndex == 0 && midIndex == 0 && lowIndex > 1 && oneIndex > 0) {
    nodeSentence = 
                   lowPNodes[(int)random(lowIndex)] + articles[(int)random(5)] + 
                    lowPNodes[(int)random(lowIndex)] + articles[(int)random(5)] + 
                     onePNode[(int)random(oneIndex)];
  } else if (highIndex == 0 && midIndex == 0 && lowIndex > 0 && oneIndex > 1) {
    nodeSentence = 
                   lowPNodes[(int)random(lowIndex)] + articles[(int)random(5)] + 
                    onePNode[(int)random(oneIndex)] + articles[(int)random(5)] + 
                     onePNode[(int)random(oneIndex)];
  } else if (highIndex == 0 && midIndex == 0 && lowIndex == 0 && oneIndex > 2) {
    nodeSentence = 
                   onePNode[(int)random(oneIndex)] + articles[(int)random(5)] + 
                    onePNode[(int)random(oneIndex)] + articles[(int)random(5)] + 
                     onePNode[(int)random(oneIndex)];
  } else {
    nodeSentence = "";
    println("no sentence for you");
  }
  println("high indices:");
  for (int i = 0; i < highIndex; i++) {
    println(highPNodes[i]);
  }
  println("mid indices:");
  for (int i = 0; i < midIndex; i++) {
    println(midPNodes[i]);
  }
  println("low indices:");
  for (int i = 0; i < lowIndex; i++) {
    println(lowPNodes[i]);
  }
  println("one index:");
  for (int i = 0; i < oneIndex; i++) {
    println(onePNode[i]);
  }
 
  println("node sentence generated:" + nodeSentence);
} */

