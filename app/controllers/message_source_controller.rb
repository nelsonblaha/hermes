class MessageSourceController < ApplicationController
  def directory
  end

  def mine
  	@message_sources = RssFeed.where(user_id:current_user.id)
  end
end
