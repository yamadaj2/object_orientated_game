require_relative 'gameplay'
system 'clear'

gameplay = Gameplay.new

# Instansiate fighters
player_character = gameplay.player_setup
enemy_character = gameplay.random_enemy_selection
puts player_character.show_player_selection

# Introduction Scenes
enemy_character.show_demon_intro_scenes if enemy_character.class == Demon
puts enemy_character.show_challenge_line
sleep 2
puts enemy_character.show_character_intro unless self.class == Demon
sleep 2

# Battle starts here
round_number = 1
while player_character.is_alive? && enemy_character.is_alive?
  puts player_character.show_full_stats
  sleep 1
  puts enemy_character.show_full_stats
  sleep 1

  puts gameplay.divider
  puts gameplay.show_health_statuses(player_character, enemy_character)
  puts gameplay.divider

  gameplay.show_round_number(round_number)
  sleep 1
  puts gameplay.show_characters_turn(player_character)

  if gameplay.attack_accurate?
    player_attack_choice_number = player_character.select_attack
    puts player_character.show_attack_description(player_attack_choice_number)
    enemy_damage_received = player_character.calculate_damage(player_attack_choice_number)
    enemy_character.deduct_health(enemy_damage_received)
    enemy_character.show_damage_scene(enemy_damage_received)
    puts enemy_character.damaged_received_remark
    sleep 1
  else
    puts player_character.show_attack_miss_scene(enemy_character)
    sleep 1
    puts player_character.missed_attack_remark
    sleep 1
  end

  puts gameplay.show_characters_turn(enemy_character)
  if gameplay.attack_accurate?
    enemy_attack_choice_number = enemy_character.generate_random_attack_number
    player_damage_received = enemy_character.calculate_damage(enemy_attack_choice_number)
    player_character.deduct_health(player_damage_received)
    player_character.show_damage_scene(player_damage_received)
    puts player_character.damaged_received_remark
    sleep 1
  else
    puts enemy_character.show_attack_miss_scene(player_character)
    sleep 1
    puts enemy_character.missed_attack_remark
  end
end