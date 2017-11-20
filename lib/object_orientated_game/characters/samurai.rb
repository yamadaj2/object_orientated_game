require_relative 'character'

class Samurai < Character
  attr_reader :type

  def initialize(name, health_points, attack_points, type)
    super(name, health_points, attack_points)
    @type = self.class
  end

  def attack_list_length
    AttackList::SAMURAI_ATTACK_LIST.length
  end

  def show_attack_list
    AttackList::SAMURAI_ATTACK_LIST.each_with_index do |(key, value), index|
      puts "#{index + 1}: #{AttackList::SAMURAI_ATTACK_LIST[key][:attack_name]} | Power: #{AttackList::SAMURAI_ATTACK_LIST[key][:damage]} "
    end
  end

  def get_attack_damage(number_choice)
    keys = AttackList::SAMURAI_ATTACK_LIST.keys
    return AttackList::SAMURAI_ATTACK_LIST[keys[number_choice - 1]][:damage]
  end
end