class Object
  alias_method :to_clo_s, :inspect
end

class Symbol
  alias_method :to_clo_s, :inspect
end

class Hash
  def to_clo_s
    inspect.gsub('=>', '')
  end
end
