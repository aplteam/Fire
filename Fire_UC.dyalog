:Class  Fire
⍝ User Command script for "Fire"
⍝ Checks whether Fire is already loaded into ⎕SE.Fire.
⍝ If this is the case then Fire is started.
⍝ If this is not the case then Fire is copied into []SE from
⍝ the same directory the User Command stems from and then started.
⍝ Kai Jaeger ⋄ APL Team Ltd
⍝ * Version 2.7.1 - 2020-01-22
⍝   * Bug fix: the  ]fire .  had stopped working with version 8.0.0
⍝ * Version 2.7.0 - 2020-01-22
⍝   Now the user command checks whether the minimum requierements (Dyalog Version) are met.
⍝   In the past an attempt to use Fire from a version that was too old resulted in a
⍝   misleading error message.
⍝ * Version 2.6.0 - 2019-12-22
⍝   * New option -noGUI added: loads Fire into ⎕SE but does not run it.
⍝ * Version 2.5.1 - 2019-08-22
⍝   * Bug fix: Fire was copied each and every time, therefore forgetting former search tokens.
⍝ * Version 2.5.0 - 2019-07-28
⍝   * The script now simply assumes that the folder Fire\ is a sibling of this script.
⍝   * Changed to groups "WS".

    MinimumVersionOfDyalogNeeded←'16.0'   ⍝ No need to edit this: it's checked by ]runmake, and changed if necessary

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''                               ⍝ create the command
      r.Name←'Fire'                         ⍝ the name
      r.Desc←'Starts Fire (FInd & REplace)'
      r.Group←'WS'
     ⍝ Parsing rules:
      r.Parse←'1s -fl -noGUI'
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;forceLoadFlag;neededModules;dne;n;noGUIFlag;thisVersion
      :Access Shared Public
      ⎕IO←0 ⋄ ⎕ML←3 ⋄ ⎕WX←3
      thisVersion←⊃(//)⎕VFI{⍵/⍨2>+\'.'=⍵}1⊃'#'⎕WG'APLVersion'
      :If (⊃(//)⎕VFI MinimumVersionOfDyalogNeeded)>⊃(//)⎕VFI{⍵/⍨2>+\'.'=⍵}1⊃'#'⎕WG'APLVersion'
          11 ⎕SIGNAL⍨'Fire needs at least version ',MinimumVersionOfDyalogNeeded,' of Dyalog APL'
      :EndIf
      r←0 0⍴''
      forceLoadFlag←Args.Switch'fl'
      noGUIFlag←Args.Switch'noGUI'
      neededModules←'APLTreeUtils' 'FilesAndDirs' 'OS' 'WinReg' 'GitHubAPIv3'   ⍝ to be copied
      '_Fire'⎕SE.⎕NS''
      dne←0=↑∘⎕SE.⎕NC¨neededModules                                             ⍝ do not exist (dne)
      :If forceLoadFlag
          :Trap 6 ⋄ ⎕SE._Fire.Fire.Cleanup ⋄ :EndTrap                           ⍝ Get rid of any GUI
          ⎕SE.⎕EX'_Fire'
          '_Fire'⎕SE.⎕NS''
      :EndIf
      :If 1∊dne
          CopyThese(dne/neededModules)
          CreateRefs(~dne)/neededModules
      :EndIf
      :If forceLoadFlag
      :OrIf 0=⎕SE._Fire.⎕NC'Fire'
          :Trap 11
              'Fire'⎕SE._Fire.⎕CY(0⊃⎕NPARTS ##.SourceFile),'\Fire\Fire.dws'
          :Else
              'Could not copy Fire'⎕SIGNAL 11
          :EndTrap
      :EndIf
      :If ~noGUIFlag
          n←⎕SE._Fire.Fire.Run 0
          :If 1=≢↑Args.Arguments
          :AndIf (,'.')≡,↑Args.Arguments
              n.StartSearchIn.Text←(⎕SI⍳⊂'UCMD')⊃⎕NSI
          :EndIf
      :EndIf
    ∇

    ∇ r←Help Cmd;⎕IO;⎕ML
      ⎕IO←0 ⋄ ⎕ML←3
      :Access Shared Public
      r←''
      r,←⊂'Starts Fire (FInd & REplace).'
      r,←⊂'Runs under Dyalog version ',MinimumVersionOfDyalogNeeded,' or later.'
      r,←⊂'Loads Fire (and some stuff needed by Fire) into ⎕SE and starts it.'
      r,←⊂'When you call Fire again it is started from ⎕SE without further ado.'
      r,←⊂'However, you can force a reload into ⎕SE by specifying the optional'
      r,←⊂'switch -fl (force load)'
      r,←⊂''
      r,←⊂'If you are somewhere different from # then you can force Fire to start'
      r,←⊂'the next search from that namespace by providing a dot as argument:'
      r,←⊂']Fire .'
      r,←⊂''
      r,←⊂'If you want to load Fire into ⎕SE without actually running it then you'
      r,←⊂'can use the -noGUI switch which does this without running Fire. Use this'
      r,←⊂'if you want to run any of Fire''s API functions: you need to get Fire'
      r,←⊂'into ⎕SE somehow.'
    ∇

    ∇ {r}←CopyThese objects;wsNamePath;object;i;msg
      r←⍬
      :If 0<≢objects
          wsNamePath←(0⊃⎕NPARTS ##.SourceFile),'\Fire\Fire.dws'
          :If ⎕NEXISTS wsNamePath
              :Trap 11
                  (⊃objects)⎕SE._Fire.⎕CY wsNamePath
              :Else
                  ⍝ Strictly speaking the following is not a necessary measure, but it's a fallback against stupidity:
                  msg←''
                  :For i :In ⍳≢objects
                      object←i⊃objects
                      :Trap 11
                          object ⎕SE._Fire.⎕CY wsNamePath
                      :Else
                          msg,←⊂'Module <',object,'> not found in ',wsNamePath
                      :EndTrap
                  :EndFor
                  (1↓↑,/(⎕UCS 13),¨(⊂'*** Problem collecting modules required by Fire:'),'  '∘,¨msg)⎕SIGNAL 6/⍨0≠≢msg
              :EndTrap
          :Else
              6 ⎕SIGNAL⍨'Could not find ',wsNamePath
          :EndIf
      :EndIf
    ∇

      CreateRefs←{
          list←⍵
          0=≢list:shy←⍬
          _←{⍎'⎕SE._Fire.',⍵,'←','⎕SE.',⍵}¨list
          1:shy←⍬
      }

:EndClass
