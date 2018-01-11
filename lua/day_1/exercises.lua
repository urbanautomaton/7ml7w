function ends_in_3(num)
  return num % 10 == 3
end

print('10 ends in 3: ', ends_in_3(10))
print('13 ends in 3: ', ends_in_3(13))

function is_prime(num)
  for i = 2, math.ceil(math.sqrt(num)) do
    if (num % i) == 0 then
      return false
    end
  end
  return true
end

print('is_prime(5): ', is_prime(5))
print('is_prime(6): ', is_prime(6))
print('is_prime(9): ', is_prime(9))
print('is_prime(13): ', is_prime(13))

function first_n_primes_ending_in_3(count)
  local current = 2
  local found = 0
  while found < count do
    if ends_in_3(current) and is_prime(current) then
      print(current)
      found = found + 1
    end
    current = current + 1
  end
end

print('First 5 primes ending in 3:')
first_n_primes_ending_in_3(5)

function for_loop(a, b, f)
  local current = a
  while current <= b do
    f(current)
    current = current + 1
  end
end

for_loop(1, 10, print)

function reduce(max, init, f)
  local current = 1
  local acc = init
  while current <= max do
    acc = f(acc, current)
    current = current + 1
  end
  return acc
end

function add(a, b)
  return a + b
end

print(reduce(5, 0, add))

function factorial(n)
  local mult = function(a, b)
    return a * b
  end
  return reduce(n, 1, mult)
end

print(factorial(10))
