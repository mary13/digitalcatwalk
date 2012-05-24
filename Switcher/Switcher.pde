// MultiplePersonality
//
// this demonstrates how to switch between three bodies of code based on timed or 
// mouse-clicked change of mode. Here I am changing between pre-existing demo
// programs, Clock, Keyboard and Modulo. The only thing I have changed in these
// programs is the setup and draw function names. BY WENDY JU

/*Line Code    http://www.openprocessing.org/sketch/20348
Syphon    http://syphon.v002.info/
MadMapper    http://www.madmapper.com/
*/

import codeanticode.syphon.*;
import hypermedia.video.*;

import javax.media.opengl.*;    ///// FOR SYPHON
import processing.opengl.*;    ///// FOR SYPHON
import jsyphon.*;    ///// FOR SYPHON


int lastmode = -1;
int mode = 1;
int thres = 50;
int THRES_MAX = 180;
int THRES_MIN = 10;

JSyphonServer mySyphon;    ///// FOR SYPHON
PGraphicsOpenGL pgl;    ///// FOR SYPHON
GL gl;    ///// FOR SYPHON
int[] texID;    ///// FOR SYPHON


OpenCV opencv;
PImage trailsImg;                 //  Image to hold the trails
// Size of each cell in the grid
int cellSize = 15;
// Number of columns and rows in our system
int cols, rows;
int capturewidth = 256;
int captureheight = 192;
int display_multiplier = 5;

void setup() {
  // size( 640, 480 );
  size(display_multiplier*capturewidth, display_multiplier*captureheight, OPENGL );  ///// OPENGL FOR SYPHON


  pgl = (PGraphicsOpenGL) g;    ///// FOR SYPHON
  gl = pgl.gl;    ///// FOR SYPHON
  initSyphon(gl, "processing");    ///// FOR SYPHON


  opencv = new OpenCV( this );
  //  opencv.capture( 640, 480 );  // open video stream
  opencv.capture(capturewidth, captureheight, 5);  // open video stream

  //  trailsImg = new PImage( 640, 480 );  //  Initialises trailsImg
  trailsImg = new PImage(capturewidth, captureheight);  //  Initialises trailsImg

  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
}

//code that switches from one sketch to another
void draw() {
  switch (mode) {
  case 1: 

    FGdraw();

    break;
  case 2:

    BWdraw();

    break;
  case 3:

    GSdraw();

    break;
  case 4:

    SSdraw();

    break;
  case 5:

    CHdraw();

    break;
  case 6:

    RBdraw();

    break;
  case 7:

    LBdraw();

    break;
  case 8:

    LLdraw();

    break;
  case 9:

    ABdraw();

    break;
  case 10:

    JRdraw();

    break;
  case 11:

    JSdraw();

    break;
  case 12:

    AMdraw();

    break;
  case 13:

    SHdraw();

    break;
  case 14:

    JZdraw();

    break;

  case 15:

    FFdraw();

    break;
  }
}

void mousePressed() {
  mode = (mode+1)%3;
}

//key presses
void keyPressed() {
  if (key== 'A') {
    mode = 1;
  }
  if (key== 'B') {
    mode = 2;
  }
  if (key== 'C') {
    mode = 3;
  }
  if (key== 'D') {
    mode = 4;
  }
  if (key== 'E') {
    mode = 5;
  }
  if (key== 'F') {
    mode = 6;
  }
  if (key== 'G') {
    mode = 7;
  }
  if (key== 'H') {
    mode = 8;
  }
  if (key== 'I') {
    mode = 9;
  }
  if (key== 'J') {
    mode = 10;
  }
  if (key== 'K') {
    mode = 11;
  }
  if (key== 'L') {
    mode = 12;
  }
  if (key== 'M') {
    mode = 13;
  }
  if (key== 'N') {
    mode = 14;
  }
  if (key== 'O') {
    mode = 15;
  }
  if (key== ',') {
    if (thres>THRES_MIN) {
      thres = thres-5;
      println("thres = "+thres);
    }
  }
  if ( key=='.') {
    if (thres<THRES_MAX) {
      thres = thres+5;
      println("thres = "+thres);
    }
  }
}


/////    ///// FOR SYPHON BELOW /////    /////

void initSyphon(GL gl, String theName) {
  if (mySyphon!=null) {
    mySyphon.stop();
  }
  mySyphon = new JSyphonServer();
  mySyphon.test();
  mySyphon.initWithName(theName);

  // copy to texture, to send to Syphon.
  texID = new int[1];
  gl.glGenTextures(1, texID, 0);
  gl.glBindTexture(gl.GL_TEXTURE_RECTANGLE_EXT, texID[0]);
  gl.glTexImage2D(gl.GL_TEXTURE_RECTANGLE_EXT, 0, gl.GL_RGBA8, width, height, 0, gl.GL_RGBA, gl.GL_UNSIGNED_BYTE, null);
} 

void renderTexture(GL gl) {
  gl.glBindTexture(gl.GL_TEXTURE_RECTANGLE_EXT, texID[0]);
  gl.glCopyTexSubImage2D(gl.GL_TEXTURE_RECTANGLE_EXT, 0, 0, 0, 0, 0, width, height);
  mySyphon.publishFrameTexture(texID[0], gl.GL_TEXTURE_RECTANGLE_EXT, 0, 0, width, height, width, height, false);
}

public void stop() {
  dispose();
}

void dispose() {
  println("\n\nabout to stop sketch ...");
  println("deleting textures");
  gl.glDeleteTextures(1, texID, 0);
  if (mySyphon!=null) {
    println("stopping the syphon server");
    mySyphon.stop();
  }
  println("sketch stopped, done.");
}
//////   /////    /////   /////    /////

