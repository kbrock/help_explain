class PlanNode
  include ActiveModel::Conversion

  attr_accessor :attr

  def initialize(hash)
    @attr = hash
  end

  def [](name)
    @attr[name]
  end

  def name ; self["Node Type"] ; end
  def children ; @children ||= self["Plans"].try(:collect){|plan| PlanNode.new(plan) } || [] ; end
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

  # @return Array<String> array of table.columns returned from this filter
  # available for verbose plans
  def output ; self["Output"] ; end
end
