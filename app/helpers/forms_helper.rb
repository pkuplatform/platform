module FormsHelper
  def show_status(object)
    return 'still approving'   if object.status & Constant::Approving == Constant::Approving
    return 'Has been approved' if object.status & Constant::Approved  == Constant::Approved
    return 'Being rejected'    if object.status & Constant::Rejected  == Constant::Rejected
  end
end
