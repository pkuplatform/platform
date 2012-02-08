class Sms < ActiveRecord::Base
  belongs_to :group

  def st
    if status == 0
      return I18n.t 'success'
    else
      return I18n.t 'failure'
    end
  end
end
