require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = create(:user)
    project = build(:project, owner: owner)
    assert project.valid?
  end

  test 'project is invalid without owner' do
    project = build(:project, owner: nil)
    # project = new_project
    # project.user = nil
    # project.save
    assert project.invalid? 'Project should not save without owner.'
  end

end
