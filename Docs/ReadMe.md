[parm]:toc            = 3
[parm]:numberHeaders  = 2 3 4
[parm]:collapsibleTOC = 1
[parm]:saveHTML       = 0 


# Fire

Note that FiRe stands for FInd and REplace. Fire is a Windows0only application.


## Features

Fire has a couple of features that Dyalog's built-in "Search" tool do not offer. These are the main features:

* Most importantly, a global "Replace".

  This feature is particularly powerful since it allows you to inspect every single item that is going to be changed in a preview, and to exclude objects with a single click.

* The scope of a search can be restricted to just code while comments or even text will be ignored. Or you search just in comments, or just in text, or just in the name list (`⎕NL`).

* A search result can become the source of another search.

* Regular Expressions can be used for both "Search" as well as "Replace".

Fire has however many more features:

* The "Start search in" control remembers the last 30 entries per workspace and user.

* The "Start looking here" control offers auto-completion.

* One can negate a search: all which do _not_ contain ... 

  In conjunction with "Search hit list" this can effectively be used to exclude unwanted stuff before triggering a "Replace".

* Built-in reports designed to help refurbishing code that has started to smell.


## Fire to the rescue

Fire also overcomes a couple of problems that Dyalog's built-in Search tool is suffering from.

* It handles circular references well thanks to Phil Last.

* It is less likely to generate a WS FULL.

* It supports regular expressions (`⎕R`/`⎕S`). (Dyalog supports this partly since version 16.0)


## Installing Fire

Since version 7.1.0 Fire comes with its own installer. Just double-click it and your are done. It does not require admin rights.

The installer installs Fire into `%USERPROFILE%\Documents\MyUCMDs` which translates to `C:\Users\{userid}\Documents\MyUCMDs` with a default Windows installation. This folder, if it exists, is scanned by Dyalog for user commands.

However, if you have used Fire before version 7.1 then you might have installed it somewhere different. If this is the case then your are advised to remove Fire from that folder before running the installer.

Note that installing into `%USERPROFILE%` means that you have to install it separately for every user who wants to use Fire.

## Running Fire

After having installed Fire you can start it by executing:

~~~
]Fire
~~~

The User Command checks whether Fire is already available in `⎕SE`. If that is not the case then it is copied into `⎕SE`. From now on it is started directly from `⎕SE` which you might find significantly faster than loading it into `⎕SE` first depending on where Fire is copied from in your environment.

Of course you can make that change persistent by saving your session. However, when a new version of Fire comes along you need a way to load this new version. This can be achieved by specifying an optional parameter:

~~~
]Fire -fl
~~~

"fl" stands for "force load". This loads Fire into `⎕SE` no matter whether it's already there or not.


## What Fire scans

1. Named namespaces
1. Scripts
1. Functions and operators
1. GUI instances which have `KeepOnClose←1`


## What Fire does not scan

1. Unnamed namespaces.
1. Class instances.
1. GUI instances which have `KeepOnClose←0`.
1. Ghostly namespaces.
1. References


## Ghostly namespaces

Note that Fire does not search ghostly namespaces. These are namespaces which exist together with GUI objects as well as classes. If you did not know about ghostly namespaces then it might be best to ignore them: they can be quite confusing. 

Ghostly namespaces exist for a very long time but until OO was introduced to Dyalog APL they were kept hidden from users.

If you would like to know more then consider this code:

~~~
      ⎕fix ':Class Test' ':EndClass'
      Test.⎕FX'r←Hello' 'r←''World'''
      Test.Hello
World
~~~      

If you are under the impression that you've created a method "Hello" in the class "Test" then you are wrong: that cannot work because the function "Hello" does not carry an "Access Public" statement, so it wouldn't be possible to call the method as a class member anyway.

The same is true for this:

~~~
      #.Test.⎕IO←0
~~~
      
This statement does not throw an error, so somehow it was successful. Referencing works as well:

~~~
      #.Test.⎕IO
1
~~~
However, `⎕IO` **must** be a private property of the class, so it can **never** be set or even referenced directly: you cannot specify anywhere an "Access Public" statement for `⎕IO`.

But since we managed to execute these statements successfully (`⎕FX 'Hello'` and `⎕IO←0`) the question is where they have been executed. Well, in the ghostly namespace which exists together with the class script, sharing the same name. 

Even if Fire would show the function `Hello` in the hit list there is another anomaly: executing `Test.⎕ed 'Hello'` doesn't allow you to edit it. That means that Fire does not have the means to allow you editing the code.

The final obstacle: making a change to the class `Test` will make `Hello` disappear because the ghostly namespace will be re-created when the class is (re-) fixed.

Therefore it seems to be best to ignore ghostly namespaces altogether.


### GUI objects and ghostly namespaces

Investigate this code:

~~~
      'MyForm' ⎕WC 'Form' ('KeepOnClose' 1)
      MyForm.⎕FX'r←Hello' 'r←''World'''
~~~
      
Note that strictly speaking this is the same thing: There is a GUI object called "MyForm" but there is also a ghostly namespace holding the "Hello" function. However, Dyalog APL perfectly keeps that as a secret: it has always been that way since GUI objects were introduced into Dyalog APL a long time ago, yet nobody ever realized this because Dyalog APL behaved in a way that makes that actually impossible.


### Semi-ghostly namespaces

Note that this code:

~~~
      ⎕FIX':Namespace MyNS' ':EndNamespace'
      MyNS.⎕FX'r←Hello' 'r←''World'''
~~~      

has consequences that make it look as if a ghostly namespace is involved when actually there isn't. Look at this:

~~~
      MyNS.Hello
World
      ⎕←⍪MyNS.⎕SRC MyNS
 :Namespace MyNS  
 :EndNamespace 
~~~

You can execute "Hello" but it's not part of the script - looks like a ghostly namespace is involved, right?! 

Well, it's not. By definition a namespace script can only be changed by editing the script. Therefore the `⎕FX` statement did actually add the function "Hello" to the namespace but not to the namespace script. In other words, the script and the namespace are now out of sync.

According to Dyalog this is not a bug but a feature.

BTW, this:

~~~
      ⎕FIX ':Namespace MyNS' '∇r←Hello2' 'r←''1 2 3''' '∇' ':EndNamespace'
      MyNS.Hello2
1 2 3
      MyNS.⎕EX 'Hello2'
      MyNS.Hello2
VALUE ERROR
      MyNS.Hello2
     ∧
~~~
     
has a similar effect: the `⎕EX` statement did actually remove the `Hello2` function from the namespace but not from the script. 

Note that Fire investigates the script rather than the namespace. `Hello2` therefore would not pop up in Fire because it's not part of the script. If you find this confusing - so do I.

If you now think: "Hang on, if `⎕FX` does not change a script at all, then surely a "Replace" operation with Fire must fail, right?" then luckily you would be wrong: Fire is smart enough to recognize the situation and manipulates - and finally fixes - the script rather than individual functions.

By the way, if for any reason you want to know whether there is code somewhere in a ghostly namespace then you can achieve this by executing the "Report ghosts" command from the "Reports" menu. 

Note that code that exists in a ghostly namespace associated with an external object (Like an Excel workbook) is not reported; Fire cares about APL objects only.

## Deleting stuff

The "Replace" dialog has a check box "Delete lines/items with hits". That seems to be easy enough: any lines that carry the search string are going to be deleted. However, there are details you need to be aware of:

1. The first and the last line of any script is never deleted, no matter whether they carry a hit or not. It should be obvious why that is.

1. The first line of any function or operator is never deleted, no matter whether they carry a hit or not. However, be aware of 6.

1. If a simple variable carries a hit it is going to be an empty vector.

1. All items in a vector of text vectors that carry a hit are deleted from that vector. That means that after the conversion the new vector will be shorter than the original one.

1. A one-line dfns that carries a hit is deleted.

1. A tfns that carries hits on all its lines is deleted.


## Tips and Tricks


Fire does not execute either `⎕DQ` or `Wait` on its main GUI. That allows one to move the focus to the session by pressing <Ctrl+Tab> in Fire. Sadly there is no way to move the focus back to Fire without the mouse.

Avoiding `⎕DQ` works well in many circumstances but it might cause problems when other threads are running. In that case you are advised to finish those threads before you use Fire.


### Editing

When you edit one or more APL objects from Fire you can double-click another APL object in an Edit window successfully. You can also go to the session and add another Edit window to those which are already open. However, you are advised to use this with care. 


### Report hits

After having performed a search "Report hits" allows you to check the hits in context. This is particularly useful in order to find out whether the hit list needs some fine tuning.


### Print object name(s) to the session

Note that you can make Fire print the fully qualified name of all selected items in the hit list either by selecting the appropriate command from the context menu or by pressing F4.


### Copy object name to "Search for"

Via the context menu or by pressing F6 you can copy the name of the currently selected object in the hit list to the "Search for" control. This option is inactive in case more than just one row of the hit list is selected.


### The "Start looking here" control

You can reduce the length of the path in the "Start looking in" by one "unit" by pressing Ctrl+Backspace. For example, if the current contents of the control is

`#.foo.my.subnamespaceNumber0911`

then pressing Ctrl+Backspace reduces this to

`#.foo.my`

Note that this works only when the cursor is positioned to the right of the contents.

By pressing the <delete> key --- when the focus is in the "Start looking here" field --- you can reduce it from

`#.foo.my.subnamespaceNumber0911`

to just

`#`


### Enlarge the window

If the hit list is too big to display all hits try pressing F8. This will enhance the height of the window to what's either necessary to display the full list or what is the maximum size of the monitor. 
This might not work too well on multiple-monitor systems when the screen sizes of the monitors involved are different.


## Useful Regular expressions

There is a separate document `UsefulRegExes.html` available --- see there.


## acre and Fire

Acre --- which [lives on GitHub](https://github.com/the-carlisle-group/Acre-Desktop) --- is an APL project manager systen written in Dyalog APL by [Phil Last](http://aplwiki.com/PhilLast).

When Fire finds acre in `⎕SE` it will tell acre about all change and delete operations. Acre will then work out what project the object in question belongs to and take action, if any. In other words, Fire and acre are fully integrated.


## Salt and Fire

The Simple APL Library Toolkit (SALT) which is supplied with Dyalog APL is supported by Fire: when a script is managed by SALT then the script "contains" an ordinary namespace SALT_Data. This namespace contains a number of variables including

* CRC            
* GlobalName     
* LastWriteTime  
* PreviousVersion
* SourceFile     
* Version        

and others. SALT uses them for its own purposes.

When a script is re-fixed with `⎕FIX` then the namespace SALT_Data disappears. 

However, Fire works out whether a script is managed by SALT and restores the namespace SALT_Data after having re-fixed it as part of a "Replace" operation. Therefore the script continues to be managed by SALT.

What Fire does not do is actually saving any object via a SALT command. The simple reason is that when you change an object in the workspace it does not necessarily mean that you want to save those changes on disk. It's completely up to the programmer to make that decision. 

Note that in the "Report" menu there is a command "List changed SALTed scripts". This command prints a SALT "Save" command to the session for all scripts that got changed by Fire and are managed by SALT.


## Showing the PID in all Fire window captions

Dyalog allows you to specify the captions of many GUI elements like the session, the Workspace Explorer, message boxes etc. by setting certain values in the Windows Registry. For details search for "Windows captions" in the Dyalog Help.

In case you've added {PID} - which stands for "Process ID" - to the MessageBox value Fire will honor this and show the PID in all its GUI elements as well.

In case you wonder what this is good for: there are people out there who have more than just one Dyalog session running at the same time, sometimes many. In such cases it can be very useful to know the process ID a particular message box belongs to, because it can be very awkward or impossible to find out by other means.

Kai Jaeger --- 2018-01-28