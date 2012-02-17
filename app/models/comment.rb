class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  # acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  after_create :new_event

  def conv
    self.body = CGI::escapeHTML(self.body)
    while body =~ /@([^\)]*)\((\d+)\)/ do
      u = User.find(body.match(/@([^\)]*)\((\d+)\)/)[2])
      if u
        self.body=self.body.sub(/@([^\)]*)\((\d+)\)/,"<a href=\"/profiles/#{u.id}\">@#{u.name}</a>")
      end
    end
    save
  end

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>user_id,:action=>:post,:object_type=>"Comment",:object_id=>id)
    body.scan(/@([^\)]*)\((\d+)\)/).each do |ru|
      if ru[1].to_i>0
        Event.create(:subject_type=>"User",:subject_id=>ru[1].to_i,:action=>:reminded, :object_type=>"Comment", :object_id=>id)
      end
    end
    conv
  end


  def url
    return commentable.url
  end

end
