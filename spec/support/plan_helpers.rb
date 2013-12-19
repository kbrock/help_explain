module PlanHelpers
  # @return json plan for select 1
  def select_plan_txt
 %{[
   {
     "Plan": {
       "Node Type": "Result",
       "Startup Cost": 0.00,
       "Total Cost": 0.01,
       "Plan Rows": 1,
       "Plan Width": 0,
       "Actual Startup Time": 0.000,
       "Actual Total Time": 0.000,
       "Actual Rows": 1,
       "Actual Loops": 1,
       "Output": ["1"]
     },
     "Triggers": [
     ],
     "Total Runtime": 0.007
   }
 ]}
  end

  def select_plan
    JSON.parse(select_plan_txt)
  end

  def complex_plan_txt
    @complex_plan_txt ||= File.read(File.join(Rails.root,"spec/data/query_plan_orig.json")).freeze
  end

  def complex_plan
    JSON.parse(complex_plan_txt)
  end

end

#TODO: get this into spec world or something
