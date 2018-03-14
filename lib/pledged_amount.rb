module pledged_amount
  def pledged_amount
    running_total = 0
    pledges.each do |pledge|
      running_total += pledge.dollar_amount
    end
    running_total
  end
end
