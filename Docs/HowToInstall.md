# How to install Fire

Note that Fire 5.\* and better needs at least Dyalog 15.0 Unicode. Any 4.\* version runs under 14.0 and 14.1 Unicode but is not actively developed any more.

Fire 6.0 was re-designed from scratch and simpified dramatically. As a result there are some changes you need to take into account if you are upgrading from an older version.

After downloading and unzipping Fire.zip you get this:

   * fire_uc.dyalog (the user command script)
   * folder `Fire\`. It contains these files:
     * Fire.dws   
     * HowToInstall.html
     * ReadMe.html
     * UsefulRegExes.html
   
Note that this is different from earlier versions when

* the user command script and the workspace had been siblings.
* there was also a file Fire.chm.

There is no help file (Fire.chm) any more; instead the file `ReadMe.html` was added.

(If you have used older versions of Fire please note that you can delete `Fire.dws` and `Fire.chm` as siblings of the user command file `fire_uc.dyalog`)
    
In order to make Fire available as a user command you need to copy the user command script and the folder to a particular target folder.
    
The target folder depends on whether you want Fire to become part of a Dyalog installation or whether you want it to go into an individual user command folder you are using for your own user commands.
    
    
## Option 1: Fire as part of a standard installation
    
Copy the user command script and the folder to the standard path for user commands on your computer. This is the standard folder:

~~~
(2 ⎕nq '.' 'GetEnvironment' 'Dyalog'),'\SALT\Spice'
~~~

Note that you need admin rights for this since ordinary users are normally not allowed to write to this folder.
    
    
## Option 2: Fire goes into a dedicated user command folder
    
If you have defined a specific folder for non-Dyalog user commands and want Fire to go into that folder then just copy the user command script `dyalog_uc.dyalog` and  the folder`Fire\` into that folder.

## Using Fire
    
Now you can start Fire by executing:
    
~~~
]Fire
~~~
 
The user command checks whether Fire is already available in `⎕SE`. If not it is copied into `⎕SE`.

From now on Fire is started directly from `⎕SE` for the duration of that session. You might find this significantly faster than loading it into `⎕SE` first depending on where Fire is actually loaded from.
    
Of course you can make that change persistent by saving your session but this is not recommended. If you save Fire with your session anyway then you need a way to enforce a load when a new version of Fire comes along . This can be achieved by specifying the optional parameter `fl`:

~~~
]Fire -fl
~~~ 

This loads Fire into `⎕SE` no matter whether it's already there or not: `fl` stands for "force load".
 

----

| Kai Jaeger / APL Team Ltd | 2014-04-03 |
| Last update | 2018-03-04 |