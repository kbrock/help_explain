class SqlText

  def self.clean(str)
    str.gsub(/^vmdb_development.=/,'')
       .gsub(/^$\n/,'')
       .gsub(/\Aexplain.*(select|update|insert|delete)/i) {$1}
  end

  def self.simplify_filter(str)
    str.gsub(/public\.\w*\./,'')
       .gsub(/::\w*/,'')
       .gsub(/\((\w*)\)/) { $1 }
  end
end
