class ReposController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @repos = Repo.search(params[:search],current_user)
    # @label,@project_series_data = Repo.project_commit_graph(current_user)
  end

  def show
    @repo = Repo.find_by(github_repo_name: params["id"])
    if @repo.present?
      @notifications = @repo.notifications
      @days_from_this_week = (7.days.ago.to_date..Date.today).map{|d| d.strftime("%d%b%Y")} 
      # @series_data = @repo.user_wise_commit_graph
      @user_wise_notifications =  @notifications.group_by{|commiter| commiter.commiter_name}
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end    
  end

  def active
    @repo = Repo.find_by(github_repo_id: params["id"])
    github = Github.new oauth_token: current_user.oauth_token
    hook = github.repos.hooks.create current_user.name, @repo.github_repo_name,
    name: "web",
    active: true,
    events: ['push', 'pull-request'],
    config: {
      url: "http://localhost:3000/payload",
      content_type: "json"
    }
    if hook.present?
      Webhook.create(hook_id:hook.id ,repo_id: @repo.id ,hook_url: hook.url,name: hook.name)
      redirect_to repos_path ,notice: "Webhook successfully created"
    else
      render :index
    end
  end
 
  # def deactivate
  #   binding.pry
  # end
end

# github = Github.new
# github.repos.hooks.create 'Archana-p', 'Youtube',
# name:  "web",
# active: true,
# events: ['push','pull-request'],
# config: {
# url: "http://localhost:3000/payload",
# content_type: "json"
# }
