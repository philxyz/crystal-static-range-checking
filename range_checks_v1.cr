class RangeException < Exception
end

macro define_ranged_type(base_type, lower_bound, upper_bound)
  struct {{base_type}}__{{lower_bound}}_to_{{upper_bound}}
    @val : {{base_type}}
    
    getter val

    def initialize(ival : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}})
      if typeof(ival) == {{base_type}}
        if ival < {{lower_bound}} || ival > {{upper_bound}}
          raise RangeException.new("Assigned value lies outside the bounds of the type {{base_type}}__{{lower_bound}}_to_{{upper_bound}}")
        else
          @val = ival
        end
      else
        @val = ival.to_i
      end
    end

	  def +(other : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}) : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}
  	  tot = typeof(other)
  	  tot.new(@val.to_i + other.to_i)
    end

    def -(other : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}) : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}
  	  tot = typeof(other)
  	  tot.new(@val.to_i - other.to_i)
    end

    def *(other : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}) : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}
  	  tot = typeof(other)
  	  tot.new(@val.to_i * other.to_i)
    end

    def /(other : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}) : {{base_type}}__{{lower_bound}}_to_{{upper_bound}} | {{base_type}}
  	  tot = typeof(other)
  	  tot.new(@val.to_i / other.to_i)
    end

    def to_i
      @val
    end

  	def to_s(io : IO)
  	  io << val.to_s
	   end
  end
end

define_ranged_type(Int32, 2, 5)

a = Int32__2_to_5.new(4)
b = Int32__2_to_5.new(3)

puts a - b
