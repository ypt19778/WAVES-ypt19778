help = True

def displayMessage(txt, player): #non-intended useage for game (exept helper)
         messg = None
         if txt == "congrats":
                  messg = "congrats, "+player+"! You beat your HIGHSCORE!"
         elif txt == "die":
                  messg = "Don't worry, "+player+". You'll get 'em next time!"
         elif txt == "beat highest score":
                  messg = "YOU DID IT, "+player+"!!! YOU BEAT THE HIGHEST SCORE!!!"
         else:
                  messg = txt
         print(messg)

def helper(player):
         helper_tag = "knows-a-lot"
         print('hi, '+player+"! My name is "+helper_tag+", and I'm here to help!")

         question_main = input("what would you like to ask? \nI. how to use sword\nII. how to use shield\nIII. how to use pickaxe\nIV. help\n:")

         if question_main == "how to use sword":
                  question_sword_opt = input("whick of these would you like to know?\nI. attacking\nII. change sprite\n:")
                  if question_sword_opt == "attacking":
                          print("the sword can attack by pressing spacebar, x, m, or LMB(left-click)")
                          print("you can only DAMAGE an enemy when it is inside of your hitbox.")
                  elif question_sword_opt == "sprite change":
                          print('got to the player.lua file and then change instance.sword_sprite or instance.sword_active_sprite to desired ascii or string.')
                  elif question_sword_opt == "change damage":
                          print("use the function dtp:setDamage(desired damage) in main.lua.")
         elif question_main == "exit" or "kill" or "escape" or "/e":
                  print("py.helper.bot toggle false")
                  help = False
         else:
                  print("unidentifed/un-programmed question. please type an actual question. Thank you!")