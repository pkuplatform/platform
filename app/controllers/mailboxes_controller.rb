class MailboxesController < ApplicationController
  include HasMailbox::Controllers::MethodHelpers
  layout 'profile'
end
