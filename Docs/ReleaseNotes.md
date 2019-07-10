[parm]:saveHTML = 0 

# Release Notes 7.2

This release changes the way Fire processes references pointing to namespaces.

Before 7.2 when the search was restricted to a particular namespace then if that namespace contained references pointing elsewhere they would be listedm assuming they carried a hit.

That is almost never what you want to happen: the purpose to restrict the search to a particular namespace is to ignore stuff that lives elsewhere. From now on that's what Fire does. 

Note that this does not affect the result of the search list when you do **not** restrict the search to a particular namespace. So Fire's behaviour does not change when "Start looking here:" contains either `#` or `⎕SE`.