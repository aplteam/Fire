[parm]:saveHTML = 0 

# Release Notes 8.0.0

* Fire now offers an API in order to search strings programmatically.

  All methods are available via `⎕SE._Fire.Fire.API`.

  There is also a new flag available for loading Fire into `⎕SE` without 
  actually running it: `]Fire -noGUI`

* Bug fixes
  * In case of a RegEx search-and-replace operation both the search string and the replace 
    string were shown in the "One-by-one" GUI in case of a variable.
  * The position of the GUI should have been remembered during a session but was not.
  * References should have been ignored but sometimes weren't.
  * The "References" report did occasionally report stuff that was not a reference at all.
  * The "References" report reported references to unnamed namespaces.
  * Some Tips for menu items persisted even after selecting a different menu item.
  * Some Tips for menu items were mutilated.
  * Some Tips for menu items provided outdated information