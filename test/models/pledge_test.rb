require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do
    pledge = create(:pledge)
    assert pledge.valid?
  end

  test 'owner cannot back own project' do
    owner = create(:user)
    project = create(:project, :owner => owner)
    pledge = build(:pledge, user: owner, project: project, dollar_amount: 3.00)
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

end
