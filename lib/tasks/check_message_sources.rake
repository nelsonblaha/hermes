desc "check for new messages"
task :check => :environment do
	RssFeed.all.each do |rss|
		begin
			rss.check(rss.user)
		rescue
			"could not check RSS feed: "+rss.name
		end
	end
end