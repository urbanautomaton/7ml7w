# Day 2: Tables all the way down

It's a Pratchett reference you see.

## Tables I suppose

Why have lots of different data structures when you could have one that
does everything? Why use your toothbrush to brush your teeth when you've
got a perfectly good toilet brush just sitting there? It's some sort of
cosmic mystery.

It's a hash!

```lua
table = {a=3, b=5, wat='bananas'}
table.a -- 3
table.wat -- 'bananas'
```

It's a 1-indexed array!

```lua
table = {1,2,3,4,5,'pelican'}
table[1] -- 1
table[6] -- 'bananas'
```

It's both things at once!

```lua
table = {1,2,3,4,5,wat='bananas'}
table[1] -- 1
table.wat -- 'bananas'
```

We write a `print_table` function and observe `dofile('some_file.lua')`
which is apparently the equivalent of ruby's `load` (i.e. blind eval).

You can't have a key with a nil value it appears:

```
> print_table({wat = nil})
> 
```

in fact this even deletes things from existing tables:

```
> t = { a = 3 }
> t.a = nil
> print_table(t)
>
```

## Metatables

c.f. javascript's prototypes

```
> mt = { __tostring: function(t); return 'hello'; end }
> t = {1,2,3,4}
> setmetatable(t, mt)
> print(t)
hello
```

### Customising access

special functions `__index` and `__newindex` on the metatable

See [strict.lua](strict.lua).

We do this with a metatable on a single table:

```lua
metatable = { __index = strict_read, __newindex = strict_write }
```

And then defining the RHS functions. I was worried about this:

```lua
function strict_read(table, key)
  if _private[key] then
    return _private[key]
  else
    error('Unknown key: ' .. key)
  end
end
```

What about keys with nil values? Well, you cannae have them innit, see
above - setting a key to nil deletes it from the table.

### Customising more things

You can override lots more behaviour - comparison (`__eq`, `__lt`,...),
addition (`__add`), subtraction (`__sub`) and lots more. See the
[metatable events](http://lua-users.org/wiki/MetatableEvents) page from
t'wiki.

## Roll your own OO

Why not! Okay let's make a Dietrich:

```lua
dietrich = {
  name = "Dietrich",
  health = 100,

  take_hit = function(self)
    self.health = self.health - 10
  end
}
dietrich.take_hit(dietrich)
print(dietrich.health) -- 90
```

Jolly good. Keyword `self` sneaking in there we see. Okay let's make
another Dietrich:

```lua
clone = {
  name = dietrich.name,
  health = dietrich.health,
  take_hit = dietrich.take_hit
}
```

Pretty boring doing that manual copying though eh?

### Prototypes

Okay so we cobble together some sort of prototype class (see
[villain.lua](villain.lua)). We keep having to pass the object to its own
self though, which seems annoying:

```lua
dietrich = Villain.new(Villain, 'dietrich')
dietrich.take_hit(dietrich)
dietrich.health -- 90
```

We get inheritance sorta for free just by building a new prototype out
of the old one:

```lua
SuperVillain = Villain.new(Villain)

function SuperVillain.take_hit(self)
  self.health = self.health - 5
end

toht = SuperVillain.new(SuperVillain, 'toht')
toht.take_hit(toht)
toht.health -- 95
```

Passing objects twice is acknowledged as cumbersome. Hey, but we can
define table methods with an implicit `self` like so:

```lua
function Villain:new(name)
  -- ....
end
```

See [villain_native.lua](villain_native.lua) for deets:


```lua
dietrich = Villain:new('dietrich')
dietrich:take_hit()
dietrich.health -- 90
toht = SuperVillain:new('toht')
toht:take_hit()
toht.health -- 95
```

I lost a ton of time calling `thing.method()` instead of
`thing:method()` and I'm not sure I'm going to forgive lua for this but
oh well.

## COROUTINES THEN

Yes we all need to move on. Let's move on. LET'S.

Threads and coroutines: both run in parallel.

* **Threads**: up to the CPU (scheduler?) which runs at any given time?
* **Coroutines**: have to explicitly yield control.

This is an tradeoff - we're limited to a single core, but eliminate some
concurrency issues since we can see where control is transferred.

**NB** don't do blocking IO in these eh.

[scheduler censored]

## Exercises

1. Find luarocks

    ```
    $ which luarocks
    /usr/local/bin/luarocks
    ```

   There it is.

2. LOOP scheduler: http://loop.luaforge.net/library/thread/Scheduler.html

3. Metatable events: http://lua-users.org/wiki/MetatableEvents

4. Global variables kept in "the environment". But there's more than
   one! But ignore this! It's called `_G`! And `_G._G` is `_G`!

   Whatever. https://www.lua.org/pil/14.html
