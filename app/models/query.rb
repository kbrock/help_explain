class Query < ActiveRecord::Base
  before_validation :clean_sql
  before_validation :clean_plan

  validates_presence_of %w(name sql plan)

  validate :parsable_json

  delegate :plan_summary, :total_time, to: :query_plan

  def query_plan
    @query_plan ||= Plan.new(plan)
  end

  private

  def parsable_json
    errors.add(:plan, "invalid json") unless query_plan.valid?
  end

  # remove extra whitespace and explain statement
  def clean_sql
    self.sql=SqlText.clean(sql) if sql.present?
  end

  def clean_plan
    self.plan = Plan.clean(plan) if plan.present?
  end
end
