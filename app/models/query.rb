class Query < ActiveRecord::Base
  before_validation :clean_sql
  before_validation :clean_plan

  validates_presence_of %w(name sql plan)

  validate :parsable_json

  def plan_summary
    "good stuff"
  end

  def plan_node
    @plan_node ||= PlanNode.new(plan_json["Plan"] || "{}")
  end

  def total_time
    plan_json["Total Runtime"]
  end

  def plan_json
    @plan_json ||= JSON.parse(plan)[0] || {}
  end

  private

  def parsable_json
    begin
      JSON.parse(plan) || true
    rescue
      errors.add(:plan, "invalid json")
    end
  end

  # remove extra whitespace and explain statement
  def clean_sql
    if sql.present?
      self.sql=self.sql
        .gsub(/^vmdb_development.=/,'')
        .gsub(/^$\n/,'')
        .gsub(/\Aexplain.*(select|update|insert|delete)/i) {$1}
    end
  end

  def clean_plan
    if plan.present?
      self.plan=self.plan
        .gsub(/\r/,'')
        .gsub(/ *\+?$/,'')
        .gsub(/^  */,'')
        .gsub(/^-*$/,'')
        .gsub(/^QUERY PLAN$/,'')
        .gsub(/^vmdb_development.*$/,'')
        .gsub(/^$\n/,'')
        .gsub(/^\(.+ rows?\)$/,'')
    end
  end
end
