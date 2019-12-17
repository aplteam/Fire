[parm]:saveHTML = 0 

# Release Notes 7.6.0

* Both TABs removed. Search is now always a "workspace search".
* There is a new menu command "Search ⎕NL".
* The display of large variables in the "Replace" preview was confusing.
  Carries a horizontal ruler now in order to separate old and new.
* When the "Replace" dialog was cancelled without actually doing a replace the hit list was not reset.
* Functions are not any longer compiled with 400⌶ as this has proven to add some stability problems.
* In the "Replace one-by-one" dialog the check boxes are again ticked from the start. Was a bad idea.
* Bug fixes:
  * "Replace one-by-one" had problems with variables of any kind.
  * "Replace one-by-one" did not use the "APL385 Unicode" font under some circumstances.
  * The HTML special chars "<>&" were displayed incorrectly in non-simple variables.
  * Simple variables with CR and/or LF within the text were not displayed correctly.
  * Under rare circumstances the "Replace" preview showed nonsense.
  * The "Browse" context menu command in the "Replace Preview" did not display all variables properly.
  * Removing objects from the hit list automatically as part of any "Replace" operation caused later
    a LENGTH ERROR when one attempted to delete something from the hit list with the DEL key.
  * Fire created a new temp file for the icon every time it was started. Now it creates the file
    once in case it does not exist yet, and reuses it when it's already there.
  * The "Replace one-by-one" left a tied component file behind.
  * The "Delete lines with hits" options crashed on namespace scripts as well as class scripts that
    carried leading comments.