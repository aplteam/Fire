[parm]:toc            = 3
[parm]:numberHeaders  = 2 3 4
[parm]:saveHTML       = 0
[parm]:title          = 'Fire ReadMe'
 

# Fire

Note that FiRe stands for FInd and REplace. 

Up to version 9.x Fire was a Windows-only application. With version 10.0 Fire became multi-platform: it runs on Windows, Linux and Mac OS. It was not tested on the PI but most likely will work there as well.


## Features

Fire has a couple of features that Dyalog's built-in "Search" tool do not offer. These are the main features:

* Most importantly, a global "Replace".

  This feature is particularly powerful since it allows you to inspect every single item that is going to be changed in a preview, and to exclude objects with a single click.

* The scope of a search can be restricted to just code while comments or even text will be ignored. Or you search just in comments, or just in text.

* A search result can become the source of another search.

* Regular Expressions can be used.

Fire has however many more features:

* The "Start search in" control remembers the last 30 entries per workspace and user.

* The "Start looking here" control offers auto-completion.

* One can negate a search: all which do _not_ contain ... 

  In conjunction with "Search hit list" this can effectively be used to exclude unwanted stuff before triggering a "Replace".

* Built-in reports designed to help refurbishing code that has started to smell.

* Search just the name list (`⎕NL`).


## Fire to the rescue

Fire also overcomes a couple of problems that Dyalog's built-in Search tool is suffering from.

* It handles circular references well thanks to Phil Last.

* It is less likely to generate a WS FULL.


## Prerequisites

### Before version 10

* Fire requires at least version 18.2 Unicode in order to run

* Fire also requires the Dyalog package manager Tatin to be installed in order to bring in the packages Fire depends on. 

### From 10.0 onwards

* Fire requires at least version 20.0 Unicode in order to run

* Fire does not need Tatin anymore.


## Installing Fire

### General information

#### Windows

Since version 7.1.0 Fire comes with its own installer. Just double-click it and your are done. It does not require admin rights.

The installer installs Fire by default into `%USERPROFILE%\Documents\MyUCMDs` which translates to `C:\Users\{userid}\Documents\MyUCMDs` with a default Windows installation. This folder, if it exists, is scanned by Dyalog for user commands.

Note that installing into `%USERPROFILE%` means that you have to install it separately for every user who wants to use Fire.

#### Non-Windows platforms


```
⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹⌹
```

### Get rid of pre-installer versions of Fire

If you have used Fire before version 7.1 then you might have installed it somewhere different. If this is the case then your are strongly advised to remove Fire (both the script `Fire_uc.dyalog` and the folder `Fire\` from that folder before running the installer.

Without doing this the old installation will continue to exist, and depending on the sequence of folders Dyalog scans for user commands Dyalog might continue to execute the older version, because the first one wins.

### Installing Fire somewhere else

If for some reason you decide to install Fire not in the default location but somewhere else then that's fine. Of course the hosting folder must be among the folders scanned by Dyalog for user commands; see the "User Command" tab in the Dyalog Configuration dialog.

If you want to change the installation folder later when you install Fire again then it is strongly recommended that you un-install it first: execute this EXE in order to achieve that:

```
%USERPROFILE%\Documents\MyUCMDs\Fire\unins000.exe
```

Without doing this the old installation will continue to exist, and depending on the sequence of folders Dyalog scans for user commands Dyalog might continue to execute the older version, because the first one wins.

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


## Anomalies

### Scripted versus non-scripted namespaces

Scripted namespace are in some ways an anomaly in Dyalog APL. For example, if there is a function `foo` in a namespace `NS` then the statement `NS.⎕EX 'foo'` deletes the function from an ordinary (non-scripted) namespace but _not_ from a scripted namespace, though it _is_ removed from the namespace that is connected to the script. `⎕FX` behaves similarly strange.

Fire processes functions and operators in scripted namespaces in the same way as in ordinary namespaces. That means that a function that carries a hit is listed on its own in both cases. 

A namespace script as such is _only_ listed in the hit list when it carries variable definitions or comments with hits.

However, this is inconsistent with what Fire does with functions and operators: in ordinary namespaces a variable is listed on it's own only when its value --- not the name! --- carries a hit. For scripted namespaces it's listed on its own when the value _or_ the name carries a hit.

The reason for this inconsistency is that there is no good way to tell function assignments (like `fns←+/`) from variable assignments.

Since "Replace" is only available for variables of certain types anyway, this still seemed the best way to deal with the problem.


### References

There are two different flavours of references to be considered:

* References pointing to classes, interfaces or namespaces.

  By default these are simply ignored by Fire.

* References pointing to functions, either traditional ones or dfns.

It **is** possible to tell a reference pointing to a tfn from that tfn, but with a large number of functions it would slow down Fire siginificantly.

Worse, there is no way to tell a reference pointing to a dfn from that dfn.

Therefore Fire does not even attempt to identify such references. That could result in the same function listed twice in the hit list, once under its real name and once under the name of the reference.

That should not pose a problem, even if you perform a "Replace" operation: Fire would carry out the same operation twice, wasting a bit of time but delivering the desired result.


### Nested scripted namespaces

If you attempt to change a function or operator that lives in a scripted namespace which itself lives in a scripted namespace then Fire _**cannot**_ perform the change. 

For example, given this script:

```
:Namespace Outer
    :Namespace Inner
        ∇ r←PI
          r←3.14
        ∇
    :EndNamespace
:EndNamespace
```

If you attempt to replace `3.14` by `3.14159265359` with Fire then that would fail; Fire will tell you BTW.

Here is why:

```
      ⍪c←⎕nr '#.Outer.Inner.PI'
  r←PI   
  r←3.14 
      2⊃c
 r←3.14
      (2⊃c)←'r←3.14159265359'
      #.Outer.Inner.⎕FX c
      ⍪#.Outer.Inner.⎕NR 'PI'
  r←PI            
  r←3.14159265359 
      #.Outer.Inner.PI
3.14159265359
      ⍪⎕SRC #.Outer.Inner
     :Namespace Inner 
         ∇ r←PI       
           r←3.14     
         ∇            
     :EndNamespace    
```

As you can see, by now the code in the namespace associated with the script (that's what gets executed!) is no longer in sync with the script.

Now this is in accordance with the documentation. When you want to change a function in a script you need to use `⎕FIX` and it will work. Fire is actually doing this behind the scenes, and it works well _unless scripted namespaces are nested_!

To illustrate the problem let's start again with this script:

```
:Namespace Outer
    :Namespace Inner
        ∇ r←PI
          r←3.14
        ∇
    :EndNamespace
:EndNamespace
```

This time we modify not the function but the inner script:

```
      ⍪c←⎕src Outer.Inner
     :Namespace Inner 
         ∇ r←PI       
           r←3.14     
         ∇            
     :EndNamespace    
      3⊃c
          r←3.14
      (3⊃c)←'r←3.14159265359'
      Outer.⎕fix c
      3⊃⎕src Outer.Inner
          r←3.14159265359
      Outer.Inner.PI
3.14159265359
      ⍪⎕SRC Outer
 :Namespace Outer     
     :Namespace Inner 
         ∇ r←PI       
           r←3.14     
         ∇            
     :EndNamespace    
 :EndNamespace        

```

This is unfortunate for two reasons:

1. `⎕FIX` and `⎕SRC` should be the inverse of each other; they are not.
1. As a programmer I do not have other means than `⎕FIX` for modifying `Inner`, but that does not work.

However, for the time being all Fire can do when it finds a hit in an inner namespace is to tell you, the user, that it will not be able to carry out any changes in that inner namespace.

Hopefully using nested namespaces will not become popular...

### Ghostly namespaces

Note that Fire does not scan ghostly namespaces. These are namespaces which exist together with GUI objects as well as classes. If you did not know about ghostly namespaces then it might be best to ignore them: they can be quite confusing. 

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
However, `⎕IO` _must_ be a private property of the class, so it can _never_ be set or even referenced directly: you cannot specify anywhere an "Access Public" statement for `⎕IO`.

But since we managed to execute these statements successfully (`⎕FX 'Hello'` and `⎕IO←0`) the question is where they have been executed. Well, in the ghostly namespace which exists together with the class script, sharing the same name. 

Even if Fire would show the function `Hello` in the hit list there is another anomaly: executing `Test.⎕ed 'Hello'` doesn't allow you to edit it. That means that Fire does not have the means to allow you editing the code.

The final obstacle: making a change to the class `Test` will make `Hello` disappear because the ghostly namespace will be re-created when the class is (re-) fixed.

Therefore it seems to be best to ignore ghostly namespaces altogether.


#### GUI objects and ghostly namespaces

Investigate this code:

~~~
      'MyForm' ⎕WC 'Form' ('KeepOnClose' 1)
      MyForm.⎕FX'r←Hello' 'r←''World'''
~~~
      
Note that strictly speaking this is the same thing: There is a GUI object called "MyForm" but there is also a ghostly namespace holding the "Hello" function. However, Dyalog APL perfectly keeps that as a secret: it has always been that way since GUI objects were introduced into Dyalog APL a long time ago, yet nobody ever realized this because Dyalog APL behaved in a way that makes that actually impossible.


#### Semi-ghostly namespaces

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


### `2 ⎕FIX` with the file:// protocol

You can use 

```
2 ⎕FIX 'file:///path/to/MyClass.aplc'
```

This will bring the class into the workspace and link it to the file.

If for any reason you break that link with the `5178⌶` I-Beam then it leaves behind a kind of zombie: you cannot edit the code anymore, and `⎕SRC` would generate a NONCE ERROR on it, despite the fact that the code still executes.

Fire would not find anything inside such a zombie. Dyalogs own search tool would find stuff inside any function and any operator inside `MyClass`, be it private or public, but nothing outside functions and operators.

Our advice is to not use `2 ⎕FIX` with the file protocol if you can help it; instead use 

```
2 ⎕FIX ⊃⎕NGET '/path/to/MyClass.aplc
```


## Deleting stuff

The "Replace" dialog has a check box "Delete lines/items with hits". That seems to be easy enough: any lines that carry the search string are going to be deleted. However, there are details you need to be aware of:

1. Variables of any type are ignored.

1. The first and the last line of any script is never deleted, no matter whether they carry a hit or not. It should be obvious why that is.

1. The first line of any function or operator is never deleted, no matter whether they carry a hit or not. However, be aware of the next topic.

1. A tfn that carries hits on all its lines is deleted.

1. A one-line dfn that carries a hit is deleted.


## Tips and Tricks

### ⎕DQ and the "Wait" method


Fire does not execute either `⎕DQ` or `Wait` on its main GUI. That allows one to move the focus to the session by pressing <Ctrl+Tab> in Fire. Sadly there is no way to move the focus back to Fire without the mouse.

Avoiding `⎕DQ` works well in many circumstances but it might cause problems when other threads are running. In that case you are advised to finish those threads before you use Fire.

### Threads and Fire

Threads can pose a problem. This is particularly true for the "Replace" operation. That is the reason that the "Replace" operation cannot be triggered when other threads than the main thread are running.


### Editing

When you edit one or more APL objects from Fire you can double-click another APL object in an Edit window successfully. You can also go to the session and add another Edit window to those which are already open. However, you are advised to use this with care. 


### Report "Detailed hits"

After having performed a search the report "Detailed hits" allows you to check the hits in context. This is particularly useful in order to find out whether the hit list needs some fine tuning.

Note that you can remove objects from the "Detailed hits" report, and this will _also_ remove them from the hit list.


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


## Fire's API

Since version 8.0 Fire comes with an API, meaning that you can take adantage of some of Fire's features under program control.

You must make sure that Fire is available in `⎕SE`. This can either be achieved by just executing the `]Fire` user command or by executing `]Fire -noGUI` which does load Fire into `⎕SE` but does not run Fire, meaning that the GUI would not show.

You can then execute the appropriate methods from the namespace `⎕SE._Fire.Fire.API`.

### Searching for a string

Let's assume you want to search the string "abc" in `⎕SE`. This is what you would do:

```
      F←⎕SE._Fire.Fire.API
      parms←F.CreateParms
      parms. ∆List
 APL_Name       0
 Greedy         0
 Negate         0
 Report         0
 SearchIsRegEx  0
 APL_Code       1
 Case           1
 Code           1
 Comments       1
 Text           1
 Vars           1
 StartSearchIn  #
      parms.StartSearchIn←'⎕se'
      parms F.Search 'abc'
 ⎕SE.Parser        4 9.4
 ⎕SE.SALT          2 9.4
 ⎕SE.UnicodeFile   1 9.4
```

There are three columns:

* `[;1]` = the names of the objects with hits
* `[;2]` = Number of hits
* `[;3]` = Name class

If you want to get the hits listed set `Report` to 1:

~~~{style="white-space: pre;"}
      parms←F.CreateParms
      parms.StartSearchIn←'⎕se'
      parms.Report←1
      ⎕←parms F.Search 'abc'
 ∇⎕SE.Parser[⎕47 130 131]∇
  [47]  (LOWER UPPER)←'abcdefghijklmnopqrstuvwxyzàáâãåèéêëòóôõöøùúûäæü' 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÅÈÉÊËÒÓÔÕÖØÙÚÛÄÆÜ' 
  [130] ⍝ sw←123 Switch 'abc' ⍝ if 'abc' has not been set 123 is returned.
  [131] ⍝ If /abc=789 was specified in the parsed string the value returned will be ,789, not '789'
 ∇⎕SE.SALT[⎕735 737]∇
  [735] t←'0123456789abcdefghijklmnopqrstuvwxyz' ⋄ ex←ex,(⍴ex)↓'^=_'
  [737] to←t,'aaaaaaeeeeeiiiioooooouuuunpdsccabcdefghijklmnopqrstuvwxyzaaaaaaeeeeeiiiioooooouuuudyn',ex
 ∇⎕SE.UnicodeFile[⎕298]∇
  [298] charset←'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 abcdefghijklmnopqrstuvwxyz0123456789'
~~~

### Search `⎕NL` (Name List)

Since version 9.0 the API also allows you to search `⎕NL` recursively. Note that this always searches `#`.

Let's assume you want to perform a search for "string" in the names of all objects, and that the search should _not_ be case sensitive. 

We can do this without further ado because the defaults fit:

```
      F.SearchQNL 'search'

```

If we want to search for all functions that start their names with "Search" we must use a RegEx, and it should be a case sensitive search. For that we need to set some parameters:

```
      parms←F.CreateParmsFor_QNL_Search
      parms.∆List  ⍝ List the defaults
 Case           0 
 FullPath       0 
 SearchFor        
 SearchIsRegEx  0 
      parms←SearchIsRegEx←1
      parms←Case←1
      parms F.SearchQNL '^Search'

```

Note that if you want to find "search" in the full path of the APL objects (like "Foo" in `#.Fist.Foo.MyFunction`) then you must set `FullPath` to 1.

## Useful Regular expressions

There is a separate document `UsefulRegExes.html` available --- see there.

## Link and Fire

Since version 9.2 Fire supports Link. However, Fire needs at least Link version 3.0.0 for that to work.

In case only an older version is found Fire will print warnings to the session.


## Salt and Fire

Note that managing scripts with Salt it deprecated. Use Link instead.

The Simple APL Library Toolkit (SALT) which is supplied with Dyalog APL is supported by Fire: when a script is managed by SALT then the script "contains" an ordinary namespace `SALT_Data`. This namespace contains a number of variables including

* `CRC`
* `GlobalName` 
* `LastWriteTime`
* `PreviousVersion`
* `SourceFile`     
* `Version`

and others. SALT uses them for its own purposes.

When a script is re-fixed with `⎕FIX` then the namespace `SALT_Data` disappears. 

However, Fire works out whether a script is managed by SALT and restores the namespace `SALT_Data` after having re-fixed it as part of a "Replace" operation. Therefore the script continues to be managed by SALT.

What Fire does not do is actually saving any object via a SALT command. The simple reason is that when you change an object in the workspace it does not necessarily mean that you want to save those changes on disk. It's completely up to the programmer to make that decision. 


## Showing the PID in all Fire window captions

Dyalog allows you to specify the captions of many GUI elements like the session, the Workspace Explorer, message boxes etc. by setting certain values in the Windows Registry. For details search for "Windows captions" in the Dyalog Help.

In case you've added {PID} - which stands for "Process ID" - to the MessageBox value Fire will honor this and show the PID in all its GUI elements as well.

In case you wonder what this is good for: there are people out there who have more than just one Dyalog session running at the same time, sometimes many. In such cases it can be very useful to know the process ID a particular message box belongs to, because it can be very awkward or impossible to find out by other means.

Kai Jaeger --- 2022-08-31


