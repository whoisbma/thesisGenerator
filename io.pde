void loadFromAll() {
  reader = createReader("nouns.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      nouns.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("adjectives.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      adjectives.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("verbs.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      verbs.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("interfaces.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      interfaces.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("dataSources.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      dataSources.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 
