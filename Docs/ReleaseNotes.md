[parm]:saveHTML = 0
[parm]:title    = 'Fire Release Notes'

# Release Notes 

Note that with version 9.0.0 Fire started using the concept of semantic versioning ([SemVer](https://semver.org "Link to the document that introduced SemVer")).

In short this means that a bump of the major version number indicates a breaking change. For example, 9.* does not run on versions of Dyalog older than 18.0.

## Version 9.1.1 from 2021-04-17

* Replace with one-by-one did not work

## Version 9.1.0 from 2021-04-07

* New parameter "StartSearchIn" introduced for searching `⎕NL` (`CreateParmsFor_QNL_Search`) that defaults to `#` but
  can also be `⎕SE`.
* Bug fixes
  * In case "searchFor" was specified as a parameter via the left argument of `SearchQNL` this was overwritten 
    by the right argument, even in case this was empty.
  * Fire 9 did not run under Dyalog 18.1

## Version 9.0.1 from 2021-04-05

* Bug fix: There was a problem with the Fire icon. It hit only on PCs were Fire has never been installed before.

## Version 9.0.0

* **Breaking changes**
  * Requires at least Dyalog 18.0 Unicode .
  * Requires Tatin to be installed.
* Two new functions added to the API: 
  * `SearchQNL` 
  * `CreateParmsFor_QNL_Search`.
* New option "Ignore references" defaults to 1.
* New option "Ignore Tat packages" defaults to 1.
* Messages in the status bar are now explicitly mentioning whether the hit list was searched.
* When a search of the current hit list yields no results the "Search hit list" button is un-ticked and the
  "Search in" field is made available.
* The API is now (also) availbale from `⎕SE.Fire`
* Bug fixes:
  * Attempts to remove variables from the hit report failed.
  * In the hit list, moving the selection with the keyboard did not update the right pane accordingly.
  * Ctrl+A in the hit report did not select all items.
  * Removing an item from the hit list did not remove it from the HTML.
  * "Remove from hit report" could result in a WS FULL in case of a very large hit list.
  * When in the "Start looking here" field a space was entered Fire got confused; it should not be possible to 
    enter a space since it makes no sense in this field.
  * It was possible to enter a dot in the "Start looking here" field even if there weren't any sub-namespaces
    available. That should be prevented.
  * The replace preview failed to show anything sensible when the replace string referred to groups.
  * When after a search for an RegEx a one-by-one replace operation was triggered Fire might produce a VALUE ERRROR.
  * In the "Replace" dialog the "Delete lines" options should not be available (active) when it is a RegEx search.
  * The `∆List` function created by `Fire.API.CreateSearchParms` was buggy.
* Internal change: all calls to acre via ⎕SE.UCMDS have now been replaced by calls to acre's API.