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

end