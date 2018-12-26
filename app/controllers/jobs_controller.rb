class JobsController < ApplicationController
	before_action :authenticate_user!

  def index
  	@jobs = Delayed::Job.all
  end

  def view
  end
end
