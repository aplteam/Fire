# Script "Fire - basic search"

## Preperation

* Start Camtasia and prepare it for the proper screen size
* Open a Browser window with a single tab
* Create an empty sub directory D:\Temp\Fire
* Delete any Fire zip files from previous downloads from the `D:\Downloads` folder.
* Delete any Fire files from the target "Spice" folder.
* Prepare a Windows Explorer window looking into the "Downloads" folder.
* Prepare another Windows Explorer window looking into D:\Temp\Fire
* Start APL, Fire and Fire's Help and check the screen positions, then close them.

## To-do

> Hello and welcome. 

> In this tutorial we are going to discuss the basics of how to search for a string in an APL workspace.

> If you have not installed Fire yet as a Dyalog user command then please watch the Fire installation tutorial first.

> As you can I have already started an instance of Dyalog APL, in this case 15.0 Unicode. 

> In order to use Fire we need some code in the workspace. For that we simply load John Schole's excellent collection of direct functions.

~~~
      )Load dfns
~~~

> Now let's start Fire:

~~~
      ]Fire
~~~

> Note that many if not all input fields, radio buttons and check boxes have a field that reads like an uppercase "I".

* Emphasize one of the "Info" buttons.

> That stands for "Info". A click on it brings brings you straight to the help page associated with the nearby control.

* Demonstrate on "Search for" (Regular expressions)

> If at a later stage you want to get rid of those info buttons: just untick "Show info button" in the "Help" menu.

> Now lets search for something.

* Enter `⎕IO` into "Search for" and click "Find".

> The status bar provides details regarding this search.

> That's a surprisingly large number of hits!

> Let's sort the table by type:

* Sort the "Result" table by type **twice**.

> Ah, there are many variables carrying the string `⎕IO`. 

> We are not interested in any variables at all, so let's tell Fire that it should ignore variables:

* Untick "Variables".

> Note that the caption of the "Variables" check box is now bold.

> That's because we've changed a default setting: those get bold, so you can't miss them.

> You restrict what kind of objects Fire is going to scan even further. For example, let's assume that we want to scan just classes but nothing else.

* Click "None"
* Click Clases

> You can restore the defaults by clicking at the "Restore defaults button".

* Click "Restore"

> Nothing is bold any more.

* Untick "Variables" again.

> You can at any point make the current settings your own defaults by selecting "Save settings as default" from the File menu.

* Select "Save settings as default" from the File menu.

> Now let's repeat the search.

* Hit "Find" again.

> That's better.

~~~
TestFns
(⎕IO ⎕ML)←1
~~~

> Let's modify the search string slightly...

* Add `←` to "Search for" 

* Hit search again

> Now there are just "??" hits left.

> We can tell Fire that it should ignore comments by ticking the "but ignore comments" check box.

> BTW, at any stage you can ask Fire to adapt the hight of the screen to the number of hits:

* Select "Enlarge" from the "Edit" menu and explain.

> It's almost always a good idea to check what Fire has actually found. 

> For that we select "Hit report" from the "Reports" menu.

* Select "Hit report" from the "Reports" menu.

> Note that this report shows just the lines that carry hits, and that the hits are emphasized by colour.

> Checking this report is particularly important when you will use the hit list as the basis for a "Replace" operation.

* Close the "Hit" report.

> Finally I want to show you an example of when "Search hit list" and "Negate search" can be very useful.

> For that we first search for all traditional functions and operators that do **not** carry `⎕IO` in their header.

* Change "Search for" to just `⎕IO`

* Click at "None" and then tick the "Trad fns" check box

* Tick the "Negate Search" check box.

* Change "Start looking here" to `⎕SE`.

* Hit "Find".

> This gives a list with all traditional functions and operators that do **not** carry the string `⎕IO` in their header. 

> To rephrase it: in those functions `⎕IO` is not localized.

> Now we wanna know which of those assign a value to `⎕IO.

> For this we untick the "Negate search" and then tick "Search hit list".

> Finally we append a `←` to the "Search for" field, and then we search again.

> Note that this is not perfect because we would miss more complex assignments to `⎕IO`, but we could get around this with a proper regular expression.

> However, this is beyond the scope of this Tutorial.

> In our case we get the message that no hits have been found. Good news.

That's it folks, this should get you going.