[parm]:saveHTML = 0 

# Release Notes 7.5.0

* The "Detailed hits" report now removes everything from the Preview pane that was removed 
  from the hit list by the user, be it with the <DEL> key or via the context menu.

* The "Replace one-by-one" dialog now has a "Fix this and all remaining objects" button.

* The "Replace-one-by-one" dialog now starts with check boxes unticked. It therefore initially 
  shows what has been searched for rather than the result after the replace.

* The TreeView on the "Replace-one-by-one" dialog now supports Ctrl+A (for ticking all check boxes)
  and Ctrl+N (for un-ticking all check boxes).

* The "Replace-one-by-one" list has now a context menu ("Select all" & "Deselect all")

* Bug fixes:
  * The "Replace one-by-one" dialog moved down by the height of the menubar with every object.
  * The report in the statusbar of the "Replace one-by-one" was sometimes mutilated.
  * The "Skip" button in the "Replace one-by-one" dialog was active even when there were no more objects to be processed.

* Internally: new test framework `Tester2` is now used.