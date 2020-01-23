[parm]:saveHTML = 0
[parm]:title    = 'Fire Release Notes'


# Release Notes 8.0.3
* Some of Fire's methods left behind temp files that could and should have been deleted.

# Release Notes 8.0.2
* Bug fixes (introduced with version 8.0
  * The `]fire .` syntax has stopped working
  * Part of the Fire API did not work in 16.0

# Release Notes 8.0.1

* Now the user command checks whether the minimum requirementa (Dyalog Version) are met.
  In the past an attempt to use Fire from a version that was too old resulted in an error message:
  
  "Command Execution Failed: \*\*\* Problem collecting modules required by Fire:"