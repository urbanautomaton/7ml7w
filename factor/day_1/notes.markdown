# Factor Day 1

Stack based, RPN, so e.g.

```factor
42 f g h
```

so `f` pops 42 off the stack, does whatever `f` does to it, then pushes
the result back onto the stack. Then `g` goes, etc. etc.

Oh and we're calling functions "words" now because... well, because.

Contrast this with e.g. JS where the same thing would be `h(g(f(42)))`.
You "apply" each function to the result of the previous one. In factor,
you just concatenate the functions. factor is thus "concatenative"
whereas JS is "applicative".

Apparently Forth and some other languages are like this too
(postscript! we all use postscript).

It's a bit like a big ol' bash pipeline, except you don't even have to
write pipes, it's just assumed.

## Getting started

There's a REPL. Also a GUI, called, not at all sinisterly, The Listener.

Hello world, then.

```factor
"hello, world" print ! this is a comment
```

So as we said, "hello, world" is pushed onto the stack. `print` then
pops it off and does printy stuff to it. Nothing is pushed back because
`print` is just about side-effects.

## Math

We've seen a function (okay okay dad, "word") that pops one value off
the stack. There's also `.` word that takes a value off the stack and
pretty-prints it (`print` seems to expect strings).

```factor
42 5 + . ! prints "47"
```

You can keep on going without parentheses cos it's all postfix

```factor
20 9 * 5.0 / 32 + . ! prints "68.0"
```

## Data types

Strings, numbers, bools, sequences

### Bools

`t` and `f`, nuff said

```factor
4 2 = . ! prints "f"
```

### Sequences

Much like lua, `{ 1 2 3 4 }`

Maps are lists of lists where the inner lists are pairs, e.g. `{ { "one"
1 } { "two" 2 } }`. Then you use the `of` word with the map and the key
to extract values:

```factor
{ { "one" 1 } { "two" 2 } } "one" of . ! prints "1"
```

or the key then the map with `at`:

```factor
"one" { { "one" 1 } { "two" 2 } } at . ! prints "1"
```

### Quotations

You can put code on the stack using `[ quotes ]`, then execute it with
`call`:

```factor
20
[ 40 + ]
call . ! prints "60"
```

Apparently these are more fun when used with...

### Conditionals

The `if` word takes a value and two quotations, then calls the first if
the value is anything but `f` (so everything else is truthy?).

```factor
10 0 > [ "pos" ] [ "neg" ] if . ! prints "pos"
```

and you can use `?` if you've just got values and cba with quotations:

```factor
10 0 > "pos" "neg" ? . ! prints "pos"
```

If you cba with one of the clauses there's `when` and `unless`:

```factor
10 0 > [ "pos" . ] when ! prints "pos"
10 0 < [ "pos" . ] when ! does nuffin

-5 0 < [ "neg" . ] unless ! does nuffin
-5 0 > [ "neg" . ] unless ! prints "neg"
```

### Stack Shuffling

* `dup` duplicates a value on the stack
* `clear` clears the stack
* `drop` drops the top value
* `nip` drops the second-top value
* `swap` swaps the top two
* `over` duplicates the second value do the top
* `rot` rotates three values because obviously

```factor
1 dup ! stack: 1 1
1 2 clear ! stack:
1 2 drop ! stack: 1
1 2 nip ! stack: 2
1 2 swap ! stack: 2 1
1 2 over ! stack: 1 2 1
1 2 3 rot ! stack: 2 3 1
```

Apparently you mostly avoid this with combinators. Which we haven't met
yet. Fine.

### Higher-order words with combinators

HOLY SHIT

Okay that was p slick. Well played, book.
