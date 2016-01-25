
class Console


  def self.take(message)
    print message.light_yellow
    gets.chomp
  end

  # Messages to player
  def self.inform(str, color = "cyan")
    print "\n#{str.public_send(color)}\n"
  end

end
