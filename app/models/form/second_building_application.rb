class Form::SecondBuildingApplication < ActiveRecord::Base

  belongs_to :group

  def approving
    self.status = Constant::Approving
    self.save
  end

  def approve
    self.status = Constant::Approved
    self.save
  end

  def reject
    self.status = Constant::Rejected
    self.save
  end

end
