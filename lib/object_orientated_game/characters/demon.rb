require_relative 'character'

class Demon < Character
  attr_reader :type

  def initialize(name, health_points, attack_points, type)
    super(name, health_points, attack_points)
    @type = self.class
  end

  def attack_list_length
    AttackList::DEMON_ATTACK_LIST.length
  end

  def get_attack_damage(number_choice)
    keys = AttackList::DEMON_ATTACK_LIST.keys
    return AttackList::DEMON_ATTACK_LIST[keys[number_choice - 1]][:damage]
  end

  def show_demon_intro_scenes
    sleep 3
    puts self.show_demon_boss_intro_scene
    sleep 3
    puts self.show_demon_intro_line
    sleep 3
  end

  def show_demon_boss_intro_scene
    EnemyList::ENEMY_LIST[:boss_demon][:scene]
  end

  def show_demon_intro_line
    EnemyList::ENEMY_LIST[:boss_demon][:intro_line]
  end

  def show_demon_intro_line
    EnemyList::ENEMY_LIST[:boss_demon][:intro_line]
  end

  def show_demon_victory_scene
    EnemyList::ENEMY_LIST[:boss_demon][:victory_line]
  end

  def show_demon_defeat_scene
    EnemyList::ENEMY_LIST[:boss_demon][:defeat_line]
  end

  def show_demon_congratulations_line
    EnemyList::ENEMY_LIST[:boss_demon][:congratulations_line]
  end
end