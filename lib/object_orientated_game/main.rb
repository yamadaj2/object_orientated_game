require_relative 'gameplay'
system 'clear'

gameplay = Gameplay.new

# Instansiate fighters
player_character = gameplay.player_setup
enemy_character = gameplay.random_enemy_selection
puts player_character.show_player_selection