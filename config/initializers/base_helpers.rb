class String
  def conv_base(from, to=10)
    self.to_i(from).to_s(to)
  end
  def to_bin(from=10)
  	self.conv_base(from,2)
  end
  def to_hex(from=10)
  	self.conv_base(from,16)
  end
  def to_oct(from=10)
  	self.conv_base(from,8)
  end
end
class Fixnum
  def conv_base(from, to=10)
    self.to_s(from)
  end
  def to_bin(from=10)
  	self.conv_base(from,2)
  end
  def to_hex(from=10)
  	self.conv_base(from,16)
  end
  def to_oct(from=10)
  	self.conv_base(from,8)
  end
end
class Array
  def writable(user)
    select{|c| user.can? :write, c}
  end
  def selectable(user)
    select{|c| user.can? :select, c}
  end
  def readable(user)
    select{|c| user.can? :read, c}
  end
  def deletable(user)
    select{|c| user.can? :delete,c}
  end
end