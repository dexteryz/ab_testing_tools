class Test < ActiveRecord::Base
  attr_accessor :control_samples, :control_conversions, :var1_samples, :var1_conversions
  validates :control_samples, presence: true
  validates :control_conversions, presence: true
  validates :var1_samples, presence: true
  validates :var1_conversions, presence: true


  def self.create_test(control_samples, control_conversions, var1_samples, var1_conversions)
    values = {}
    
    control_nonconv = control_samples.to_s.to_i - control_conversions.to_s.to_i
    variation_nonconv = var1_samples.to_s.to_i - var1_conversions.to_s.to_i
    
    values[:control] = { :conversions => control_conversions.to_s.to_i, :nonconv => control_nonconv } 
    values[:variation1] = { :conversions => var1_conversions.to_s.to_i, :nonconv => variation_nonconv }
      
    ab_test = ABAnalyzer::ABTest.new values

    return ab_test
  end

  def self.is_sig_diff?(test)
    begin
      # are the two significant?
      sig_diff = test.different?
    rescue ABAnalyzer::InsufficientDataError 
      sig_diff = "Result not available"
    end
    
    return sig_diff
  end

  def self.get_cvr(samples, conversions)
    cvr = (conversions.to_f/samples.to_f) * 100
  end

  def self.get_conf_interval(samples, conversions)
    conf_interval = ABAnalyzer.confidence_interval(conversions, samples, 0.95)
  end
  
end
