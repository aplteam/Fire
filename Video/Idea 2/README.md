[parm]:leanpubExtensions = 1


# Fire Video

## Background

I was alway looking for a case that is complex enough to demonstrate Fire's enormous capabilities without being too complex.

The following hits the mark.

## Goal

I just added a new property to the class `UserSettings`: the flag `caching`.

This defaults to 1, but for my test cases I need it to be 0.

## Steps

1. Open the project with

   ```
   ]CiderOpenProject ./Tatin
   ```

1. Close the project. Paranoia: in case we want to repeat the whole operation.

1. Execute `)CS #.Tatin.TestCases`

1. Search for `MyUserSettings` with:

   ```
   ]Fire .
   ```

   Note that `MyUserSettings` is a naming convention for instances of `UserSettings`.

1. Press F2: there are hits, so the likelihood is that we need to do something here.

1. Close the hit report.

1. Search now for `UserSettings`. 

1. Press F2 and explain that this finds `UserSettings` but also `MyUserSettings`.

1. Close the hit report.

1. Tick "Match valid names only" and search again

1. Press F2: we now we just get what we are after

1. Inspect the hit report in detail.

   Point out that we are only interested in lines that carry this:

   ```
   ←⎕NEW TC.UserSettings
   ```

1. Close the hit report

1. Search again but for `settings←⎕NEW TC.UserSettings`.

1. Discuss the warning regarding valid APL names.

1. Discuss the hits on `Test_ClientConfig_[110|111]`

1. Remove both functions from the hit list

1. Discuss the "Actions" column in the hit report

1. Close the hit report

1. Click the "Replace" button

1. Press F6 to copy the contents of "Search for" to "Replace by"

1. Add <Ctrl+Enter> and `settings.caching←0` into the "Replace by" field

1. Click "Preview"

A> This creates a WS FULL in Fire --- that bug must be fixed first!

1. Carry out the "Replace" operation

1. Establish this function:

   ```
   r←∆NewUserSettings path
   r←⎕NEW TC.UserSettings path
   r.caching←0
   ```

1. Mentions that could have replaced the original line by two lines as well

1. Repeat the search for `←⎕NEW TC.UserSettings`

   We get a list with three functions:

   ```
   #.Tatin.TestCases.Test_ClientConfig_110
   #.Tatin.TestCases.Test_ClientConfig_111
   #.Tatin.TestCases.∆NewUserSettings
   ```

   Now edit `#.Tatin.TestCases.Test_ClientConfig_111` and make the required amendments "by hand".