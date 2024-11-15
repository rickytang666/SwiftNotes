// This file is for the functions of a user

void createNote(String title) 
{
    Note n = new Note(title);
    notes.add(n);
    currentNote = notes.get(notes.size()-1);
    
}


void saveNotes() 
{
  PrintWriter pw = createWriter(filePath);

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


void importNotes()
{
  String[] lines = loadStrings(filePath);
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

      notes.add(note);
    }
  }
  
  if (notes.isEmpty())
    println("monkey");
  else
  {
    currentNote = notes.get(0);
  }
}


void updateGoldCoins() {
  for(int i = 0; i < notes.size(); i++){
    Note x = notes.get(i);
    x.updateWordNum();
    int coinsAdded = x.wordNum / 20;
    goldCoins += coinsAdded;
  }
}


/*******************************/


void scrollUp()
{
  if (scrolledDist < 0)
  {
    scrolledDist += buttonHeight;
    updateSidebar();
  }
}


void scrollDown()
{
  int maxY = buttonsUpBound + scrolledDist + (note.size() - 1) * buttonHeight;

  if ( maxY > height - buttonHeight) 
  {
    scrolledDist -= buttonHeight;
    updateSidebar();
  }
}


void scrollBottom()
{
  int maxY = buttonsUpBound + scrolledDist + (note.size() - 1) * buttonHeight;

  if ( maxY > height - buttonHeight)
  {
    scrolledDist -= (maxY - (height - buttonHeight));
    updateSidebar();
  }
}



void scrollTop()
{
  scrolledDist = 0;
  updateSidebar();
}


void updateSidebar() 
{
  // Clear previous buttons to avoid duplicates
  for (GButton button : noteButtons) {
    button.dispose();
  }
  noteButtons.clear();
  
  // Only add visible notes, considering the scroll distance
  for (int i = 0; i < notes.size(); i++) 
  {
    int yPos = buttonsUpBound + scrolledDist + i * buttonHeight;
    Boolean visible = false;
    
    if (yPos >= buttonsUpBound && yPos <= height - buttonHeight) {
      visible = true;
    }
    
    GButton newButton = new GButton(this, 10, yPos, 150, buttonHeight - 10);
    newButton.setText(notes.get(i).title);
    newButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
    newButton.addEventHandler(this, "noteButton_clicked");
    newButton.setVisible(visible);
    noteButtons.add(newButton);
  }
  
  
  for (GButton button : noteButtons) {
    sidebarPanel.addControl(button);
  }
}



