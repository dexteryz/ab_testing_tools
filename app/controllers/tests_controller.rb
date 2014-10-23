class TestsController < ApplicationController

  def index
    
  end
  
  def create

  	# Create test matrix
    @test = Test.create_test(params[:control_samples], 
    	params[:control_conversions], 
    	params[:var1_samples], 
    	params[:var1_conversions])

    # Are the results significantly different?
    @sig_diff = Test.is_sig_diff?(@test)

    # Get conversion rates
    @control_cvr = Test.get_cvr(params[:control_samples], params[:control_conversions])
    @var1_cvr = Test.get_cvr(params[:var1_samples], params[:var1_conversions])

    # Get confidence intervals
    @control_ci_minus = Test.get_conf_interval(params[:control_samples], params[:control_conversions])[0] * 100
    @control_ci_plus = Test.get_conf_interval(params[:control_samples], params[:control_conversions])[1] * 100
    @var1_ci_minus = Test.get_conf_interval(params[:var1_samples], params[:var1_conversions])[0] * 100
    @var1_ci_plus = Test.get_conf_interval(params[:var1_samples], params[:var1_conversions])[1] * 100
  end
  
end