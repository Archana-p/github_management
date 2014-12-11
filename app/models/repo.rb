class Repo < ActiveRecord::Base
	belongs_to :user
	has_many :notifications

	def self.create_repo(user)
		#binding.pry
		@git_repos = Repo.fetch_github_repo(user)
    @git_repos.each do |repo|
      @new_repo = Repo.find_by(github_repo_id: repo["id"])
      unless @new_repo.present?
        @new_repo = Repo.create(github_repo_name: repo["name"],github_repo: repo["html_url"],github_repo_id: repo["id"] ,github_repo_description: repo["description"])
      end
      user.repos << @new_repo
    end
    @repo = @git_repos.group_by{|repo| repo["owner"]["login"]}
	end

	def self.fetch_github_repo(user)
		Github.repos.list user: user.name
	end

	def self.fetch_notifications(repo_id)
		Notification.where(repo_id: repo_id)
	end
end
