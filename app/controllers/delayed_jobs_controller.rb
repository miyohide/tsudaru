class DelayedJobsController < ApplicationController
  def destroy
    dj = DelayedJob.find(params[:id])
    dj.destroy

    render template: "tweets/new"
  end
end
