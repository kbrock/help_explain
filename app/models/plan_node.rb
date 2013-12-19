class PlanNode
  include ActiveModel::Conversion

  @known_attributes=[]
  def self.hash_accessor(key_name, method_name=nil)
    method_name ||= key_name.gsub(/ (.)/) {$1.upcase}.underscore

    define_method(method_name) do
      self[key_name]
    end
    @known_attributes << key_name
  end

  def self.ignore_attribute(key_name)
    @known_attributes << key_name
  end

  def self.known_attributes
    @known_attributes
    #["Plans","Output", "Filter", "Index Cond"]
    #["Plans", "Output"]
  end

  attr_accessor :id
  attr_accessor :parent_id
  attr_accessor :attr

  ignore_attribute "Parent Relationship" #==> Outer/ Member / SubPlan

  def initialize(hash, parent_id=nil)
    @attr = hash
    @parent_id = parent_id
    @id = self.class.next_id
  end

  def [](name)
    @attr[name]
  end

  hash_accessor "Node Type", "type"

  #UI - belongs in decorator
  def name
    case(type)
    when "Bitmap Index Scan", "Index Only Scan", "Bitmap Heap Scan"
      "#{type} #{index_name||relation_name} #{scan_direction}" #index_cond
    when "Sort"
      "#{sort_method.titleize} #{sort_space_type} #{sort_space_used}k"
    else
      "#{subplan_name} #{type}"
    end
  end

  ignore_attribute "Plans"
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

  # plan
  hash_accessor "Startup Cost", "plan_child_cost"
  hash_accessor "Total Cost", "plan_total_cost"

  # My cost
  def plan_cost
    children? ? plan_total_cost - plan_child_cost : plan_total_cost
  end

  hash_accessor "Plan Rows"
  hash_accessor "Plan Width"

  # available for analyze plans
  hash_accessor "Actual Startup Time", "actual_child_time"
  hash_accessor "Actual Total Time"

  # My time
  def actual_time
    children? ? actual_total_time - actual_child_time : actual_total_time
  end

  hash_accessor "Actual Rows"
  hash_accessor "Actual Loops"

  # indexing
  hash_accessor "Index Name"

  ignore_attribute "Index Cond"
  #remove schema,table_name and casting
  def index_cond?
    !! self["Index Cond"]
  end

  def index_cond
    SqlText.simplify_filter(self["Index Cond"])
  end

  #fields used to filter
  ignore_attribute "Filter"
  def filter?
    !! self["Filter"]
  end

  def filter
    SqlText.simplify_filter(self["Filter"])
  end

  hash_accessor "Rows Removed by Filter", "filter_removed"

  # sorting
  def sort?
    type =~ /Sort/
  end

  ignore_attribute "Sort Key"
  def sort_keys?
    !! self["Sort Key"]
  end

  def sort_keys
    self["Sort Key"].collect {|key| SqlText.simplify_filter(key)}
  end

  hash_accessor "Sort Method" #quicksort - is this relevant?
  hash_accessor "Sort Space Used"
  hash_accessor "Sort Space Type"
  #what is the heap scan accessing?
  hash_accessor "Relation Name"
  ignore_attribute "Schema"
  ignore_attribute "Alias"

  # scanning
  ignore_attribute "Recheck Cond"
  def recheck_cond?
    !! self["Recheck Cond"]
  end

  def recheck_cond
    SqlText.simplify_filter(self["Recheck Cond"])
  end

  hash_accessor "Rows Removed by Index Recheck", "recheck_removed" #not currently usable
  hash_accessor "Scan Direction"

  hash_accessor "Strategy", "scan_strategy"
  hash_accessor "Subplan Name"
  ignore_attribute "Heap Fetches" #!!

  #UI
  def flag
    "severe-query" if scan_whole_table?
  end

  def scan?
    type =~ /Scan/
  end

  def scan_whole_table?
    scan? && index_name.nil?
  end

  # the difference between planned rows and actual rows
  # if this is too far off, may have leaned too hard on startup costs and chosen wrong method
  def diff_rows
    actual_rows.to_f / plan_rows unless actual_rows.nil? || plan_rows.nil?
  end

  # @return Array<String> array of table.columns returned from this filter
  # available for verbose plans
  hash_accessor "Output"

  @next_id = 0
  def self.next_id
    @next_id = (@next_id + 1) % 1000
  end
end
