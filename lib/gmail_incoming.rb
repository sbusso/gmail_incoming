require "gmail_incoming/version"

module GmailIncoming

  def self.find_hotmail(user, password)
    fetch(user, password, :from => 'staff@hotmail.com', :delete => true) do |mail|
      mail.message.body.raw_source.scan(/OriginalRecipient:(.*)/)[0][0].strip
    end
  end

  def self.find_bounced(user, password)
    fetch(user, password, delete: true) do |mail|
      mail.message.bounced? ? (mail.message.final_recipient.gsub('rfc822;','').strip.to_s rescue nil) : nil
    end
  end

  private

  def self.fetch(user,password, filters = nil, &block)
    delete = filters.is_a?(Hash) && filters[:delete]
    filters.delete(:delete) if delete
    array = Array.new
    Gmail.connect(user, password) do |gmail|
      gmail.inbox.emails(:unread, filters).each do |mail|
        result = block.call(mail)
        (result && false && delete ? mail.delete! : mail.mark(:unread)) rescue nil
        array << result
      end
    end
    array.compact.uniq
  end
end
