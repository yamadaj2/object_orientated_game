require_relative 'character'

class Ninja < Character
  attr_reader :type

  def initialize(name, health_points, attack_points, type)
    super(name, health_points, attack_points)
    @type = self.class
  end

  def attack_list_length
    AttackList::NINJA_ATTACK_LIST.length
  end

  def show_attack_list
    AttackList::NINJA_ATTACK_LIST.each_with_index do |(key, value), index|
      puts "#{index + 1}: #{AttackList::NINJA_ATTACK_LIST[key][:attack_name]} | Power: #{AttackList::NINJA_ATTACK_LIST[key][:damage]}"
    end
  end

  def get_attack_damage(number_choice)
    keys = AttackList::NINJA_ATTACK_LIST.keys
    return AttackList::NINJA_ATTACK_LIST[keys[number_choice - 1]][:damage]
  end
end