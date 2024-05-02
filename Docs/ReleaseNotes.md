[parm]:saveHTML = 0
[parm]:title    = 'Fire Release Notes'



# Release Notes 

Note that with version 9.0.0 Fire started using the concept of semantic versioning ([SemVer](https://semver.org "Link to the document that introduced SemVer")).

In short this means that a bump of the major version number indicates a breaking change. For example, 9.* does not run on versions of Dyalog older than 18.0.

A bump of the minor number indicates added functionality plus possibly bug fixes.

A bump of the patch number indicates bug fixes.

## Version 9.6.4 from 2024-05-02

* Bug fix: when a function or a script was renamed implicitly via a "Replace" operation, Link/acre were given the old name rather than the new one, effectively loosing the change when the WS was destroyed one way or the other.

## Version 9.6.3 from 2024-04-04

* Bug fixes
  * "Search QNL" corrected: `#` cannot be a hot key
  * Interpretation of `[HOME]` was sometimes wrong, resulting in not finding the release notes

## Version 9.6.2 from 2023-10-09

 * Version number corrected: patch number and build if were wrong)

## Version 9.6.1 from 2023-10-09

* If SALT's `cmddir` parameter carried a symbolic name as in `[HOME]MyUCMDs` then Fire did not find its documents.

* The menu item "Reports > Search in QNL" did not declare F7 as its hot key although the key worked

## Version 9.6.0 from 2023-09-11

* The "Search [ ]NL" report now allows to start a search in either `#` or in `⎕SE`.

## Version 9.5.2 from 2023-03-25

Bug fix: people who do not tick "Options > Object Syntax > Expose GUI Properties" could not use "Replace"

## Version 9.5.1 from 2023-03-12

* Bug fix in `ListNamespaceTree_`
* Bug fix in `GUI.LetLinkDelete`
* "Start looking here" offered `#._tatin` or `⎕SE._tatin` etc even if "Ignore Tatin packages" was ticked


## Version 9.5.0 from 2023-02-06

* Search operation is now much quicker under some cirumstances

## Version 9.4.4 from 2022-12-15

* One-by-one replacements with RegEx crashed
* Fire still required acre to be around under some circumstances.

## Version 9.4.3 from 2022-12-13

* Fire does **not** attempt anymore to load acre into `⎕SE`. However, Fire still makes use of acre when it's around, it just does not attempt to load it anymore.

* Bug fix: the context menu of the left pane in the "Hit" report offered "Print name to session" (which worked) but also pretended that F4 would do the same but it did not.

## Version 9.4.2 from 2022-11-08

* Fire did not run under 18.0 by mistake

## Version 9.4.1 from 2022-09-23

* Fire's "Make" copied the packages twice

## Version 9.4.0 from 2022-09-11

* The "References" report now offers to ignore Tatin packages. Also, the name class is now reported for both the source and the target which allows a better understanding of anomalies.

* Bug fixes:
  * Searching for a RegEx and then replacing hits with a multi-line replace string did not work
  * When the special syntax `]Fire .` was used while a function was on the stack that came from a class instance
    then the setting of "Start looking here" was both wrong and invalid
  * Under certain (and rare) circumstances closing the "Replace" dialog box resulted in a VALUE ERROR
  * Resizing the "Remove all objects from namespace... from list" dialog box resulted in a stream of VALUE ERRORs 
    on a missing `OnConfiguration` handler
  * In the "References" report the message regarding anomalies always reported a wrong line number

## Version 9.3.0 from 2021-12-14

* Because of the danger involved Fire's "Replace" now refuses to act in case there are threads running.
* Bug fixes
  * In case a function needs to be deleted as a result of "Delete lines with hits" (when no code it left) Link was not informed.
  * In case of hits in `#` the very first one was not reported.

## Version 9.2.1 from 2021-10-24

* "Case sensitive" in the ""Search QNL" report" did not work.

## Version 9.2.0 from 2021-10-03

* Fire now supports Link. This means that...
  * for any changes `⎕SE.Link.Add` is called
  * for any deletions `⎕SE.Link.Expunge` is called

  However, note that Fire requires at least Link 3.0.0. If only an older version can be found warnings are printed to the session.

* acre is no longer mentioned, but Fire is still calling `⎕SE.acre.SetChanged` if acre is around. 

## Version 9.1.3 from 2021-04-30

* Fire does not leave behind orphaned refs anymore. Important because that may cause a performance penalty
* Attempt to change something in a scripted namespaces that is embedded in a scripted namespace causes a "Not supported by design" warning now.

## Version 9.1.2 from 2021-04-18

* `ReportHits.MarkUpAllHits` was buggy


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








