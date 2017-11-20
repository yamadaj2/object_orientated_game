require_relative '../modules/trash_talk'
require_relative '../modules/attack_list'
require_relative '../modules/attack_remarks'

class Character
  include AttackList
  include TrashTalk
  include AttackRemarks

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

  def show_attack_description(attack_number_choice)
    attack_list = self.get_attack_list
    "#{self.name} #{attack_list[attack_list.keys[attack_number_choice - 1]][:description]}"
  end

  def get_attack_list
    character_type = self.class.to_s
    case character_type
      when Ninja.to_s
        attack_list = AttackList::NINJA_ATTACK_LIST
      when Samurai.to_s
        attack_list = AttackList::SAMURAI_ATTACK_LIST
      when Demon.to_s
        attack_list = AttackList::DEMON_ATTACK_LIST
    end

    attack_list
  end

  def is_alive?
    self.health_points > 0 ? true : false
  end

  def calculate_damage(attack_number_choice)
    damage = self.get_attack_damage(attack_number_choice) * self.attack_points
    damage
  end

  def deduct_health(damage_amount)
    self.health_points -= damage_amount
  end

  def damaged_received_remark
    remark = AttackRemarks::AccurateAttackRemarks.new
    remark.random_attack_remark(self)
  end

  #todo test (stdout)
  def show_damage_scene(damage_amount)
    sleep 1
    puts show_target_is_hit(self)
    sleep 1
    puts show_damage_amount(damage_amount)
    sleep 1
  end

  def show_target_is_hit(target)
    "#{target.name} is hit!"
  end

  def show_damage_amount(damage_amount)
    "Damage inflicted: #{damage_amount}"
  end

  def show_attack_miss_scene(target)
    "#{self.name} attacks and misses #{target.name}!!"
  end
end