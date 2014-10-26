
String[] getTopic() {
  String[] topics = new String[8]; 
  int randNoun = (int)random(nouns.size()); 
  int randNoun1 = (int)random(nouns.size());
  int randNoun2 = (int)random(nouns.size());
  int randVerb = (int)random(verbs.size()); 
  int randAdjective1 = (int)random(adjectives.size()); 
  int randAdjective2 = (int)random(adjectives.size()); 
  int randInterface = (int)random(interfaces.size());
  int randDataSources = (int)random(dataSources.size()); 

  for (int i = 0; i < nouns.size (); i++) {
    if (i == randNoun) {
      String string = nouns.get(i); 
      topics[0] = string;
      texts[0].text = string;
    }
  }
  for (int i = 0; i < nouns.size (); i++) {
    if (i == randNoun1) {
      String string = nouns.get(i); 
      topics[1] = string;
      texts[1].text = string;
    }
  }
  for (int i = 0; i < nouns.size (); i++) {
    if (i == randNoun2) {
      String string = nouns.get(i); 
      topics[2] = string;
      texts[2].text = string;
    }
  }
  for (int i = 0; i < verbs.size (); i++) {
    if (i == randVerb) {
      String string = verbs.get(i); 
      topics[3] = string;
      texts[3].text = string;
    }
  }
  for (int i = 0; i < adjectives.size (); i++) {
    if (i == randAdjective1) {
      String string = adjectives.get(i); 
      topics[4] = string;
      texts[4].text = string;
    }
  }
  for (int i = 0; i < adjectives.size (); i++) {
    if (i == randAdjective2) {
      String string = adjectives.get(i); 
      topics[5] = string;
      texts[5].text = string;
    }
  }
  for (int i = 0; i < interfaces.size (); i++) {
    if (i == randInterface) {
      String string = interfaces.get(i); 
      topics[6] = string;
      texts[6].text = string;
    }
  }
  for (int i = 0; i < dataSources.size (); i++) {
    if (i == randDataSources) {
      String string = dataSources.get(i); 
      topics[7] = string;
      texts[7].text = string;
    }
  }
  return topics;
}

