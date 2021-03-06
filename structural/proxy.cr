# The proxy pattern is a design pattern that creates a surrogate,
# or placeholder class. Proxy instances accept requests from client objects,
# pass them to the underlying object and return the results.

# The class we're going to proxy
class FighterGenerator
  def initialize(@ai_level : AILv)
    puts "Initializing FighterGenerator with AI level = #{@ai_level}"
  end

  def generate(fighter_name : String)
    Fighter.new(fighter_name, @ai_level)
  end
end

class Fighter
  def initialize(@name : String, @ai_level : AILv)
    puts "Creating new fighter #{@name} with ai level #{@ai_level}"
  end
end

enum AILv
  Easy
  Medium
  Hard
end

# The proxy class. There are several types of proxies: in this case, we use
# a *cache proxy*, which memoizes the created fighters and returns
# them without creating new ones if possible.
class FighterGeneratorProxy
  def initialize(ai_level : AILv)
    @generator = FighterGenerator.new(ai_level)
    @cache = {} of String => Fighter
  end

  # The proxy's interface mimics that of the proxied class
  def generate(fighter_name : String)
    puts "Requested fighter #{fighter_name}"
    return @cache[fighter_name] if @cache.has_key?(fighter_name)
    @generator.generate(fighter_name).tap { |fighter| @cache[fighter_name] = fighter }
  end
end

generator = FighterGeneratorProxy.new(AILv::Hard)
generator.generate("Sub-Zero")
generator.generate("Scorpion")
generator.generate("Johnny Cage")
generator.generate("Sub-Zero")
generator.generate("Kitana")
generator.generate("Raiden")
generator.generate("Scorpion")
generator.generate("Raiden")
generator.generate("Johnny Cage")
generator.generate("Kitana")

# Initializing FighterGenerator with AI level = Hard
# Requested fighter Sub-Zero
# Creating new fighter Sub-Zero with ai level Hard
# Requested fighter Scorpion
# Creating new fighter Scorpion with ai level Hard
# Requested fighter Johnny Cage
# Creating new fighter Johnny Cage with ai level Hard
# Requested fighter Sub-Zero
# Requested fighter Kitana
# Creating new fighter Kitana with ai level Hard
# Requested fighter Raiden
# Creating new fighter Raiden with ai level Hard
# Requested fighter Scorpion
# Requested fighter Raiden
# Requested fighter Johnny Cage
# Requested fighter Kitana
