class Object
  def to_clo_s
    inspect
  end
end

class Hash
  def to_clo_s
    '{' +
    map { |k, v| "#{k.to_clo_s} #{v.to_clo_s}" }.join('') +
    '}'
  end
end
