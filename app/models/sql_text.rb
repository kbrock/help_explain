class SqlText

  def self.clean(str)
    str.gsub(/^vmdb_development.=/,'')
       .gsub(/^$\n/,'')
       .gsub(/\Aexplain.*(select|update|insert|delete)/i) {$1}
  end
end
