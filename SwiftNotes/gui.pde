/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void textarea1_changed(GTextArea source, GEvent event) { //_CODE_:textarea1:266170:
  if (currentNote != null)
  {
    currentNote.text = textarea1.getText();
  }
  
  saveNotes();
} //_CODE_:textarea1:266170:

public void dropList1_clicked(GDropList source, GEvent event) { //_CODE_:dropList1:310236:
  int index = source.getSelectedIndex();
  if (index >= 0 && index < notes.size()) 
  {
    currentNote = notes.get(index);
    textarea1.setText(currentNote.text);
  }
} //_CODE_:dropList1:310236:

public void addButton_clicked(GButton source, GEvent event) { //_CODE_:addButton:563243:
  createNote(generateUniqueTitle());
  textarea1.setVisible(true);
  textarea1.setText("");
} //_CODE_:addButton:563243:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  textarea1 = new GTextArea(this, 255, 130, 667, 487, G4P.SCROLLBARS_BOTH);
  textarea1.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  textarea1.setOpaque(true);
  textarea1.addEventHandler(this, "textarea1_changed");
  textarea1.setText("");
  textarea1.setVisible(false);
  dropList1 = new GDropList(this, 31, 129, 157, 120, 5, 10);
  dropList1.setItems(noteTitles, 0);
  dropList1.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  dropList1.addEventHandler(this, "dropList1_clicked");
  addButton = new GButton(this, 515, 53, 80, 30);
  addButton.setText("Add Note");
  addButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  addButton.addEventHandler(this, "addButton_clicked");
}

// Variable declarations 
// autogenerated do not edit
GTextArea textarea1; 
GDropList dropList1; 
GButton addButton; 
