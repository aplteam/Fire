﻿:Class  Fire
⍝ User Command script for "Fire"
⍝ Checks whether Fire is already loaded into ⎕SE.Fire.
⍝ If this is the case then Fire is started.
⍝ If this is not the case then Fire is copied into []SE from
⍝ the same directory the User Command stems from and then started.
⍝ Kai Jaeger ⋄ APL Team Ltd
⍝ * Version 2.4.1 - 2019-07-15
⍝   * Bug fix: File was always loaded since the introduction of the ⎕SE._Fire level.
⍝ * Version 2.4.0 - 2019-06-10
⍝   * In case a requiered module is not found an detail error report is provided.
⍝ * Version 2.3.0 - 2019-06-04
⍝   * Fire now goes into `⎕SE._Fire.Fire` while all stuff that is needed but does not exist in ⎕SE
⍝     goes into `⎕SE._Fire`. For stuff that exists in `⎕SE` refs are created in `⎕SE._Fire`.
⍝ * Version 2.2.0 - 2019-03-11
⍝   * `GitHubAPIv3` added to the list of to-be-copied stuff.
⍝ * Version 2.1.1 - 2018-05-26
⍝   The -fl option did not get rid of the GUI if Fire was already running.
⍝ * Version 2.1.0 - 2018-04-26
⍝   * Tidied up.
⍝ * Version 2.0.1 - 2018-04-23
⍝   * Minor change regarding the documentation.
⍝ * Version 2.0.0 - 2017-07-10
⍝   * Massive changes: compatible only with Fire 6.0 and later.
⍝   * Accepts `.` as an argument. Treated as "Copy current namespace into `Start looking here:`"
⍝ * Version 1.3.1 - 2017-02-24
⍝   * Bug fix for the CommandFolder/WinReg key/separator problem

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''                               ⍝ create the command
      r.Name←'Fire'                         ⍝ the name
      r.Desc←'Starts Fire (FInd & REplace)'
      r.Group←'APLTree'                     ⍝ In 14.0 this MUST NOT be empty!
     ⍝ Parsing rules for each:
      r.Parse←'1s -fl'                      ⍝ Takes one optional switch: force load
    ∇

    ∇ r←Run(Cmd Args);⎕IO;⎕ML;paths;thisPath;flag;l;dne;bool;regData;n;msg;success;neededModules
      :Access Shared Public
      ⎕IO←0 ⋄ ⎕ML←3 ⋄ ⎕WX←3
      r←0 0⍴''
      flag←Args.Switch'fl'
      neededModules←'APLTreeUtils' 'FilesAndDirs' 'OS' 'WinReg' 'GitHubAPIv3'   ⍝ to be copied
      '_Fire'⎕SE.⎕NS''
      dne←0=↑∘⎕SE.⎕NC¨neededModules                                             ⍝ do not exist (dne)
      :If flag
          :Trap 6 ⋄ ⎕SE._Fire.Fire.Cleanup ⋄ :EndTrap                           ⍝ Get rid of any GUI
          ⎕SE.⎕EX'_Fire'
          '_Fire'⎕SE.⎕NS''
      :EndIf
      :If 1∊dne
          (success msg)←ScanPathsFor⊃dne/neededModules
          :If 0=success
              msg ⎕SIGNAL 6
          :EndIf
          CreateRefs(~dne)/neededModules
      :EndIf
      :If 0=⎕SE._Fire.⎕NC'Fire'
          (success msg)←ScanPathsFor'Fire'
          :If 0=success
              msg ⎕SIGNAL 6
          :EndIf
      :EndIf
      :If ∨/bool←0=↑∘⎕SE._Fire.⎕NC¨neededModules
          ⎕←'Copy operation failed:'
          ⎕←⍪' ',¨bool/neededModules
          'Fire cannot be started'⎕SIGNAL 11
      :EndIf
      n←⎕SE._Fire.Fire.Run 0
      :If 1=⍴↑Args.Arguments
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

    ∇ r←{default}ReadRegKey key;wsh;⎕WX
     ⍝ Read a registry key. Uses a particular default path which can be _
     ⍝ overridden via the left argument
      :Access public shared
      ⎕WX←1
      default←{0<⎕NC ⍵:⍎⍵ ⋄ ''}'default'
      'wsh'⎕WC'OLEClient' 'WScript.Shell'
      :Trap 11
          r←wsh.RegRead key
      :Else
          r←default
      :EndTrap
    ∇

      Split←{
          ⎕ML←⎕IO←1
          ⍺←⎕UCS 13 10 ⍝ Default is CR+LF
          (⍴,⍺)↓¨⍺{⍵⊂⍨⍺⍷⍵}⍺,⍵
      }

      GetRegistryKey←{
          rk←'HKEY_CURRENT_USER\Software\Dyalog\Dyalog APL/W'
          rk,←('64'≡¯2↑0⊃'.'⎕WG'APLVersion')/'-64'
          rk,←' ',{⍵/⍨2>+\'.'=⍵}1⊃'.'⎕WG'APLVersion'
          rk,←(80=⎕DR' ')/' Unicode'
          rk,'\SALT\CommandFolder'
      }

    ∇ paths←GetPaths regKey;regData
      regData←ReadRegKey regKey
      ((regData∊'∘°')/regData)←';'
      ((regData='\')/regData)←'/'
      paths←';'Split regData
    ∇

    ∇ (success msg)←ScanPathsFor objects;paths;regKey;thisPath;object
      success←0
      regKey←GetRegistryKey ⍬
      paths←GetPaths regKey
      msg←'Cannot find the Fire workspace anywhere'
      :For thisPath :In paths
          :If ⎕NEXISTS thisPath,'\Fire\Fire.dws'
              :Trap 11
                  objects ⎕SE._Fire.⎕CY thisPath,'\Fire\Fire.dws'
                  success←1
                  msg←''
                  :Leave
              :Else
                  :For object :In ' '~¨⍨↓objects
                      :Trap 11
                          object ⎕SE._Fire.⎕CY thisPath,'\Fire\Fire.dws'
                      :Else
                          msg←'Module <',object,'> not found in ',thisPath,'\Fire\Fire.dws'
                      :EndTrap
                  :EndFor
              :EndTrap
              :Leave
          :EndIf
      :EndFor
    ∇

    ∇ {r}←CreateRefs list;this
      r←⍬
      :For this :In list
          ⍎'⎕SE._Fire.',this,'←','⎕SE.',this
      :EndFor
    ∇

:EndClass
