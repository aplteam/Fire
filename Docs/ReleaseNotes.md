[parm]:saveHTML = 0 

# Release Notes 7.2.2
* When an object was removed from the hit list then the message in the status bar was not changed accordingly.
* When an object was removed from the hit via "Report Hits" then the context menu should not offer "Remove" again.
* A "Hit report" windows should be closed automatically when the user hits either "Find" or "Replace".
* A "Replace" operation should clear the hit list because it might well be outdated.
* Information provided in the status bar improved.

# Release Notes 7.2.1

The combo box "Search for" did not carry the search terms any more from earlier searches.

# Release Notes 7.2

This release changes the way Fire processes references pointing to namespaces.

Before 7.2 when the search was restricted to a particular namespace then if that namespace contained references pointing elsewhere they would be listedm assuming they carried a hit.

That is almost never what you want to happen: the purpose to restrict the search to a particular namespace is to ignore stuff that lives elsewhere. From now on that's what Fire does. 

Note that this does not affect the result of the search list when you do **not** restrict the search to a particular namespace. So Fire's behaviour does not change when "Start looking here:" contains either `#` or `⎕SE`.