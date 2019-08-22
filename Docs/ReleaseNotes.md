[parm]:saveHTML = 0 

# Release Notes 7.4.0

* Now compatibale with acre 6.0
* Bug fixes
  * In case of a change of a nested script acre was informed about a change but there is no change. This
    bug causes no harm, the call is just superfluous and the message in the session confusing.
  * When executed via the user command script Fire forgot all search phrases after a restart.
  * When a function was edited from the "Hit" report the search box was not properly populated.