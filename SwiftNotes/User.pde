// This file is for the functions of a user

//Creates a new note tab everytime the user adds one
void createNote(String title) 
{
    Note n = new Note(title);
    notes.add(n);
    currentNote = notes.get(notes.size()-1);
    
    saveNotes();
}

//Autosaves the user's notes to ensure the user doesn't lose them
void saveNotes() 
{
  PrintWriter pw = createWriter(noteStoragePath);

  for (Note n : notes)
  {
    pw.println(n.title);
    pw.println(n.createdTime);
    pw.println(n.text);
    pw.println(separate);
  }

  pw.flush();
  pw.close();
  
  //println("saved");
}

//Loads the notes that the user has saved after opening the program
void importNotes()
{
  String[] lines = loadStrings(noteStoragePath);
  for (int i = 0; i < lines.length; ++i)
  {
    if (lines[i].equals(separate))
    {
      String title = lines[i - 3];
      String time = lines[i - 2];
      String content = lines[i - 1];

      Note note = new Note(title);
      note.createdTime = time;
      note.text = content;
      note.updateWordNum();

      notes.add(note);
    }
  }
  
  if (notes.isEmpty())
    println("The notes are empty");
  else
  {
    currentNote = notes.get(0);
  }
}

//Updates the amount of gold coins that the user has received
void updateGoldCoins() {
  
  int num = 0;
  
  for(int i = 0; i < notes.size(); i++){
    Note x = notes.get(i);
    x.updateWordNum();
    num += x.wordNum;
    
  }
  
  goldCoins = floor(num / 5);
}

//Loads the user's previously set settings (Font, Font size, Dark mode) as well as their gold coins
void importUserData()
{
  String[] lines = loadStrings(userStoragePath);
  
  if (lines == null)
  {
    return;
  }
  
  goldCoins = int(lines[0]);
  noteFontStr = lines[1];
  fontSize = constrain(int(lines[2]), minSize, maxSize);
  mode.setMode(lines[3].equals("true") ? true : false);
}

//Loads the user's previously set password to use to open the program
void importPassword()
{
  String[] lines = loadStrings(passwordStoragePath);
  
  if (lines == null || lines.length < 1 || lines[0].length() < 3)
  {
    firstTime = true;
    notes.clear();
    goldCoins = 0;
  }
  else
  {
    firstTime = false;
    password = lines[0];
  }
}

//Autosaves the user's settings
void saveUserData()
{
  PrintWriter pw = createWriter(userStoragePath);
  
  pw.println(goldCoins);
  pw.println(noteFontStr);
  pw.println(fontSize);
  pw.println((mode.isDarkMode) ? "true" : "false");
  
  pw.flush();
  pw.close();
}

//Stores the user's new password whenever they set it
void storePassword()
{
  PrintWriter pw = createWriter(passwordStoragePath);
  
  pw.println(password);
  
  pw.flush();
  pw.close();
}


/*******************************/

//Scrolls up the panel
void scrollUp()
{
  if (scrolledDist < 0)
  {
    scrolledDist += buttonHeight;
    updateSidebar();
  }
}

//Scrolls down the panel
void scrollDown()
{
  int maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;

  if ( maxY > height - buttonHeight - paddingDown) 
  {
    scrolledDist -= buttonHeight;
    updateSidebar();
  }
}

//Scrolls all the way to the bottom of the panel
void scrollBottom()
{
  int maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;

  while (maxY > height - buttonHeight - paddingDown)
  {  
    scrolledDist -= buttonHeight;
    maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;
  }

  updateSidebar();
}


//Scrolls all the way to the top of the panel
void scrollTop()
{
  scrolledDist = 0;
  updateSidebar();
}

//Updates the panel to include new or removed note tabs
void updateSidebar() 
{
  // Clear previous buttons to avoid duplicates

  for (GButton button : noteButtons) 
  {
    if (button != null)
    {
      button.dispose();
    }
  }
  noteButtons.clear();

  for (GImageButton button : delButtons) 
  {
    if (button != null)
    {
      button.dispose();
    }
  }

  delButtons.clear();
  
  // Only add visible notes, considering the scroll distance

  for (int i = 0; i < notes.size(); i++) 
  {
    int yPos = buttonsUpBound + scrolledDist + i * buttonHeight;
    Boolean visible = false;
    
    if (yPos >= buttonsUpBound && yPos <= height - buttonHeight - paddingDown) {
      visible = true;
    }
    
    GButton noteBtn = new GButton(this, 10, yPos, buttonWidth, buttonHeight - 10);
    
    String str = notes.get(i).title.length() > 25 ? notes.get(i).title.substring(0, 23) + "..." : notes.get(i).title;
    noteBtn.setText(str);
    noteBtn.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    noteBtn.setLocalColor(2, color(0));
    noteBtn.addEventHandler(this, "noteButton_clicked");
    noteBtn.setVisible(visible);
    noteBtn.setFont(UIFont);
    noteButtons.add(noteBtn);

    GImageButton delBtn = new GImageButton(this, buttonWidth + 20, yPos, buttonHeight - 10, buttonHeight - 10, new String[]{"Delete Button 1.png", "Delete Button 2.png"});
    delBtn.addEventHandler(this, "delButton_clicked");
    delBtn.setVisible(visible);
    delButtons.add(delBtn);
  }
  
  
  for (GButton button : noteButtons) {
    sidebarPanel.addControl(button);
  }

  for (GImageButton button : delButtons) {
    sidebarPanel.addControl(button);
  }
}


//Sets the primary colour accents of the program
void setColorsMain()
{
  
  sidebarPanel.setLocalColor(5, mode.panelBG);
  sidebarPanel.setLocalColor(1, color(255, 165, 0));

  textfield1.setLocalColor(7, mode.textBG);
  textfield1.setLocalColor(12, mode.foreground);
  textfield1.setLocalColor(2, mode.foreground);
  
  textarea1.setLocalColor(7, mode.textBG);
  textarea1.setLocalColor(12, mode.foreground);
  textarea1.setLocalColor(2, mode.foreground);

  
}

//Sets the secondary colour accents of the program
void setColors2()
{
  modeToggle.setLocalColor(2, mode.foreground);
  
  input.setLocalColor(7, mode.textBG);
  input.setLocalColor(12, mode.foreground);
  input.setLocalColor(2, mode.foreground);
  
  confirm.setLocalColor(7, mode.textBG);
  confirm.setLocalColor(12, mode.foreground);
  confirm.setLocalColor(2, mode.foreground);
  
  
  inputLabel.setLocalColor(2, mode.foreground);
  confirmLabel.setLocalColor(2, mode.foreground);
  warning.setLocalColor(2, mode.foreground);
  
}

//Initializes the main beginner font of the program
void initializeUIFont()
{
  UIFont = new Font("Inter", Font.PLAIN, 17);
}

//Updates the fonts that the user has set from the settings menu
void updateFont()
{
  noteFont = new Font(noteFontStr, Font.PLAIN, fontSize);
  
  textfield1.setFont(noteFont);
  textarea1.setFont(noteFont);

  
}
