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
end