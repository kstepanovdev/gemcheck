require_relative 'handlers'
require_relative 'bot_request'
require 'telegram/bot'

chain = ExistsHandler.new(LatestHandler.new(VersionsHandler.new(DownloadsHandler.new(ErrorHandler.new))))

Telegram::Bot::Client.run(ENV["GEMCHECK_TOKEN"]) do |bot|
  bot.listen do |message|
    gem_name = message.text.split[0]
    command = message.text.split[1]
    bot_request = BotRequest.new(gem_name, command)
    bot.api.send_message(chat_id: message.chat.id, text: chain.call(bot_request))
  end
end
