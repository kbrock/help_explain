class Plan
  include ActiveModel::Conversion

  # @api private
  attr_accessor :attr

  def initialize(hash)
    hash = JSON.parse(hash) if hash.is_a?(String)
    @attr = hash
    @attr = @attr.first if hash.is_a?(Array)
  end

  def [](name)
    @attr[name]
  end

  def valid?
    @attr.present?
  end

  def plan_summary
    node.total_type
  end

  def node
    @plan_node ||= PlanNode.new(self["Plan"] || "{}")
  end

  def total_time
    self["Total Runtime"]
  end

  def self.clean(str)
    str.gsub(/\r/,'')
       .gsub(/ *\+?$/,'')
       .gsub(/^  */,'')
       .gsub(/^-*$/,'')
       .gsub(/^QUERY PLAN$/,'')
       .gsub(/^vmdb_development.*$/,'')
       .gsub(/^$\n/,'')
       .gsub(/^\(.+ rows?\)$/,'')
  end
end
