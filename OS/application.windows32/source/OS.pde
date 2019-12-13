import processing.sound.*;

/*
  description: Batikha(Watermelon in another language) OS
 Author: Mostafa Hussein
 date of last edit: Dec 9 2019
 */

SoundFile startUp, unlock, shutdown, buttonPressed;
//variables
Boolean SystemOn = false, systemMenu=false, closeComputer = false, MaximumSize = false, movingMenuAllowed= true, halfSizeLeft = false, halfSizeRight = false, computerLock = false;
float loadingBarOffset, menuOffsetX=0, menuOffsetY=0, MaximizeX=0, MaximizeY=0;
PImage startingLogo, wallpaper, profilePicture, lensLogo, wifiLogo, apple, cursorBatikha, resize, lock;
PFont Text;
String user;
int monthNumber;
int minuteNumber, hourNumber, hourNumber_2;
float mouseIdleTimer=0;
String month, minuteValue, hourValue, dayTime, cursorMode = "normal";
int password=0;
//PASSWORD SETTING=============
int[] systemPassword = {1,2,3,4}; // can be changed by changing the value of this array
//PASSWORD SETTING=============
int[] enteredPassword = {0};
int numberOfButtomStuff = 0;


void settings() {
  size(1280, 720); //settings the size to be in 720p HD (since school screens are 1366*728)
}

void setup() {
  frameRate(-1);//unlimited frames (dosnt reach refresh rate here but since this OS is so good it is compatable with faster gpus and refresh rate monitors):D :D
  buttonPressed = new SoundFile(this, "buttonPressed.mp3"); // button Pressed being declared
  buttonPressed.amp(0.25);
  shutdown = new SoundFile(this, "shutdown.mp3"); // shutdown sound being declared
  startUp = new SoundFile(this, "startup.mp3"); // start up sound being declared
  unlock = new SoundFile(this, "unlock sound.mp3"); // unlocking sound being declared
  loadingBarOffset = 0; // the starting point of the loading bar for the start menu
  startingLogo = loadImage ("apple_logo.png"); // the logo at the begning (its called apple logo but it is a water melon
  startingLogo.resize(243/2, 299/2); // resizing it to shap
  wallpaper = loadImage("sierra.jpg"); //the background image used (it is one of apple's background images
  wallpaper.resize(1280, 720);// resizing the background image size since it is in 4k definition (which is what causes most of the lag at the start)
  profilePicture = loadImage("durpybanana.png"); // this is my profile picture as the user (just for the look of the OS)
  Text = createFont("Roboto-Regular.ttf", 12); //using my own custom font 
  lensLogo = loadImage("LensImage.png"); // lens image just to make it look like the Mac OS (just for looks too)
  lensLogo.resize(13, 13); // resizes the image to the size wanted to fit in the top bar
  wifiLogo = loadImage("wifiLogo.png"); // the wifi logo used (just for looks too)
  wifiLogo.resize(20, 14); // the wifi logo is resized to fit the top bar too
  apple = loadImage("apple.png"); //the watermelon logo top left (i called it apple since it was going to look like the apple os in the start)
  apple.resize(13, 13); //resizes the watermelon logo to fit top left
  user = "ME"; //This is done for the looks of the program and is placed top right on the top bar in the program
  lock = loadImage("lock.png"); // this is the lock image in the top bar inside the OS and it is used to shut down the OS
  lock.resize(13, 13); // resizes the picture to fit the top bar and look nice
  startUp.play(); // plays start up sound
}

void draw() {
  // this is for the "window" that open when you press the watermelon logo top left in the os after you log in using the password (1,2,3,4) [if placed incorrectly the OS will have to shut down as a cause of the 'saftey protocal'] and when the mouse is on the right side of the window it turns to the resize cross since you can resize the size of the window (on the right side only[make sure you are using it very slowly since it's not so fast at recognizing the movement of the mouse]

  if (cursorMode == "IMG") { //this is a variable used to set the cursor for the program
    if (systemMenu == true) {
      cursor(MOVE);
    }
  } else {
    cursor(ARROW);
  }
  // this checks for the position of the mouse in to set the cursor mode variable right above this
  if ((mouseX>(430+ MaximizeX)+menuOffsetX- 2 && mouseX<(430+ MaximizeX)+menuOffsetX +2 && mouseY>(30+ MaximizeY)+menuOffsetY&& mouseY<(430+ MaximizeY)+menuOffsetY)||(mouseX>(30+ MaximizeX)+menuOffsetX && mouseX<(430+ MaximizeX)+menuOffsetX && mouseY>(430+ MaximizeY)+menuOffsetY-2&& mouseY<(430+ MaximizeY)+menuOffsetY+2)) {
    cursorMode = "IMG";
  } else {
    cursorMode = "normal";
  }

  // gets the month on the computer (the actual one) to be used in the program
  // gets the minute too 
  // and the hour :D
  monthNumber = month();
  minuteNumber = minute();
  hourNumber = hour();
  // this checks for the time to say weather it is AM or PM by using the first variable to set the second variable
  if (hourNumber>12) {
    hourNumber_2 = hourNumber - 12;
    dayTime = "PM";
  } else {
    hourNumber_2=hourNumber;
    if (hourNumber_2 == 12) {
      dayTime = "PM"; // makes sure that 12 is pm.
    } else {
      dayTime = "AM";
    }
  }



  minuteValue = String.valueOf(minuteNumber); // take the minute number into another variable which is a string.
  hourValue = String.valueOf(hourNumber_2); // take the hour number into another variable which is a string.

  if (minuteNumber<10) {
    minuteValue = "0"+minuteValue;
  }

  //this checks if the computer is locked/ loading / running
  if (computerLock == true) {
    //if its locked the wallpaper is in the back with a really low opacity white rectangle making it look nice
    background(wallpaper);
    fill(238, 238, 238, 200);
    //turns screen red when self disctructing
    if (selfDestructText == true) {
      fill(255, 0, 0, 100);
    }
    rect(-4, -4, width+8, height+8);
    for (int PasswordDash = width/2 - 150; PasswordDash <width/2 +150; PasswordDash += 75 ) { // for loop for the dashs that represent the password length
      stroke(0);
      strokeWeight(3);
      line(PasswordDash, height/2-200, PasswordDash+60, height/2-200);
    }
    noStroke();
    fill(150, 150, 150, 220);
    //draws the circles for the passcode that can be pressed with the mouse
    for (int circleY = height/2-120; circleY< height/2+110; circleY+=80) {
      for (int circleX = width/2-85; circleX < width/2 +105; circleX+=80) {
        fill(150, 150, 150, 220);
        ellipse( circleX, circleY, 70, 70);
        ellipse(width/2-5, height/2+40+80, 70, 70); // the buttom for the 0

        fill(0);
        textSize(30);
        text(password, circleX-9, circleY+10); // this writes out the numbers
        text("0", 626, 492); // writes the 0
        password+=1;  // this is to write the diffrent numbers
      }
    }

    password=1; // this is needed to the have the right numbers

    //checks if it should close the OS then shuts down after a specific amount of time
    if (closeComputer == true) {
      for (int u=10; u>0; u--) {
        delay(100);
        if (shutdown.isPlaying() == false) {
          shutdown.play();
        }
      }
      exit();
    }

    // this draws the * that represents the number of pass code numbers written
    if (enteredPassword.length >= 2) {
      textSize(40);
      text("*", 509, 160);
      textSize(40);
    }
    if (enteredPassword.length >= 3) {
      textSize(40);
      text("*", 586, 160);
      textSize(40);
    }
    if (enteredPassword.length >= 4) {
      textSize(40);
      text("*", 659, 160);
      textSize(40);
    }   

    //shows self destruct text
    if (selfDestructText == true) {
      textSize(60);
      fill(255, 0, 0);
      text("Self destruct", 452, 288);
      closeComputer = true;
    }



    fill(0); // resets colour to black
    // what happens when there is 5 numbers in the entered pass word array with the first 4 being the password and the last one being 0
    if (enteredPassword != null) {
      if (enteredPassword.length == 5) {
        textSize(40);
        text("*", 732, 160);
        textSize(40);
        checkPassword();
      }
    }
  }
  // before the password screen comes up (computer loading)
  if (computerLock == false&&SystemOn == false) {
    background(0);
    stroke(255);
    strokeWeight(10);
    image(startingLogo, width/2-243/4, height/2-299/4);
    if (loadingBarOffset+74<1206) {
      loadingBarOffset += 10;
    }
    line(74, 636, 75+loadingBarOffset, 636);

    if (loadingBarOffset+74 >= 1205) {
      computerLock = true; // when the bar stops "loading" the password screen pops up
      //SystemOn = false; //if the // are removed add them to computer lock this removes the password step for the OS
    }
  }
  if (SystemOn == true) {
    // when the password is entered
    background(wallpaper);
    noStroke();
    fill(225, 120, 120, 190);


    //top bar
    fill(238, 238, 238, 200);
    rect(-3, -3, 1286, 25, 3, 3, 0, 0);


    //profile picture top bar 

    image(profilePicture, 1222, 4);

    // types the name of user (for looks)
    textFont(Text);
    fill(70);
    text(user, 1244, 15);
    // adds the lens 
    image(lensLogo, 1200, 5);

    // this the batch of code that creates 
    if (monthNumber == 1) {
      month = "January";
    } else if (monthNumber == 2) {
      month = "February";
    } else if (monthNumber == 3) {
      month = "March";
    } else if (monthNumber == 4) {
      month = "April";
    } else if (monthNumber == 5) {
      month = "May";
    } else if (monthNumber == 6) {
      month = "June";
    } else if (monthNumber == 7) {
      month = "July";
    } else if (monthNumber == 8) {
      month = "August";
    } else if (monthNumber == 9) {
      month = "September";
    } else if (monthNumber == 10) {
      month = "October";
    } else if (monthNumber == 11) {
      month = "November";
    } else {
      month = "December";
    }

    // prints out the date on the OS
    fill(70);
    text(month+" "+hourValue+":"+minuteValue+" "+dayTime, 1082.25, 15.25);
    // shows the wifi logo for looks
    image(wifiLogo, 1058, 4);
    //shows the apple logo for looks
    image(apple, 17, 4);
    // show the lock icon
    tint(0);//tint to make it look black not gray 
    image(lock, 1035, 6);
    noTint();
    //if the menu(menu is open)
    if (systemMenu == true) {
      fill(230, 230, 230, 200);
      rect(30+menuOffsetX, 30+menuOffsetY, 400 + MaximizeX, 400 + MaximizeY, 8); //draws the window
      fill(200);
      rect(30+menuOffsetX, 30+menuOffsetY, 400 + MaximizeX, 20, 8, 8, 0, 0); // draws the top bar in the windows 
      //checks if mouse is over the X button (which is red ) to turn it red 
      if (mouseX>(400+ MaximizeX)+menuOffsetX&&mouseX<(400+ MaximizeX)+30+menuOffsetX && mouseY > 30 + menuOffsetY && mouseY< 50+menuOffsetY) {
        fill(200, 0, 0);
      } else {
        fill(200);
      }
      rect((400+ MaximizeX)+menuOffsetX, 30+menuOffsetY, 30, 20, 0, 8, 0, 0); //draws the red box that you can't see without hovering over top right

      //checks if mouse is over the maximize button (which is white ) to turn it white and is on the left of the X button
      if (mouseX>(400+ MaximizeX)-30+menuOffsetX&&mouseX<(400+ MaximizeX)+menuOffsetX && mouseY > 30 + menuOffsetY && mouseY< 50+menuOffsetY) {
        fill(225);
      } else {
        fill(200);
      }
      rect((400+ MaximizeX)-30+menuOffsetX, 30+menuOffsetY, 30, 20); // draws the white rectangle
    }




    //buttom task bar
    noStroke();
    fill(255);
    //checks if the mouse is over that task bar to enlarge it or keep it the same
    if (mouseX>width/2-500 && mouseX<width/2+1000 && mouseY >660 && mouseY< 720) {
      rect(width/2-510, height-60, 1020, 60, 5, 5, 0, 0);
    } else {
      rect(width/2-500, height-50, 1000, 50, 5, 5, 0, 0);
    }
    // draws circles as icons in the task bar for looks (while loop :D)
    while (numberOfButtomStuff<5) {
      fill(0, 0, 0, 90);
      ellipse(width/2-297+numberOfButtomStuff*150, height-25, 40, 10);
      numberOfButtomStuff+=1;
    }
    numberOfButtomStuff=0; // resets the while loop
  }

  //shows FPS
  fill(255);
  textSize(15);
  text("FPS"+" "+ int(frameRate), 10, 36);
}

void mouseClicked() {
  // println(mouseX+" "+mouseY);

  //if the watermelon icon is pressed the window opens
  if (mouseX >= 17 && mouseX <= 28 && mouseY>4 && mouseY < 16) {
    if (systemMenu == false) {
      systemMenu = true;
    } else {
      resetMenu(); //if the window is already open it resets it (the size and offset [positioning])
    }
  }
  //if the red button top right of the window will close 
  if (mouseX>(400+ MaximizeX)+menuOffsetX&&mouseX<(400+ MaximizeX)+30+menuOffsetX && mouseY > 30 + menuOffsetY && mouseY< 50+menuOffsetY) {
    resetMenu();
  }
  //if the maximize button or the button beside the close button top right
  if (mouseX>(400+ MaximizeX)-30+menuOffsetX&&mouseX<(400+ MaximizeX)+menuOffsetX && mouseY > 30 + menuOffsetY && mouseY< 50+menuOffsetY) {
    if (MaximumSize == true) {
      revertMaximumSize(); // goes to the function that resets maximum size
      MaximumSize = false;
    } else {
      maximumSize(); // makes the window maximum size
      MaximumSize = true;
    }
  }
  // if the lock is pressed the OS closes
  if (mouseX>1037 && mouseX<1046 && mouseY>4 && mouseY<20) {
    if (shutdown.isPlaying() == false) {
      for (int u=10; u>0; u--) {
        delay(100);
        if (shutdown.isPlaying() == false) {
          shutdown.play();
        }
      }
      exit();
    }
  }
}



void mouseDragged() {
  // if the mouse is dragged while clicking the window position
  if (mouseX>30+menuOffsetX && mouseX< (430+ MaximizeX)+menuOffsetX && mouseY>30+menuOffsetY && mouseY < 50 + menuOffsetY) {
    menuOffsetX = menuOffsetX +(mouseX-pmouseX);
    menuOffsetY = menuOffsetY + (mouseY-pmouseY);
    if (MaximumSize == true || halfSizeLeft == true||halfSizeRight == true) {
      revertMaximumSize(); // resets the size back

      //resets the boolean for what ever was true;
      if (MaximumSize == true) {
        MaximumSize = false;
      } else if (halfSizeLeft == true) {
        halfSizeLeft = false;
      } else if (halfSizeRight == true) {
        halfSizeRight = false;
      }
    }
  }
  // checkes if the window isn't maximized in anyway
  if (MaximumSize == false && halfSizeLeft == false && halfSizeRight == false) {
    if (mouseX>30+menuOffsetX && mouseX< (430+ MaximizeX)+menuOffsetX && mouseY>30+menuOffsetY && mouseY < 50 + menuOffsetY) {
      if (mouseY>20 && mouseY< 24) {
        maximumSize(); //if the mouse goes to the top it makes it full screen 
        MaximumSize = true;
      } else if (mouseX>-5 && mouseX< 5) {
        halfHorizontalSizeLeft(); // if the mouse goes to the left it creates a half screen only on the left
        halfSizeLeft = true;
      } else if (mouseX>=width-5&& mouseX<width+5) {
        halfHorizontalSizeRight(); //if the mouse goes to the right it creates a half screen only on the right
        halfSizeRight = true;
      }
    }
  }
  // if the mouse is dragged on the right side of the window it increases/ decreases the width of the window without changing the y 
  if (mouseX>(430+ MaximizeX)+menuOffsetX- 2 && mouseX<(430+ MaximizeX)+menuOffsetX +2 && mouseY>(30+ MaximizeY)+menuOffsetY&& mouseY<(430+ MaximizeY)+menuOffsetY) {
    if (MaximizeX>-340) {
      MaximizeX = MaximizeX +(mouseX-pmouseX);
    }
  }
  // if the mouse is dragged on the right side of the window it increases/ decreases the length of the window without changing the x (if lucky and place the mouse in the area between both x and y(bottom right corner) both can be changed at the same time) 
  if (mouseX>(30+ MaximizeX)+menuOffsetX && mouseX<(430+ MaximizeX)+menuOffsetX && mouseY>(430+ MaximizeY)+menuOffsetY-2&& mouseY<(430+ MaximizeY)+menuOffsetY+2) {
    if (MaximizeY>-340) {
      MaximizeY = MaximizeY +(mouseY-pmouseY);
    }
  }
}
// custom function to reset the "menu" or window's settings and closes it
void resetMenu() {
  systemMenu = false;
  menuOffsetX =0;
  menuOffsetY =0;
  revertMaximumSize();
  halfSizeLeft = false;
  halfSizeLeft = false;
  MaximumSize = false;
}

// makes the window full size
void maximumSize() {
  menuOffsetX = -30;
  menuOffsetY = -8;
  MaximizeX = 1280-400;
  MaximizeY = height-400;
}
// makes the window clip to the left half size
void halfHorizontalSizeLeft() {
  menuOffsetX = -30;
  menuOffsetY = -8;
  MaximizeX = width/2-400;
  MaximizeY = height-400;
}
// removes the increasing in the size done before
void revertMaximumSize() {
  menuOffsetX = 0;
  menuOffsetY = 0;
  MaximizeX = 0;
  MaximizeY = 0;
}
// makes the window clip on the right side of the screen at half size
void halfHorizontalSizeRight() {
  menuOffsetX = width/2-30;
  menuOffsetY = -8;
  MaximizeX = width/2-400;
  MaximizeY = height-400;
}

// checks the password entered array with the given array to determain if it continues to work or restarts
void checkPassword() {
  if (enteredPassword[0]==systemPassword[0]) {
    if (enteredPassword[1]==systemPassword[1]) {
      if (enteredPassword[2]==systemPassword[2]) {
        if (enteredPassword[3]==systemPassword[3]) {
          //opens the system
          unlock.play(); // plays unlocking sound (got it from iphone on a site "https://freesound.org/people/thegoose09/sounds/125384/")
          computerLock =false; 
          SystemOn = true;
        } else {
          selfDestruct(); //goes to closing the OS function
        }
      } else {
        selfDestruct();//goes to closing the OS function
      }
    } else {
      selfDestruct();//goes to closing the OS function
    }
  } else {
    selfDestruct();//goes to closing the OS function
  }
}

void keyReleased() {
  // it is the code that checks the number given(in keys) and then adds it to the array
  if (computerLock == true) {
    if (enteredPassword.length == 1) {
      if (key == '1') {
        enteredPassword[0] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '2') {
        enteredPassword[0] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '3') {
        enteredPassword[0] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '4') {
        enteredPassword[0] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '5') {
        enteredPassword[0] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '6') {
        enteredPassword[0] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '7') {
        enteredPassword[0] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '8') {
        enteredPassword[0] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '9') {
        enteredPassword[0] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '0') {
        enteredPassword[0] = 0;
        enteredPassword = append(enteredPassword, 0);
      }
    } else if (enteredPassword.length == 2) {
      if (key == '1') {
        enteredPassword[1] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '2') {
        enteredPassword[1] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '3') {
        enteredPassword[1] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '4') {
        enteredPassword[1] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '5') {
        enteredPassword[1] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '6') {
        enteredPassword[1] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '7') {
        enteredPassword[1] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '8') {
        enteredPassword[1] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '9') {
        enteredPassword[1] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '0') {
        enteredPassword[1] = 0;
        enteredPassword = append(enteredPassword, 0);
      }
    } else if (enteredPassword.length == 3) {
      if (key == '1') {
        enteredPassword[2] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '2') {
        enteredPassword[2] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '3') {
        enteredPassword[2] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '4') {
        enteredPassword[2] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '5') {
        enteredPassword[2] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '6') {
        enteredPassword[2] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '7') {
        enteredPassword[2] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '8') {
        enteredPassword[2] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '9') {
        enteredPassword[2] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '0') {
        enteredPassword[2] = 0;
        enteredPassword = append(enteredPassword, 0);
      }
    } else if (enteredPassword.length == 4) {
      if (key == '1') {
        enteredPassword[3] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '2') {
        enteredPassword[3] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '3') {
        enteredPassword[3] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '4') {
        enteredPassword[3] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '5') {
        enteredPassword[3] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '6') {
        enteredPassword[3] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '7') {
        enteredPassword[3] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '8') {
        enteredPassword[3] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '9') {
        enteredPassword[3] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (key == '0') {
        enteredPassword[3] = 0;
        enteredPassword = append(enteredPassword, 0);
      }
    }
  }
}

void mouseReleased() {
  // it is the code that checks the number given(by clicking it with mouse) and then adds it to the array
  if (computerLock == true) {
    buttonPressed.play(); // plays when a button is pressed sound (got it from iphone on a site "https://freesound.org/people/thegoose09/sounds/125384/")
    if (enteredPassword.length == 1) {
      if (mouseX>518 && mouseX<591 && mouseY> 201 && mouseY< 276) {
        enteredPassword[0] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 201 && mouseY< 276) {
        enteredPassword[0] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 201 && mouseY< 276) {
        enteredPassword[0] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 282 && mouseY< 354) {
        enteredPassword[0] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 282 && mouseY< 354) {
        enteredPassword[0] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 282 && mouseY< 354) {
        enteredPassword[0] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 363 && mouseY< 426) {
        enteredPassword[0] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671&& mouseY> 363 && mouseY< 426) {
        enteredPassword[0] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752&& mouseY> 363 && mouseY< 426) {
        enteredPassword[0] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY>441 && mouseY<519) {
        enteredPassword[0] = 0;
        enteredPassword = append(enteredPassword, 0);
      }
    } else if (enteredPassword.length == 2) {
      if (mouseX>518 && mouseX<591 && mouseY> 201 && mouseY< 276) {
        enteredPassword[1] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 201 && mouseY< 276) {
        enteredPassword[1] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 201 && mouseY< 276) {
        enteredPassword[1] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 282 && mouseY< 354) {
        enteredPassword[1] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 282 && mouseY< 354) {
        enteredPassword[1] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 282 && mouseY< 354) {
        enteredPassword[1] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 363 && mouseY< 426) {
        enteredPassword[1] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671&& mouseY> 363 && mouseY< 426) {
        enteredPassword[1] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752&& mouseY> 363 && mouseY< 426) {
        enteredPassword[1] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY>441 && mouseY<519) {
        enteredPassword[1] = 0;
        enteredPassword = append(enteredPassword, 1);
      }
    } else if (enteredPassword.length == 3) {
      if (mouseX>518 && mouseX<591 && mouseY> 201 && mouseY< 276) {
        enteredPassword[2] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 201 && mouseY< 276) {
        enteredPassword[2] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 201 && mouseY< 276) {
        enteredPassword[2] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 282 && mouseY< 354) {
        enteredPassword[2] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 282 && mouseY< 354) {
        enteredPassword[2] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 282 && mouseY< 354) {
        enteredPassword[2] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 363 && mouseY< 426) {
        enteredPassword[2] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671&& mouseY> 363 && mouseY< 426) {
        enteredPassword[2] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752&& mouseY> 363 && mouseY< 426) {
        enteredPassword[2] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY>441 && mouseY<519) {
        enteredPassword[2] = 0;
        enteredPassword = append(enteredPassword, 2);
      }
    } else if (enteredPassword.length == 4) {
      if (mouseX>518 && mouseX<591 && mouseY> 201 && mouseY< 276) {
        enteredPassword[3] = 1;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 201 && mouseY< 276) {
        enteredPassword[3] = 2;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 201 && mouseY< 276) {
        enteredPassword[3] = 3;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 282 && mouseY< 354) {
        enteredPassword[3] = 4;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY> 282 && mouseY< 354) {
        enteredPassword[3] = 5;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752 && mouseY> 282 && mouseY< 354) {
        enteredPassword[3] = 6;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>518 && mouseX<591 && mouseY> 363 && mouseY< 426) {
        enteredPassword[3] = 7;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671&& mouseY> 363 && mouseY< 426) {
        enteredPassword[3] = 8;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>678 && mouseX<752&& mouseY> 363 && mouseY< 426) {
        enteredPassword[3] = 9;
        enteredPassword = append(enteredPassword, 0);
      } else if (mouseX>598 && mouseX<671 && mouseY>441 && mouseY<519) {
        enteredPassword[3] = 0;
        enteredPassword = append(enteredPassword, 0);
      }
    }
  }
}
Boolean selfDestructText = false; //adds a boolean its here because it is possible to have it here :D

void selfDestruct() {
  //adds a 100 ms delay
  delay(100);
  //writes self destruct on the screen of the password
  selfDestructText = true;
}
