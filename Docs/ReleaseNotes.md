[parm]:saveHTML = 0 

# Release Notes 7.3.0

* Performance improvement for hit reports and replace previews: twice as fast. 
  For large reports that makes a significant difference.
* In case the user attempts to replace a string in a function or operator that lives in a scripted 
  namespace that itself lives in a scripted namespace Fire cannot fix the changed code. 

  That is due to a bug (?!) in Dyalog reported in 2019-08. Fire now tells the user about this rather 
  than changing the actual code in the workspace (sic!) but not the script as   such.
* Bug fixes:
  * When the search list is re-used no clones and duplicates must be removed from the hit list.
  * With regular expressions, the hit report might have reported hits in code twice: as part of a
    fn/op and as part of the script as such.
  * Re-using the hit list showed wrong results under some complex circumstances.
  * Scanning a scripted namespace with a dfn that called itself via `∇` might show wrong results.
  * Replacing a single line dfn in a script run into a VALUE ERROR (introduced recently).
  * The "No hits" dialog box failed to show the search string.
  * The hit report was always wrong on simple text vectors: The whole variable was shown as a hit.
* User command script simplified
* Installer now shows always the installation folder
* Files removed not needed by a user command: bridge DLL and dot net DLL.