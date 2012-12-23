module MessageSource
	def check(user)
		self.new_messages.each do |message|
			message.traits_hash += 'source:'
			user.rules.each do |rule|
				rule.process(message)
			end
		end
	end
end