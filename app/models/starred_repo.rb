# == Schema Information
#
# Table name: starred_repos
#
#  id                :integer          not null, primary key
#  github_id         :integer
#  owner_login       :string(255)
#  owner_github_id   :integer
#  owner_avatar_url  :string(255)
#  owner_gravatar_id :string(255)
#  owner_url         :string(255)
#  name              :string(255)
#  full_name         :string(255)
#  description       :string(255)
#  private           :boolean
#  fork              :boolean
#  url               :string(255)
#  html_url          :string(255)
#  clone_url         :string(255)
#  git_url           :string(255)
#  ssh_url           :string(255)
#  svn_url           :string(255)
#  mirror_url        :string(255)
#  homepage          :string(255)
#  language          :string(255)
#  forks             :integer
#  forks_count       :integer
#  watchers          :integer
#  watchers_count    :integer
#  size              :integer
#  master_branch     :string(255)
#  open_issues       :integer
#  pushed_at         :string(255)
#  github_created_at :string(255)
#  github_updated_at :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class StarredRepo < ActiveRecord::Base
  has_and_belongs_to_many :users



  # Instance methods ahoy
  def get_repo_data(client, repo=self)
    # Octokit client grabs data from GitHub
    o = client.repo(repo.full_name)

    # Fill in the repo data
    repo.github_id = o.id
    repo.owner_login = o.owner.login
    repo.owner_github_id = o.owner.id
    repo.owner_avatar_url = o.owner.avatar_url
    repo.owner_gravatar_id = o.owner.gravatar_id
    repo.owner_url = o.owner.url
    repo.name = o.name
    repo.description = o.description
    repo.private = o.private
    repo.fork = o.fork
    repo.url = o.url
    repo.html_url = o.html_url
    repo.clone_url = o.clone_url
    repo.git_url = o.git_url
    repo.ssh_url = o.ssh_url
    repo.svn_url = o.svn_url
    repo.mirror_url = o.mirror_url
    repo.homepage = o.homepage
    repo.language = o.language
    repo.forks = o.forks
    repo.forks_count = o.forks_count
    repo.watchers = o.watchers
    repo.watchers_count = o.watchers_count
    repo.size = o.size
    repo.master_branch = o.master_branch
    repo.open_issues = o.open_issues
    repo.pushed_at = o.pushed_at
    repo.github_created_at = o.created_at
    repo.github_updated_at = o.updated_at
  end
end
