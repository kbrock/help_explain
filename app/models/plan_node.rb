class PlanNode
  cattr_accessor :global_id
  @next_id=1
  include ActiveModel::Conversion

  attr_accessor :id
  attr_accessor :parent_id
  attr_accessor :attr

  def initialize(hash, parent_id=nil)
    @attr = hash
    @parent_id = parent_id
    @id = self.class.next_id
  end

  def [](name)
    @attr[name]
  end

  def name ; self["Node Type"] ; end
  def children
    @children ||= self["Plans"].try(:collect) { |plan|
      PlanNode.new(plan, id)
    } || []
  end

  def children?
    children.present?
  end

  #ui - belongs in presenter
  def kind
    children? ? 'folder' : 'file'
  end

  # @return [Float] amount of time to startup filter - fixed cost
  def plan_startup_cost ; self["Startup Cost"] ; end
  def plan_total_cost ; self["Total Cost"] ; end
  def plan_rows ; self["Plan Rows"] ; end
  def plan_width ; self["Plan Width"] ; end

  # available for analyze plans
  def actual_startup_time ; self["Actual Startup Time"] ; end
  def actual_total_time ; self["Actual Total Time"] ; end
  def actual_rows ; self["Actual Rows"] ; end
  def actual_loops ; self["Actual Loops"] ; end

  def diff_rows
    actual_rows / plan_rows
  end

  # @return Array<String> array of table.columns returned from this filter
  # available for verbose plans
  def output ; self["Output"] ; end

  def self.next_id
    @next_id = (@next_id + 1) % 1000
  end
end
