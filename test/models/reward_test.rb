require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  test 'A reward can be created' do
    project = new_project
    project.save
    reward = build(:reward,dollar_amount: 99.00,description: 'A heartfelt thanks!',project: project)
    reward.save
    assert reward.valid?
    assert reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do
    project = new_project
    project.save
    reward = build(:reward,description:'A heartfelt thanks!',project: project)
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    project = new_project
    project.save
    reward = build(:reward,dollar_amount: 99.00,project: project)
    reward.save
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  def new_project
    build(:project,title:'Cool new boardgame',description: 'Trade sheep',start_date:Date.today,end_date:Date.today + 1.month,goal:50000)
  end

end
