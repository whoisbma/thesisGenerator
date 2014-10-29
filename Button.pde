public class Button {
  String text;
  float size; 
  float x;
  float y; 
  boolean visible;
  int sizeMod;

  public Button(String text, float x, float y, int sizeMod) {
    this.text = text;
    this.sizeMod = sizeMod;
    this.size = text.length() * sizeMod;
    this.x = x;
    this.y = y;
    visible = true;
  }

  public void draw() { 
    size = text.length() * sizeMod;
    if (sizeMod == 10) {
      rectMode(CORNER);
      noStroke();
      fill(35);
      rect(x-size/2,y-10, size, 20);
    }
    if (sizeMod == 17 && mode == 0) {
      rectMode(CORNER);
      noStroke();
      if (mouseX > x-size/2 && mouseX < x+size/2 && mouseY > y-10 && mouseY < y+20) {
        fill(100);
      } else {
        fill(35);
      }
      rect(x-size/2-5,y-15, size+10,35);
    } 
    if (mode == 0) {
      if (mouseX > x-size/2 && mouseX < x+size/2 && mouseY > y-10 && mouseY < y+20) {
        //    if (dist(x, y, mouseX, mouseY) < size) {
        fill(255);
      } else {
        fill(180);
      }
    } else {
      if (mouseX > x-size/2 && mouseX < x+size/2 && mouseY > y-10 && mouseY < y+20) {
        fill(0);
      } else {
        fill(100);
      }
    }
    textAlign(CENTER, CENTER);
    text(text, x, y);
  } 

  public boolean isPressed() {
    if (mouseX > x-size/2 && mouseX < x+size/2 && mouseY > y-10 && mouseY < y+20 && mouseButton == LEFT) {
      //if (dist(x, y, mouseX, mouseY) < size) {
      return true;
    }
    return false;
  } 
  //  public String getString() {
  //    return text;
  //  }
} 

