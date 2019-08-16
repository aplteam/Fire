:Class  Fire
⍝ User Command script for "Fire"
⍝ Checks whether Fire is already loaded into ⎕SE.Fire.
⍝ If this is the case then Fire is started.
⍝ If this is not the case then Fire is copied into []SE from
⍝ the same directory the User Command stems from and then started.
⍝ Kai Jaeger ⋄ APL Team Ltd
⍝ * Version 2.5.0 - 2019-07-28
⍝   * The script now simply assumes that the folder Fire\ is a sibling of this script.
⍝   * Changed to groups "WS".

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''                               ⍝ create the command
      r.Name←'Fire'                         ⍝ the name
      r.Desc←'Starts Fire (FInd & REplace)'
      r.Group←'WS'
     ⍝ Parsing rules:
      r.Parse←'1s -fl'                      ⍝ Takes one optional switch: force load
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;forceLoadFlag;neededModules;dne;n
      :Access Shared Public
      ⎕IO←0 ⋄ ⎕ML←3 ⋄ ⎕WX←3
      r←0 0⍴''
      forceLoadFlag←Args.Switch'fl'
      neededModules←'APLTreeUtils' 'FilesAndDirs' 'OS' 'WinReg' 'GitHubAPIv3'   ⍝ to be copied
      '_Fire'⎕SE.⎕NS''
      dne←0=↑∘⎕SE.⎕NC¨neededModules                                             ⍝ do not exist (dne)
      :If forceLoadFlag
          :Trap 6 ⋄ ⎕SE._Fire.Fire.Cleanup ⋄ :EndTrap                           ⍝ Get rid of any GUI
          ⎕SE.⎕EX'_Fire'
          '_Fire'⎕SE.⎕NS''
      :EndIf
      :If 1∊dne
          CopyThese(dne/neededModules),⊂'Fire'
          CreateRefs(~dne)/neededModules
      :EndIf
      n←⎕SE._Fire.Fire.Run 0
      :If 1=≢↑Args.Arguments
      :AndIf (,'.')≡,↑Args.Arguments
          n.LookIn.Text←(⎕SI⍳⊂'UCMD')⊃⎕NSI
      :EndIf
    ∇

    ∇ r←Help Cmd;⎕IO;⎕ML
      ⎕IO←0 ⋄ ⎕ML←3
      :Access Shared Public
      r←⊂'Starts Fire (FInd & REplace).'
      r,←⊂'Loads Fire (and some stuff needed by Fire) into ⎕SE and starts it.'
      r,←⊂'When you call Fire again it is started from ⎕SE without further ado.'
      r,←⊂'However, you can force a reload into ⎕SE by specifying the optional'
      r,←⊂'switch -fl (force load)'
      r,←⊂''
      r,←⊂'If you are somewhere different from # then you can force Fire to start'
      r,←⊂'the next search from that namespace by providing a dot as argument:'
      r,←⊂']Fire .'
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
