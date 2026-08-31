// P_3_1_1_01.pde
//
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
 
/**
 * typewriter. time reactive.
 *
 * MOUSE
 * position y           : adjust spacing (line height)
 *
 * KEYS
 * a-z                  : text input (keyboard)
 * backspace            : delete last typed letter
 * ctrl                 : save png + pdf
 */
 
boolean doSave = false;
 
String textTyped = "Type slow and fast!";
//float[] fontSizes = new float[textTyped.length()];

float[] fontSizes = new float[255];

float minFontSize = 30;
float maxFontSize = 80;
float newFontSize = 0;
 
int pMillis;
float maxTimeDelta = 5000.0;
float letterWidth;
float letterHeight;
 
float spacing = 2; // line height
float tracking = 0; // between letters
PFont font;

//String[] lines = loadStrings("http://www.egaldu.es/spam.txt");
String[] lines = loadStrings("nicespam.txt");

int cursor=0;
int cursorAnt=0;
int desplY=100;
int lastChar=1;
int lastSpace=1;
int lastMouseY=1;
int timeout=10000;

PImage img;
 
void setup() {
  size(800, 600);
  // make window resizable
 
  //font = createFont("Arial",10);
  font = loadFont("Consolas-48.vlw");
  //font = createFont("Consolas-48.vlw",40);
  //String[] fontList = PFont.list();
  //println(fontList);
 
  smooth();
  noCursor();
 
  // init fontSizes
  /* for (int i = 0; i < textTyped.length(); i++) {
    fontSizes[i] = minFontSize;
  }*/
  // for (int i = 0; i < lines.length; i++) {
  /*for (int i = 0; i < 22; i++) {
    fontSizes[i] = minFontSize;
  }*/
 

  pMillis = millis();
}
 
 
void draw() {
  //if (doSave) beginRecord(PDF, timestamp()+".pdf");
  background(0);
  textAlign(LEFT);
  //fill(255);
  noStroke();
  

  //consola();

  //img=loadImage("http://html.superusuario.egaldu.es/content/images/large/23.jpg");
  //size(img.width,img.height);
  
  //img=loadImage("http://html.superusuario.egaldu.es/content/images/large/IMG_3915.jpg");
  //size(img.width,img.height);
  
  //textcolor
  fill(240-map(mouseX,0,width,0,20));
  //fill(0,255-map(mouseX,0,width,0,50),0);
  
  //spacing = map(mouseY,0,height,5,120);
  spacing = map(mouseY,0,height,10,50);
  translate(0, desplY+spacing);
  //translate(20, desplY+spacing);

  //cursor = int(map(mouseY+mouseX, 0,height+width, 0,lines.length));

  // cambia el cursor segun raton o timeout
  if ( (millis() - pMillis) > timeout) {
	cursor=int(random(lines.length));
        pMillis=millis();
	}	
  else { 
	if ( mouseY != lastMouseY) {
 		cursor = int(map(mouseY/8,0,height/8,0,lines.length-1));
		lastMouseY=mouseY;
	}
  }

  //fontsize depende de x
  minFontSize = int(map(mouseX,0,width,40,80));

  if (cursor != cursorAnt) {
     pMillis=millis();
     cursorAnt = cursor;
     lastChar=1;
     //fill(255);
     //rect(x, y, width, height );
  }
//  else lastChar++;
  else  if (frameCount % 4 == 0) lastChar++;

 
  float x = 30, y = 25, fontSize = 20;
 
  //for (int i = 0; i < textTyped.length(); i++) {
  

  //for (int l = cursor; l < cursor+3; l++) {
  for (int l = cursor; l < cursor+1; l++) {
  //linea
    
//      println(lines[l]);      
      for (int f = 0; f < lines[l].length(); f++) {
          fontSizes[f] = minFontSize;
      }
 
      
      x=20;
      lastSpace=1;
      for (int i = 0; i < lines[l].length(); i++) {
      //caracter
    
        fill(240-map(mouseX,0,width,0,50));
        // get fontsize for the actual letter from the array
        fontSize = fontSizes[i];
        textFont(font, fontSize);
        char letter = lines[l].charAt(i);
        letterWidth  =textWidth(letter) + tracking;
     
        // println ("hola");
	//if ( letter == ' ' ) lastSpace=i;
	if ( str(letter).equals(" ") ) lastSpace=i;

	//borrar?
     
        if (x+letterWidth > width - 20 ) {
          // start new line and add line height
          x = 20;
          y += spacing+30;
        }
     
        // draw letter
	if ( millis() > 5000)
        if ( millis() % 1500 == 0) {
          //letter=lines[l+1].charAt(i);
          letter=' ';
        }

        if (frameCount % 2 == 0)
           if (lines[l].length()/i+1 % 2 == 0 ) fill(200, 200, 0);

        //if (millis()/1000 % 2 == 0) letter='x';

	// a veces no pintar la letra
        if ( millis() % 127 !=0 ) {
          text(letter, x, y);
        }
	// a veces pintar de otro color
	/*else if (lastChar > lines[l].length()){
          //fill(255,0,0);
          fill(250-map(mouseX,0,width,0,50),0,0);
          //fill(250-map(mouseX,0,width,0,50),250-map(mouseY,0,height,0,50),0);
          text(letter, x, y);
	}*/
	//else {
        //  fill(255,255,0)
        //  rect(x, y-spacing-30,letterWidth+10,spacing+30);
//	}

        // update x-coordinate for next letter
        x += letterWidth;

	//borrar?
        // borrar cortados a fin de linea
	if ( i < lines[l].length()-1) {
          letterWidth  =textWidth(lines[l].charAt(i+1)) + tracking;
        if (x+letterWidth > width - 20 ) {
          // el sigte caracter salta, restar caracter hasta espacio
          //fill(255,255,0);
          //textFont(font, fontSize+10);
          fill(0);
          //stroke(0);
          //noStroke;
          for (j=i;j>lastSpace;j--) {
               letter=lines[l].charAt(j);
               letterWidth  =textWidth(letter) + tracking;
               letterHeight  =textAscent() + textDescent();
               x -= letterWidth;
               text(lines[l].charAt(j),x,y);
               //rect(x, y-spacing-30,letterWidth+10,spacing+40);
               rect(x, y-letterHeight*1.05,letterWidth+10,letterHeight+20);
           }
	  //lastChar=lastSpace;
	  i=lastSpace;
          x = 20;
          y += spacing+30;
        }
        }

        // typewritter
	if ( i > lastChar) break;
    }
    // fin linea
 
    //x=x+50;
    y += spacing;
    //y=y+50;
    //y=y+letterWidth;

    }

    // /* adios blinking 
    // blinking cursor after text
    float timeDelta = millis() - pMillis;
    newFontSize = map(timeDelta, 0,maxTimeDelta, minFontSize,maxFontSize);
    newFontSize = min(newFontSize, maxFontSize);
 
    //fill(200, 30, 40);
    fill(0, 200, 0); // verde consola
    //if (frameCount/10 % 2 == 0) fill(0);
    if (second() % 2 == 0) fill(0);
    //rect(x, y, newFontSize/2, newFontSize/20);
    rect(x, y-spacing, fontSize/2, fontSize/20);
    //rect(x, y, 5, 5);
    // */
    
    //flash blanco
    if (random(5) > 4) 
      if (frameCount/120 % 2 == 0) {
       fill(240);
       rect(0, -desplY-spacing, width, height );
      }
}
 
 
void consola() {
// CONSOLA
//  pushMatrix();
  //translate(0,0);
  fill(255);
//  textFont(mono, minFontSize);
  text("mouse  ("+mouseX+","+mouseY+")", 10, 30);
//  text("pos    ("+ x+","+y+")", 10, 30);
  text("millis ("+millis()+","+pMillis+")", 10, 45);
  text( cursorAnt+"-"+cursor+":"+lines[cursor], 10, 60);
  text(int(random(lines.length)), 10, 70);
  text("lastChar,lastSpace ("+lastChar+","+lastSpace+")", 10, 80);
//  popMatrix();
}
 
/*void keyReleased() {
  // export pdf and png
  if (keyCode == CONTROL) doSave = true;
}

*/
 
 
void keyPressed() {
  if (key != CODED) {
    switch(key) {
    case '+':
        //cursor++;
	cursor==lines.lenght?cursor=0:cursor++;
        break;
       
    case '-':
        //cursor--;
	cursor==0?cursor=lines.lenght:cursor--;
        break;
    case DELETE:
    case BACKSPACE:
      if (textTyped.length() > 0) {
        textTyped = textTyped.substring(0,max(0,textTyped.length()-1));
        fontSizes = shorten(fontSizes);
      }
      break;
      // disable those keys
    case TAB:
    case ENTER:
    case RETURN:
    case ESC:
      break;
    default:
      textTyped += key;
      fontSizes = append(fontSizes, newFontSize);
    }
 
    // reset timer
    pMillis = millis();
  }
}
 
// timestamp
/*String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
*/





