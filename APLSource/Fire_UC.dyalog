:Class  Fire_UC
⍝ User Command script for "Fire"
⍝ Checks whether Fire is already loaded into ⎕SE.Fire.
⍝ If this is the case then Fire is started.
⍝ If this is not the case then Fire is copied into []SE from
⍝ the same directory the User Command stems from and then started.
⍝ Kai Jaeger
⍝ * Version 4.2.0 - 2025-12-07
⍝   * Does not load Tatin packages anymore.
⍝ * Version 4.1.0 - 2024-08-14
⍝   * Syntax enhanced
⍝     * "Start looking here" can now be any namespace
⍝     * Optional second argument can define "Search for"
⍝ * Version 4.0.1 - 2022-08-30
⍝   * The user command was moved into the folder Fire/, and that required some changes.
⍝ * Version 4.0.0 - 2021-03-19
⍝   * BREAKING CHANGES
⍝     * Requires at least version 18.0 Unicode of Dyalog
⍝     * Requires Tatin to be available
⍝ * Version 3.0.0 - 2020-11-29
⍝   * BREAKING CHANGE: requires now the class APLTreeUtils2 rather than the namespace script APLTreeUtils
⍝ * Version 2.7.2 - 2020-07-28
⍝   * Prevents the ]Fire user command to show under other OS's than Windows.
⍝ * Version 2.7.1 - 2020-01-22
⍝   * Bug fix: the  ]fire .  had stopped working with version 8.0.0
⍝ * Version 2.7.0 - 2020-01-22
⍝   Now the user command checks whether the minimum requierements (Dyalog Version) are met.
⍝   In the past an attempt to use Fire from a version that was too old resulted in a
⍝   misleading error message.

    :Field Private Shared ReadOnly MinimumVersionOfDyalogNeeded←18

    ⎕IO←1 ⋄ ⎕ML←1 ⋄  ⎕WX←3

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      :If 'W'=⊃⊃'#'⎕WG'APLVersion'
      :AndIf AtLeastVersion MinimumVersionOfDyalogNeeded
      :AndIf IsUnicode
          r←⎕NS''                               ⍝ create the command
          r.Name←'Fire'                         ⍝ the name
          r.Desc←'Starts Fire (FInd & REplace)'
          r.Group←'WS'
          ⍝ Parsing rules:
          r.Parse←'2s -fl -noGUI'
      :Else
          r←⍬                                   ⍝ Fire is a Windows0only application
      :EndIf
    ∇


    ∇ r←Run(Cmd Args);forceLoadFlag;noGUIFlag;fireIsAvailable
      :Access Shared Public
      :If ~AtLeastVersion MinimumVersionOfDyalogNeeded
          11 ⎕SIGNAL⍨'Fire needs at least version ',MinimumVersionOfDyalogNeeded,' of Dyalog APL'
      :EndIf
      r←0 0⍴''
      forceLoadFlag←Args.Switch'fl'
      noGUIFlag←Args.Switch'noGUI'
      fireIsAvailable←⎕NEXISTS(1⊃⎕NPARTS ##.SourceFile),'\Fire.dws'
      'Fire is not available'⎕SIGNAL 11/⍨~fireIsAvailable
      :If forceLoadFlag
          :Trap 6 ⋄ ⎕SE._Fire.Fire.Cleanup ⋄ :EndTrap                           ⍝ Get rid of any GUI
          ⎕SE.⎕EX'_Fire'
          ⎕SE.⎕EX'Fire'
          '_Fire'⎕SE.⎕NS''
          'Fire'⎕SE.⎕NS''
      :EndIf
      :If fireIsAvailable
          LoadFire Args forceLoadFlag noGUIFlag
      :EndIf
    ∇

    ∇ LoadFire(Args forceLoadFlag noGUIFlag);n;qdmx;searchString
      '_Fire'⎕SE.⎕NS''
      :If forceLoadFlag
      :OrIf 0=⎕SE._Fire.⎕NC'Fire'
          :Trap 11
              'Fire'⎕SE._Fire.⎕CY(1⊃⎕NPARTS ##.SourceFile),'\Fire.dws'
          :Else
              'Could not copy Fire'⎕SIGNAL 11
          :EndTrap
      :EndIf
      ⎕SE.Fire←⎕SE._Fire.Fire.API
      :If ~noGUIFlag
          searchString←{0≡⍵:'' ⋄ ⍵}Args._2
          n←⎕SE._Fire.Fire.Run 0 searchString
          :If 0<≢⊃Args.Arguments
              :If (,'.')≡,⊃Args.Arguments
                  n.StartSearchIn.Text←(⎕SI⍳⊂'UCMD')⊃⎕NSI
              :ElseIf ∨/(⊃Args.Arguments)∊'#⎕'
                  n.StartSearchIn.Text←⊃Args.Arguments
              :Else
                  n.StartSearchIn.Text←((⎕SI⍳⊂'UCMD')⊃⎕NSI),'.',⊃Args.Arguments
              :EndIf
              :If '['∊n.StartSearchIn.Text
              :OrIf ~((,n.StartSearchIn.Text)≡,'#')∨((1 ⎕C n.StartSearchIn.Text)≡'⎕SE')∨9=⎕NC n.StartSearchIn.Text
                  n.StartSearchIn.Text←'#'
              :EndIf
          :EndIf
      :EndIf
    ∇

    ∇ r←Help Cmd
      :Access Shared Public
      r←''
      r,←⊂'Starts Fire (FInd & REplace).'
      r,←⊂'Runs under Dyalog version ',MinimumVersionOfDyalogNeeded,' Unicode'
      r,←⊂'or later and requires the Dyalog package manager Tatin to be available.'
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
      r,←⊂'can use the -noGUI switch. Use this for an early load, for example.'
    ∇

    ∇ r←{x}AtLeastVersion min;⎕IO
      :Access Public Shared
      ⍝ Returns 1 if the currently running version is at least `min`.\\
      ⍝ If the current version is 17.1 then:\\
      ⍝ `1 1 1 0 ←→ AtLeastVersion¨16 17 17.1 18`\\
      ⍝ You may specify a version different from the currently running one via `⍺`:\\
      ⍝ `1 1 0 0 ←→ 17 AtLeastVersion¨16 17 17.1 18`
      ⎕IO←1 ⋄
      x←{0<⎕NC ⍵:⍎⍵ ⋄ {⊃⊃(//)⎕VFI ⍵/⍨2>+\⍵='.'}2⊃'#'⎕WG'APLVersion'}'x'
      'Right argument must be length 1'⎕SIGNAL 11/⍨1≠≢min
      r←⊃min≤x
    ∇

    ∇ r←IsUnicode
      r←80=⎕DR' '
    ∇

:EndClass
