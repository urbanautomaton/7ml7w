# Lua Notes

## Day 1

String concatenation:

```
> 'hello ' .. 'fish'
hello fish
```

functions:

```
> function triple(value)
>> return 3 * value
>> end
> triple(3)
9
```

functions as first-class values:

```
> function call_twice(f)
>> return function(value)
>>   return f(f(value))
>> end
>> end
> call_twice(triple)(3)
27
```

JS-style don't-care-how-many-arguments-you-give-me:


```
> function two_sheds(shed_1, shed_2)
>> print(shed_1)
>> print(shed_2)
>> end
> two_sheds('hello')
hello
nil
> two_sheds('hello', 'you', 'swine')
hello
you
```

Explicitly variadic functions:

```
> function n_sheds(shed_1, ...)
>> print(shed_1)
>> print({...})
>> end
> n_sheds('a', 'b', 'c', 'd')
a
table: 0x7f9282c14310
```

Multiple return values:

```
> function things()
>> return 'hello', 'roger'
>> end
> a = things()
> print(a)
hello
> a, b, c = things()
> a
hello
> b
roger
> c
nil
```

Tables as kwargs:

```
> function popcorn_prices(table)
>> print('A medium popcorn costs ' .. table.medium)
>> end
>
> popcorn_prices{small=5.00,
>> medium=7.00,
>> jumbo=15.00}
A medium popcorn costs 7
```

Variable scope: global by default!

```
> function wat()
>> a = 'hello'
>> end
> wat()
> a
hello
```

use `local` keyword to prevent:

```
> function foo()
>> local fish = 'hello'
>> end
> foo()
> fish
nil
```
