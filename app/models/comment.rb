class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  validates_presence_of :body
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  # acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user


  after_create :new_event

  def conv
    self.body = CGI::escapeHTML(self.body)
    self.body = body.gsub(/@([^\)@]*)\((\d+)\)/) do
      p = Profile.select("name").find($2)
      "<a href=\"/profiles/#{$2}\">@#{p.name}</a>"
    end
    save
  end

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>user_id,:action=>:post,:object_type=>"Comment",:object_id=>id)
    body.scan(/@([^\)@]*)\((\d+)\)/).each do |ru|
      if ru[1].to_i>0
        Event.create(:subject_type=>"User",:subject_id=>ru[1].to_i,:action=>:mentioned, :object_type=>"Comment", :object_id=>id)
      end
    end
    conv
  end


  def url
    return commentable.url
  end

end
