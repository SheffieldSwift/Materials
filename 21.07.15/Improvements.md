Ways the presentation could be improved.

* Add a discussion of Java's try-with-resources statement. [More info](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)
* In the Java `IOException` code, construction the exception with the actual invalid path.
* Move the Java code demonstrating the difficulty of knowing which lines throws to a new slide - it's too small when squashed into the bottom of a slide.
* Add a discussion of the pre 2.0 Swift `ResultType`. [More info](http://nomothetis.svbtle.com/error-handling-in-swift)
* In the "Handling Multiple NSErrors" code, a better example could be given of how passing the wrong `inout NSError?` could cause problems.
* Discuss how it is unclear whether you should subclass NSError or just customise through the `domain`, `code` and `userInfo`
* In another example of how to use `guard`, make the `path` argument optional and have the `guard` unwrap it.
* Introduce `defer` as an alternative to `final`. Discuss how it can be used outside of error throwing to great effect.
* Give a proper code example of using `try!` - with and then without an empty do-try block.
* Research: how do you know which kinds of errors a method can throw?