class Query < ActiveRecord::Base
  before_validation :clean_sql
  before_validation :clean_plan

  validates_presence_of %w(name sql plan)

  def plan_summary
    "good stuff"
  end

  private

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
