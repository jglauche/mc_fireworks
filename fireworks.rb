#!/usr/bin/env ruby

# n, max size
# 1, 12
# 2, 21
# 3, 30
def random_colors(n)
  colors = []
  n.times do
    colors << rand(0..255*255*255)
  end
  return "[I;"+colors.join(",")+"]"
end

def gen_explosion
  type = rand(0..4)
  res = ["Type:#{type}"]

  res << "Flicker:1" if rand(0..1) == 1
  if rand(0..1) == 1
   res << "Trail:1"
   res << "FadeColors:#{random_colors(1)}"
  end
  res << "Colors:#{random_colors(rand(1..3))}"

  return "{#{res.join(",")}}"
end

def gen_explosions
  res = []
  rand(1..3).times do
    e = gen_explosion
    if e.size + res.join(",").size <= 255 - 63 - 1
      res << e
    end
  end
  "[#{res.join(',')}]"
end

# without explosion string, 61 chars (60 with single digit stack size)
def gen_rocket
  count = 64
  flight = rand(1..3)
  "/give @p firework_rocket{Fireworks:{Flight:#{flight},Explosions:#{gen_explosions}}} #{count}"
end

puts gen_rocket

