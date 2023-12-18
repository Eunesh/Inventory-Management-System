class Inventory

  #Setter for quantity object
  attr_writer :quantity

  def initialize(quantity)
    @hash = {}
    @info =[]
    @quantity = quantity
  end

  def add_info(name, age, info)
    @hash[name] = {'name'=> name, 'age'=>age, 'info'=> info}
    @info.push(@hash[name])
  end

  # def update_info(name, new_name)
  #   # @hash[name] =

  # end

  # def quantity=(quantity)
  #   @quantity = quantity
  # end

  def show_quantity
    return @quantity.show_quantity
  end

  def info
    return @info
  end

end


# Interface class
class Quantity
  def show_quantity
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end


class HigherQuantity < Quantity
  def show_quantity
    puts 'higher'
  end
end


class LowerQunatity < Quantity
  def show_quantity
    puts "lower"
  end
end




inventory = Inventory.new(HigherQuantity.new)
inventory.quantity = LowerQunatity.new
inventory.show_quantity

# inventory.add_info( "unesh", 22, "sad")
# inventory.add_info("raju", 18, "exited")
# inventory.add_info("rohan", 30, "happy")


# puts inventory.info;
