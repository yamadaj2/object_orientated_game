module PlayerCharacterList
  PLAYERS =
      {
          player_ninja: Ninja.new('player_ninja',300,60,self.class),
          player_samurai: Samurai.new('player_samurai', 180,100,self.class)
      }
end
