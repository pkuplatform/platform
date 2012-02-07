module FormsHelper
  def show_status(object)
    return 'approving'   if object.status & Constant::Approving == Constant::Approving
    return 'approved' if object.status & Constant::Approved  == Constant::Approved
    return 'rejected'    if object.status & Constant::Rejected  == Constant::Rejected
  end
end
