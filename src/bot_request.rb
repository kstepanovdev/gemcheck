class BotRequest
  attr_reader :gem_name, :command

  def initialize(gem_name, command)
    @gem_name = gem_name
    @command = command
  end
end
