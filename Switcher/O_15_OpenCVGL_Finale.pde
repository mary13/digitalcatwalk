// this is a mashup !!
// Open CV    http://ubaa.net/shared/processing/opencv/
// http://createdigitalmotion.com/2009/02/processing-tutorials-getting-started-with-video-processing-via-opencv/
// Mirrors 2 code from Processing video library
// Open GL Library from Processing


void FFdraw() {
  opencv.read();                   // grab frame from camera
  opencv.convert( GRAY );
  background(0);
  PImage camImage;                //  Creates an image and
  camImage = opencv.image();      //  stores the unprocessed camera frame in it

  opencv.absDiff();               //  Calculates the absolute difference
  opencv.convert( OpenCV.GRAY );  //  Converts the difference image to greyscale
  opencv.blur( OpenCV.BILATERAL, 50 );  //  I like to blur before taking the difference image to reduce camera noise*/
  opencv.threshold( thres );
  smooth();


  //  trailsImg.blend( opencv.image(), 0, 0, 640, 480, 0, 0, 640, 480, SCREEN );  //  Blends the movement image with the trails image
  trailsImg.blend( opencv.image(), 0, 0, capturewidth, captureheight, 0, 0, capturewidth, captureheight, SCREEN );  //  Blends the movement image with the trails image

  colorMode(RGB);                 //  Changes the colour mode to HSB so that we can change the hue
  tint(color(149, 240, 242));  //  Sets the tint so that the hue is equal to hcycle and the saturation and brightness are at 100%


  /* image( trailsImg, 0, 0 );       //  Display the blended difference image*/

  noTint();                       //  Turns tint off
  colorMode(RGB);                 //  Changes the colour mode back to the default

  blend( camImage, 0, 0, capturewidth, captureheight, 0, 0, capturewidth, captureheight, SCREEN );  //  Blends the original image with the trails image

  opencv.copy( trailsImg );       //  Copies trailsImg into OpenCV buffer so we can put some effects on it
  opencv.blur( OpenCV.BILATERAL, 50 );  //  Blurs the trails image
  opencv.brightness( -50 );       //  Sets the brightness of the trails image to -20 so it will fade out
  trailsImg = opencv.image();     //  Puts the modified image from the buffer back into trailsImg
  background(0);
  opencv.remember();              //  Remembers the current frame


  // MIRRORING 
  for (int i = 0; i < cols;i++) {
    // Begin loop for rows
    for (int j = 0; j < rows;j++) {

      // Where are we, pixel-wise?
      int x = i * cellSize;
      int y = j * cellSize;
      //   int loc = (trailsImg.width + x - 10) + y*trailsImg.width; // x to mirror the image
      int loc = (trailsImg.width + x/display_multiplier) + y/display_multiplier*trailsImg.width; // x to mirror the image

      float linex = random(50);
      float liney = random(50);
      // Each rect is colored white with a size determined by brightness
      color c = trailsImg.pixels[loc];
      float sz = (brightness(c) / 255.0) * cellSize;

      if (sz > 9) {
        stroke(255, 255, 255, random(255));
        strokeWeight(random(1));
        line((x + cellSize/2)-liney+30, (y + cellSize/2)- linex+30, ((x + cellSize/2)+liney-30), ((y + cellSize/2)+linex-30));


        noFill();

        fill(255, 255, 255, random(255));
        ellipse(x + cellSize/2, y + cellSize/2, sz+20, sz+20);
      }
      else if (sz <= 9) {
        stroke(116, 161, 255);
        //  fill(255, 255, 255, random(255));
        rect(x + cellSize/2, y + cellSize/2, sz, sz);
      }
    }
  }

  renderTexture(pgl.gl);    ///// FOR SYPHON
}

