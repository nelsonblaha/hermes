class MessageSourceController < ApplicationController
  def directory
  end

  def mine
  	@message_sources = RssFeed.where(user_id:current_user.id)
  end

  def check
  	message_source = MessageSource.find(params[:id])
  	message_source.check
  end
end
