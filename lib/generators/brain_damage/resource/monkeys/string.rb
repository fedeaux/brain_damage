class String
  def indent(level, spaces_per_level = 2)
    self.gsub(/^/, ' ' * spaces_per_level * level)
  end

  def indent!(level, spaces_per_level = 2)
    self.gsub!(/^/, ' ' * spaces_per_level * level)
  end
end
