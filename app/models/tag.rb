class Tag < ActiveRecord::Base
  belongs_to :tagable, :polymorphic => true
end
