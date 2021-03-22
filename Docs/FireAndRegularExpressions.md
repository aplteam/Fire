[parm]:saveHTML          = 0
[parm]:title             = 'Fire RegEx'
[parm]:leanpubExtensions = 1


# Fire and Regular Expression

Fire supports Regular Expressions (RegEx). If you have never used them before you need to invest some time in order to master them. Be warned, it is everything but easy, but you will be rewared: RegEx are extremely powerful and allow you to do things with Fire that cannot be achieved by other means.

## Case Study I: Variables assignment 

**Change assignments to a variable no matter what else is to be found on that line.**

Imagine that in a namespace `#.TestCases` you have 100 or so test functions. All their names start with `Test_`.

In every one of them `R` (the explicit result variable) has the value 1 (for failure) assigned somewhere close to the top and the value 0 (for okay) somewhere at the end of the function.

You might want to assign the result of two niladic functions, `∆Failure` and `∆OK` to `R` instead of the integers.

If nothing else is contained on those lines then you don't need regular expressions at all, but unfortunately sometimes there is a comment on that line like `⍝ Failure` or `⍝ OK`, and the number of spaces between the integer and the `⍝` symbol may well vary.

This cannot be solved without Regular Expressions.

Here is what you would do:

1. Restrict the search to the namespace `#.TestCases`.
1. Enter `^.*R←0 *⍝.*$` into the "Search for" field .
1. Tick the box "Is RegEx".
1. Press the "Find" button.
1. Check the hit list and remove any functions that do not fit with the DEL key. You can also press F2 to get the hit report to make sure that you've got what you are looking for.
1. Click the "Replace" button.
1. Enter `R←∆OK` into the "Replace by" box.
1. Click the "Process" button.

That way you will replace `R←0` everywhere by `R←∆OK`.


## Case Study II: Search repeatedly for groups of characters

Assuming that you have a function `NGET` which is called in your deeply nested application by these statements:

```
test
 a1←↑NGET filename1
 a2←↑NGET filename2 ⋄ b1←↑##.NGET filename3
 a3←↑NGET filename4 ⋄ b2←↑##.NGET filename5 ⋄ c1←↑##.##.NGET filename6
 d1←↑##.##.##.NGET filename7
```

Imagine you have changed `⎕ML` everywhere from 3 to 1. Rather than using `↑` for _first_ you must now use `⊃`.

Obviously we need to make sure that the `##.` groups survive untouched no matter how often they occur in front of `NGET`.

You can find all those statements with

```
←↑((##\.)*)(NGET)
```

That would corretly find all the occurences.

Even better: with `←⊃\1\3` as a replace string you can convert all the `↑` into `⊃` without changing anything else.

That's because we can refer to groups with `\1` for the first group, `\2` for the second and so on, up to a maximum of 99 groups. 

The `()` around `(##.)` make sure that this is handled as a group. The `()*` around that group says: find that group zero or more times. Any number of times, actually.

A> ### Naming groups
A>
A> Adressing groups by number can get you into trouble in several ways:
A> * When you change your expression later it is easy to get it wrong
A> * When you need to search literally for a digit after group 1 to 9
A> * The numbers are not exactly telling
A>
A> You can get around these problems by naming groups:
A>
A> `←↑(?<hashes>(##\.)*)(?<fnsCall>NGET)`
A>
A> The name of the first group is "hashes", the second group's name is "fnsCall"
A>
A> The corresponding replace string would read:
A>
A> `←⊃\<hashes>\<fnsCall>`

```