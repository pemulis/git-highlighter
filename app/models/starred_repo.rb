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
end
