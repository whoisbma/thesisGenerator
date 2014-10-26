void loadFromAll() {
  reader = createReader("data/nouns.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      nouns.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("data/adjectives.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      adjectives.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("data/verbs.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      verbs.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("data/interfaces.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      interfaces.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  reader = createReader("data/dataSources.txt"); 
  try {
    while ( (loadLine = reader.readLine ()) != null) {
      dataSources.add(loadLine);
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 
