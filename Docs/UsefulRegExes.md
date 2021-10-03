[parm]:toc      = 2
[parm]:saveHTML = 0 
[parm]:title    = 'Fire: Useful RegExes'



# Useful regular expressions

This document aims to collect regular expressions that are particularly useful to the APL programmer.

This is by no means an introduction into regular expressions. It just aims to give some tips for useful regular expressions, although it tries to explain how they work.

## Dotted names and `##`

Occasionally an APL programmer wants to find all occurrences of the string `##.`. For example:

~~~
##.MyClass.Fns 1       ⍝ Should be found
##.##.MyClass2.Fns2 1  ⍝ Should be found, too
#.MyClass.OtherFns 1   ⍝ Should NOT be found
~~~

This can be achieved with this regular expression:

~~~
##\.
~~~

If you want to find all occurrences of `##.##.` but neither `#.` nor `##.##.##` etc then this would do:

~~~
##\.##\.(?!#)
~~~

If on the other hand you want to find all references to `#.` but **not** `##.` and `##.##` etc:

~~~
(?<![#.])#\.(?!#)
~~~

### Explanation{#10}

Let's analyze `(?<![#.])#\.(?!#)` :

1. `(?<` together with the closing `)` forces the regular expression engine to look to the left of the current position. This is called  a look-behind.

   The `![#.]` part reads "neither a `.` nor a `#`". Only when this condition is met would the RegEx engine carry on trying to find a match, otherwise it would give up and move one character forward and start again.

2. It then tries to find a match for `#`. Only if this is true would the RegEx engine keep trying.

3. It then tries to find a `#` at the current position. 

4. If that succeeds it moves forward one character and then tries to find a dot. 

5. If that's successfull the RegEx engine would perform a look-ahead. That means it looks one character ahead without actually moving the current position, no matter whether it's a match or not. It's the `(?` part (together with the closing `)`) that does this.

   The `!#!` bit reads "is not a `#`". 

Only if all these checks are successful will the engine finally signal a hit.

### Tests{#1}

~~~
      myRegEx←'(?<![#.])#\.(?!#)'
      ⍴ myRegEx ⎕s 0 ⊣ '#.NS1.NS2.Fns 1'
1
      ⍴ myRegEx ⎕s 0 ⊣ '#.#.NS1.NS2.Fns 1'
0
      ⍴ myRegEx ⎕s 0 ⊣ '##.NS1.NS2.Fns 1'
0
      ⍴ myRegEx ⎕s 0 ⊣ '##.##.NS1.NS2.Fns 1'
0
      ⍴ myRegEx ⎕s 0 ⊣ '##.##.#.NS1.NS2.Fns 1'
0
~~~


## Finding specific numbers

Imagine you want to search for a specific number like `123`. You don't want to find the negative version of if (`¯123`) but you want to find it at the beginning of a line as well as the end, and also as part of a word as in `abc123xyz`.

This can be achieved with this regular expression:

~~~
'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ data
~~~

### Explanation{#20}

What is this doing:

1. `(?<` together with the closing `)` forces the regular expression to check the position to the left of the current position; that's called a look-behind.

   It then performs three checks defined by what's between the two square brackets: 

   * `0-9` stands for all digits from 0 to 9

   * `¯` stands for itself: the APL character used to indicate a negative value.

   * `-` stands for itself: the "normal" minus character.

   We add `¯` and `-` because we don't want to find any negative numbers. 

3. We add a `!` because we need to negate the result of the checks.

4. If there is a match then the engine checks whether there is a `1` at the current position. If that's the case then it moves on to the next character and checks for a "2" etc. until it has matched the `3`.

5. Finally it checks whether the next character is either not a digit (`[^0-9]`) or (logical OR is represented by the `|` symbol) an end of line character; that's what the `$` stands for.


### Tests{#2}

~~~
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ '123'
1
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ ' 123'
1
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ '123 '
1
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ '123 123'
2
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ '123 123 ¯123'
2
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣ '123 123 ¯123 123abc123'
4
      ⍴'(?<![0-9¯-])123([^0-9]|$)'⎕S 0 ⊣'1234'
0
~~~


## Find a word

If you look for "it" but you are not interested in "itself" and "initially" then you can use word boundaries: `\b`:

~~~
      ⍴'\bit\b'⎕S 0 ⊣'This was it, initially. In itself it was...'
2
~~~

However, by default word boundaries are defined by the ANSI character set. That means that it's not going to work in case Unicode characters are involved. For example:

~~~
      ⍴'\bit\b'⎕S 0 ⊣'itßelf'
1
~~~

`ß` is a Unicode but not an ANSI character; it is therefore considered a word boundary by the RegEx engine. Luckily with version 16.0 of Dyalog APL a new version of the underlying PCRE library is shipped, and this version offers the option to use Unicode properties for word boundaries.

This new feature can be switched on and off with the "UCP" option which was introduced in version 16.0:

~~~
      ⍴'\bit\b'⎕S 0⍠('UCP' 1)⊣'itßelf'
0
~~~

The default is 0 in order to make sure that the behaviour does not change but naturally when using the Unicode version of Dyalog you will almost certainly change it to 1. Fire does in fact use 1 as the default and does not show the option at all because the Classic version of Dyalog APL is not supported anyway.