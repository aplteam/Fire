# Release Notes

## 7.2.0

This release introduces the new option "Ignore references".

The reason for introducing this feature is that when you search for, say, `Foo` in a namespace `#.Goo` and there is a reference in `#.Goo` that points to a namespace `#.MyUtils` which contains a function `Foo` then this function would be reported as a hit although it lives in `#.MyUtils` rather than `#.Goo`.

Strictly speaking this is correct, but it is also unlikely to be the expected result. After all you've restricted the search for stuff within the namespace `#.Goo`!

With the new feature you can tell Fire to ignore such references. Because by default the check box is ticked the result is now most likely to be what you expect to see.