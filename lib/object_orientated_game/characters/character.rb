class Character

  attr_accessor :name, :health_points
  attr_reader :attack_points

  def initialize(name, health_points, attack_points)
    @name = name
    @health_points = health_points
    @attack_points = attack_points
  end

  def show_full_stats
    divider = '-' * 40
    stats_display = <<~END
    #{divider}
      Name: #{@name}
      Type: #{@type}
      Health Points: #{@health_points}
      Attack Points: #{@attack_points}
    #{divider}
    END

    stats_display
  end

  def show_player_selection
    "You chose #{self.name} the #{self.type}"
  end

  def show_challenge_line
    "#{self.name} the #{self.type} has appeared and is challenging you to a fight to the death!"
  end
end