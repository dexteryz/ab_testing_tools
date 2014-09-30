class Test < ActiveRecord::Base
  attr_accessor :control_samples, :control_conversions, :var1_samples, :var1_conversions
  validates :control_samples, presence: true
  validates :control_conversions, presence: true
  validates :var1_samples, presence: true
  validates :var1_conversions, presence: true

  def self.calculate(control_samples, control_conversions, var1_samples, var1_conversions)
    values = {}
    
    control_nonconv = control_samples.to_s.to_i - control_conversions.to_s.to_i
    variation_nonconv = var1_samples.to_s.to_i - var1_conversions.to_s.to_i
    
    values[:control] = { :conversions => control_conversions.to_s.to_i, :nonconv => control_nonconv } 
    values[:variation1] = { :conversions => var1_conversions.to_s.to_i, :nonconv => variation_nonconv }
      
    tester = ABAnalyzer::ABTest.new values
    
    begin
      # are the two significant?
      result = tester.different?
    rescue ABAnalyzer::InsufficientDataError 
      result = "Result not available"
    end
    
    return result
  end
end
