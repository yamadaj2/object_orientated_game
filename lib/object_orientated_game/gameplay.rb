require_relative 'characters/ninja'
require_relative 'characters/samurai'
require_relative 'characters/demon'
require_relative 'modules/enemy_list'
require_relative 'modules/player_character_list'

class Gameplay
  include EnemyList
  include PlayerCharacterList

  def random_enemy_selection
    r = Random.new
    random_selection = r.rand(19)
    case
      when random_selection.zero?
        enemy_character = EnemyList::ENEMY_LIST[:boss_demon][:object]
      when random_selection >= 1 && random_selection <= 9
        enemy_character = EnemyList::ENEMY_LIST[:enemy_samurai][:object]
      when random_selection > 9 && random_selection <= 20
        enemy_character = EnemyList::ENEMY_LIST[:enemy_ninja][:object]
    end

    enemy_character
  end

  # todo test(stdin)
  def player_setup
    player_input = choose_character_menu
    case player_input
      when 1
        player_character = PlayerCharacterList::PLAYERS[:player_ninja]
      when 2
        player_character = PlayerCharacterList::PLAYERS[:player_samurai]
    end
    player_character.name = choose_player_name

    player_character
  end

  # todo test (stdin)
  def choose_character_menu
    player_input = 0

    while player_input <= 0 || player_input > PlayerCharacterList::PLAYERS.length
      puts 'Choose your character by entering a number'
      puts "1 for the #{PlayerCharacterList::PLAYERS[:player_ninja].type}"
      puts "2 for the #{PlayerCharacterList::PLAYERS[:player_samurai].type}"
      player_input = gets.chomp.to_i
    end

    player_input
  end

  # todo test (stdin)
  def choose_player_name
    puts 'Type a name for you character using letters only.'
    player_name = gets.chomp
    if letters_only?(player_name)
      player_name
    else
      choose_player_name
    end
  end

  def letters_only?(player_input)
    !/^[A-z]+$/.match(player_input).nil?
  end

  def show_health_statuses(player_character, enemy_character)
    "Your health: #{player_character.health_points} | #{enemy_character.name}'s health: #{enemy_character.health_points}"
  end

  def attack_accurate?
    r = Random.new
    accurate = r.rand(9)
    accurate > 0 ? true : false
  end

  #todo test(stdout)
  def decide_winner(player_character, enemy_character)
    if player_character.health_points <= 0 && enemy_character.health_points <= 0
      tie_battle_outcome_scene(player_character, enemy_character)
    elsif player_character.health_points > enemy_character.health_points
      show_battle_over
      player_character.show_victory_scene(enemy_character)
      puts enemy_character.show_demon_congratulations_line if enemy_character.class == Demon
    else
      show_battle_over
      enemy_character.show_victory_scene(player_character)
      puts enemy_character.show_demon_victory_scene if enemy_character.class == Demon
    end
  end

  # todo test (stdout)
  def tie_battle_outcome_scene(player_character, enemy_character)
    star_divider = '*' * 20
    show_battle_over
    puts star_divider + " #{player_character.name} and #{enemy_character.name} are both dead! " + star_divider
    puts star_divider + " The battle has ended in a tie! " + star_divider
  end

  # todo test(stdout)
  def show_battle_over
    star_divider = '*' * 20
    puts star_divider + ' The Battle is Over! ' + star_divider
    sleep 1
  end

  #todo test (stdout)
  def show_round_number(round_number)
    puts divider
    puts ' ' * 16 + "Round #{round_number}"
    puts divider
  end

  def divider
    divider = '-' * 40
  end

  def show_characters_turn(character)
    '*' * 30 + "  #{character.name}'s Move  " + '*' * 30
  end
end