
void keyPressed() {
  if (mode == 0) {
    if (key == '\n') {  //enter key
      wordToAdd = typing;
      typing = "";
      if ( oldWords != null) {
        if (wordToAdd != "") {
          String[] newWords = new String[oldWords.length+1];
          for (int i = 0; i < oldWords.length; i++) {
            newWords[i] = oldWords[i];
          }
          newWords[newWords.length-1] = wordToAdd;
          oldWords = newWords;
          saveStrings("data/NEWWORDS.txt", newWords);
        }
      } else {
        oldWords[0] = wordToAdd;
        println(oldWords[0]);
      }
    } else if (int(key) == 8) {  //backspace
      if (typing != "") {
        String newString = typing.substring(0, max(0, typing.length()-1));
        typing = newString;
      }
    } else if (key != CODED) {
      typing = typing + key;
    } else if (key == CODED) {
      if (keyCode == UP) {
        if (currentParent > 0) {
          currentParent--; 
          println(currentParent);
        } else {
          currentParent = nodes.size()-1;
        }
        if (mode == 0) {
          dragX = (width/2)/mapZoomScale - nodes.get(currentParent).pos.x;
          dragY = (height/2)/mapZoomScale - nodes.get(currentParent).pos.y;
        }
      } 
      if (keyCode == DOWN) {
        if (currentParent < nodes.size()-1) {
          currentParent++;
          println(currentParent);
        } else {
          currentParent = 0;
        }
        if (mode == 0) {
          dragX = (width/2)/mapZoomScale - nodes.get(currentParent).pos.x;
          dragY = (height/2)/mapZoomScale - nodes.get(currentParent).pos.y;
        }
      }
    }
  }
} 

void mousePressed() {
  if (mode == 0) {
    if (loadNewPhrase.isPressed()) {
      whichText = (int)random(7);
      currentMix = getTopic();
      loadNewPhrase.text = "another";
    }
    if (showMap.isPressed()) {
      mode = 1;
      showMap.text = "close map";
      float avgPosX = 0;
      float avgPosY = 0;
      for (Node node : nodes) {
        avgPosX += node.pos.x;
        avgPosY += node.pos.y;
      }
      avgPosX = avgPosX / nodes.size();
      avgPosY = avgPosY / nodes.size();
      dragX = (width/2)- avgPosX;
      dragY = (height/2) - avgPosY;
      dragFollow.x = (width/2) - avgPosX;
      dragFollow.y = (height/2) - avgPosY;
    }
    for (int i = 0; i < texts.length; i++) {
      if (texts[i].isPressed() && texts[i].visible) {
        wordToAdd = texts[i].text;
      }
    }
    if (addNode.visible && addNode.isPressed()) {           
      //tintColor = color(random(150, 240), random(150, 240), random(150, 240), 200);
      Node newNode = new Node(wordToAdd);
      for (Node otherNode : nodes) {    //make sure the node doesn't already exist
        if (otherNode.text == newNode.text) {      
          repeatedNode = true;
          println(wordToAdd + " has already been entered" + " in " + otherNode.text);
        }
      }
      if (!repeatedNode) {
        if (nodes.size() > 0) {      // make sure there's a parent node       
          (nodes.get(currentParent)).nodeNodes.add(newNode);
          println("add new node as child node of parent node");
          (nodes.get(currentParent)).currentNodeNodes++;    
          println("new subnode count for this parent " + (nodes.get(currentParent)).currentNodeNodes);
          newNode.pos = new PVector(nodes.get(currentParent).pos.x+random(30, 70), nodes.get(currentParent).pos.y+random(-50, 50)) ;
        }

        nodes.add(newNode);    //add new node to node collection
        dragX = (width/2)/mapZoomScale - newNode.pos.x;
        dragY = (height/2)/mapZoomScale - newNode.pos.y;
        currentParent = nodes.size()-1;
        for (int i = 0; i < nodes.size (); i++) {
          Node node = nodes.get(i);
          println(node.text);
        }
        println(" ");
      } else {
        for (Node otherNode : nodes) {    //find the other node named the thing - probably could be written better**
          if (otherNode.text == newNode.text) {
            if (!otherNode.nodeNodes.contains(nodes.get(currentParent))) {  //not sure if this is working the way i want it to - trying to prevent multiple lines from being drawn over one another, etc.
              otherNode.currentNodeNodes++;
              otherNode.nodeNodes.add(nodes.get(currentParent));
              println("added the other node? othernode.currentNodeNodes: " + otherNode.currentNodeNodes);
            }
          }
        }
        //add the current to the nodeNodes of the previously linked one
      }
      repeatedNode = false;
    }
  } else if (mode == 1) {  //MAP MODE
    if (showMap.isPressed()) {
      mode = 0;
      showMap.text = "map";
      dragX = (width/2)/mapZoomScale - nodes.get(currentParent).pos.x;
      dragY = (height/2)/mapZoomScale - nodes.get(currentParent).pos.y;
      dragFollow.x = (width/2)/mapZoomScale - nodes.get(currentParent).pos.x;
      dragFollow.y = (height/2)/mapZoomScale - nodes.get(currentParent).pos.y;
    }
    if (saveMap.isPressed()) {
      record = true;
    }
    for (Node node : nodes) {
      if (node.isPressed()) {
        break;
      }
      if (!deleteNode.isPressed()) {
        deleteNode.visible = false;
        node.canDelete = false;
      }
    }
  }
}

void mouseDragged() {
  drag = true;
} 

void mouseReleased() {
  movingNode = false;
  for (Node node : nodes) {
    node.moving = false;
  }
}

