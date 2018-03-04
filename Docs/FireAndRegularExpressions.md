
WORK IN PROGRESS - it would be nice to have this working properly one day

# Fire and Regular Expression

Fire supports Regular Expressions (RegEx). If your have never used them before you need to invest some time in order to master them. Be warned, it is everything but easy, but you will be rewared: RegEx are extremely powerful and allow you to do things with Fire that cannot be achieved by other means.

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
1. Click the "Preview" button.

That way you will replace `R←0` everywhere by `R←∆OK`.
