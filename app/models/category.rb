class Category < ActiveRecord::Base
  has_many :groups

  def translated_name
    I18n.t(name, :scope => 'category')
  end
end
