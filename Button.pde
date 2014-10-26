public class Button {
  String text;
  float size; 
  float x;
  float y; 
  boolean visible;

  public Button(String text, float x, float y) {
    this.text = text;
    this.size = text.length() * 5;
    this.x = x;
    this.y = y;
    visible = true;
  }

  public void draw() { 
    size = text.length() * 5;
    if (mode == 0) {
      if (mouseX > x-size && mouseX < x+size && mouseY > y-10 && mouseY < y+20) {
        //    if (dist(x, y, mouseX, mouseY) < size) {
        fill(255);
      } else {
        fill(180);
      }
    } else {
      if (mouseX > x-size && mouseX < x+size && mouseY > y-10 && mouseY < y+20) {
        //    if (dist(x, y, mouseX, mouseY) < size) {
        fill(0);
      } else {
        fill(100);
      }
    }
    textAlign(CENTER, CENTER);
    text(text, x, y);
  } 

  public boolean isPressed() {
    if (mouseX > x-size && mouseX < x+size && mouseY > y-10 && mouseY < y+20) {
      //if (dist(x, y, mouseX, mouseY) < size) {
      return true;
    }
    return false;
  } 
  //  public String getString() {
  //    return text;
  //  }
} 

