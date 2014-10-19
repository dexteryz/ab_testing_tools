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

    # Get converison rates
    @control_cvr = Test.get_cvr(params[:control_samples], params[:control_conversions])
    @var1_cvr = Test.get_cvr(params[:var1_samples], params[:var1_conversions])
  end
  
end