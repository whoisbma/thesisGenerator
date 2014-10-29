void drawSentence() {
  //0, 1, 2 - noun
  //3 - verb 
  //4, 5 - adjective
  //6 - interface
  //7 - dataSource
  textFont(fontL);
  textAlign(LEFT, TOP);
  fill(255);
  switch (whichText) {
  case 0 : 
    newSentence = currentMix[5] + " " + currentMix[6] + " expressing the "  + "\n " +
      currentMix[4] + " " + currentMix[1] + " of "  + "\n "
      + currentMix[2] + " with " + currentMix[0];
    text(newSentence, 50, 70);
    break;
  case 1 : 
    newSentence = currentMix[0] + " " + currentMix[1];
    text(newSentence, 50, 70);
    break;
  case 2 :
    newSentence = currentMix[2] + " that serves to " + currentMix[3] + " " + currentMix[1];
    text(newSentence, 50, 70);
    break;
  case 3 : 
    newSentence = currentMix[3] + " " + currentMix[0] + " by searching " + "\n " + currentMix[7];
    text(newSentence, 50, 70);
    break;
  case 4 : 
    newSentence = currentMix[6] + " made of " + currentMix[4] + " " + currentMix[0];
    text(newSentence, 50, 70);
    break;
  case 5 : 
    newSentence = currentMix[4] + " " + currentMix[0] + " juxtaposed with " + "\n " +
      currentMix[5] + " " + currentMix[1];
    text(newSentence, 50, 70);
    break;
  case 6 : 
    newSentence = currentMix[5] + " " + currentMix[0] + " to " + currentMix[3];
    text(newSentence, 50, 70);
    break;
  }
}

void drawButtons() {
  textFont(fontS);
  switch (whichText) {
  case 0 : 
    texts[5].draw();    
    texts[6].draw();
    texts[4].draw();
    texts[1].draw();
    texts[2].draw();
    texts[0].draw();
    texts[5].visible = true; 
    texts[6].visible = true;
    texts[4].visible = true; 
    texts[1].visible = true; 
    texts[2].visible = true; 
    texts[0].visible = true; 
    texts[7].visible = false; 
    break;
  case 1 : 
    texts[0].draw();
    texts[1].draw();
    texts[0].visible = true; 
    texts[1].visible = true; 
    texts[2].visible = false; 
    texts[3].visible = false;
    texts[4].visible = false; 
    texts[5].visible = false; 
    texts[6].visible = false; 
    texts[7].visible = false; 
    break;
  case 2 : 
    texts[2].draw();
    texts[3].draw();
    texts[1].draw();
    texts[2].visible = true; 
    texts[3].visible = true; 
    texts[1].visible = true; 
    texts[0].visible = false; 
    texts[4].visible = false;
    texts[5].visible = false; 
    texts[6].visible = false; 
    texts[7].visible = false; 
    break;
  case 3 : 
    texts[3].draw();
    texts[0].draw();
    texts[7].draw();
    texts[3].visible = true; 
    texts[0].visible = true; 
    texts[7].visible = true; 
    texts[1].visible = false; 
    texts[2].visible = false;
    texts[4].visible = false; 
    texts[5].visible = false; 
    texts[6].visible = false; 
    break;
  case 4 : 
    texts[6].draw();
    texts[4].draw();
    texts[0].draw();
    texts[6].visible = true; 
    texts[4].visible = true; 
    texts[0].visible = true; 
    texts[1].visible = false; 
    texts[2].visible = false;
    texts[3].visible = false; 
    texts[5].visible = false; 
    texts[7].visible = false; 
    break;
  case 5 : 
    texts[4].draw();
    texts[0].draw();
    texts[5].draw();
    texts[1].draw();
    texts[4].visible = true; 
    texts[0].visible = true; 
    texts[5].visible = true; 
    texts[1].visible = true; 
    break;
  case 6 : 
    texts[5].draw();
    texts[0].draw();
    texts[3].draw();
    texts[5].visible = true; 
    texts[0].visible = true; 
    texts[3].visible = true; 
    texts[1].visible = false; 
    texts[2].visible = false;
    texts[4].visible = false; 
    texts[6].visible = false; 
    texts[7].visible = false; 
    break;
  }
}


void displayAll() {  //for testing
  for (int i = 0; i < nouns.size (); i++) {
    String string = nouns.get(i); 
    text(string, 50, 60+i*25);
  }
  for (int i = 0; i < adjectives.size (); i++) {
    String string = adjectives.get(i); 
    text(string, 220, 60+i*25);
  }
  for (int i = 0; i < verbs.size (); i++) {
    String string = verbs.get(i); 
    text(string, 400, 60+i*25);
  }
  for (int i = 0; i < interfaces.size (); i++) {
    String string = interfaces.get(i); 
    text(string, 550, 60+i*25);
  }
  for (int i = 0; i < dataSources.size (); i++) {
    String string = dataSources.get(i); 
    text(string, 700, 60+i*25);
  }
} 

void displaySentences() { 
  textFont(fontXS);
  for (int i = sentences.size()-1; i >= 0; i--) {
  //for (int i = 0; i < sentences.size(); i++) {
    fill(100-(i * 10));
    textAlign(RIGHT, TOP);
    text(sentences.get(i), width-100, 70+i*60);
  }
  if (sentences.size() > 3) {
    sentences.remove(sentences.get(0));
  }
}

