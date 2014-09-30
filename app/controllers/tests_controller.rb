class TestsController < ApplicationController
  
  def index
    
  end
  
  def create
    @result = Test.calculate(params[:control_samples], params[:control_conversions], params[:var1_samples], params[:var1_conversions])
  end
  
end