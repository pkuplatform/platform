class Album < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
end
