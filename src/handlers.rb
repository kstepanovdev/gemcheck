class BaseHandler
  require 'gems'
  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def call(bot_request)
    return successor.call(bot_request) unless can_handle?(bot_request)

    handle(bot_request)
  end
end
    
class LatestHandler < BaseHandler
  private

  def handle(bot_request)
    (Gems.latest_version bot_request.gem_name)['version']
  end

  def can_handle?(bot_request)
    bot_request.command == 'latest'
  end
end

class ExistsHandler < BaseHandler
  private

  def handle(bot_request)
    (Gems.search bot_request.gem_name).empty? ? 'Gem hasn\'t found' : 'Gem exists'
  end

  def can_handle?(bot_request)
    bot_request.command.nil?
  end
end

class VersionsHandler < BaseHandler
  private

  def handle(bot_request)
    (Gems.versions bot_request.gem_name).map { |el| el['number'] }.join("\n")
  end

  def can_handle?(bot_request)
    bot_request.command == 'versions'
  end
end

class DownloadsHandler < BaseHandler
  private

  def handle(bot_request)
    (Gems.total_downloads bot_request.gem_name)[:total_downloads]
  end

  def can_handle?(bot_request)
    bot_request.command == 'downloads'
  end
end

class ErrorHandler < BaseHandler
  private

  def handle
    'Error'
  end

  def can_handle?
    true
  end
end
