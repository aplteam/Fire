# Fire


![Logo](Images/fire.png) Fire stands for FInd and REplace. It's designed to search and replace strings in the workspace.


## Features

Fire's main feature is the "Replace" command which allows you in an easy yet powerful way to replace certain strings in all or selected objects in the workspace.

Other features are:

* You can search either the workspace or just the list of names (`⎕NL`).

* You can search any combination of...

  * comments
  * text 
  * APL source code (that's everything but comments and the stuff between quotes (text).

* Negate a search ("all objects that do **not** contain...").

* Search only the hits of the last search. 


## Difference between Dyalog's built-in search tool and Fire

* Fire handles circular references correctly (thanks to Phil Last)

* Fire reports a WS FULL only when it is reasonable to do so 


## Fire's GUI


### Main Window

![](Images/Fire_01.png)

Specifying anything in the "Start looking here" control is supported by autocomplete: this box offers all ordinary namespaces matching the characters in "Start looking here".

![](Images/Fire_02.png)

After having performed a search one might want to check the hits. This can be achieved by selecting the "Report hits" menu command from the "Report" menu or by pressing F2:


![](Images/HitReport.png)

The report offers a context menu on the items in the left pane:

![](Images/ReportHitsContextMenu.png)


### The "Replace" feature

The "Replace" feature allows you to change the workspace on a global level:

![](Images/Replace.png)

There are two modes available:

* "All in one go" allows you to check all changes in a single document before actually committing the changes.
* "One-by-one" allows you to compare and edit one object after the other, and commit changes independently from each other.


#### "All in one go" mode

When you select the "Preview" button you get this:

![](Images/Batch_02.png)

This allows you to check whether everything is okay or not. In this example the second object is excluded from the replace.

This is the second and last step:

![](Images/Batch_03.png)


#### One by one

In one-by-one mode every object is shown on its own. You can skip an object entirely or accept some or all of the changes. 

![](Images/OneByOne_01.png)

Unticking a check box brings back the original text which is "Hello" in this example.