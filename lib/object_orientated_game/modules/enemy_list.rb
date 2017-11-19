module EnemyList
  ENEMY_LIST =
      {
          enemy_ninja: {
              object: Ninja.new('Karasu', 360, 70, self.class),
          },
          enemy_samurai: {
              object: Samurai.new('Bui', 210, 120, self.class)
          },
          boss_demon: {
              object: Demon.new('Tuguro', 450, 150, self.class),
              scene: "What the..? You've encountered the infamous Demon Boss Tuguro",
              intro_line: "Tuguro says: \"I am more powerful than the others you have faced. You cannot win. Prepare to die\"",
              victory_line: "Hahahahaha. I am the most powerful fighter ever and you are just another brick in the wall",
              defeat_line: "No! How did you defeat me? You must be the One. I will be back!",
              congratulations_line: "Congratulations! You are the first person to defeat the Demon Boss. You are the Master!"
          }
      }
end