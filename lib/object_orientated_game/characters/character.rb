require_relative '../modules/trash_talk'
require_relative '../modules/attack_list'

class Character
  include AttackList
  include TrashTalk

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

  #todo test (stdout)
  def select_attack
    attack_choice_number = 0
    while attack_choice_number < 1 || attack_choice_number > self.attack_list_length
      puts "Choose your attack by entering a number between 1 and #{self.attack_list_length}"
      self.show_attack_list
      attack_choice_number = gets.chomp.to_i
      if attack_choice_number > 0 && attack_choice_number <= self.attack_list_length
        system 'clear'
        return attack_choice_number
      else
        puts "You've entered an invalid option. Please select from the list"
      end
    end
  end

  def is_alive?
    self.health_points > 0 ? true : false
  end
end