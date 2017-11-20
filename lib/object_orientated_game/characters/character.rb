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

  def show_character_intro
    "#{self.name} looks at you dead in the eye and says:\n#{character_trash_talk}"
  end

  def character_trash_talk
    r = Random.new
    intro_line_list = TrashTalk::Lines
    intro_line_list[r.rand(intro_line_list.length)]
  end
end