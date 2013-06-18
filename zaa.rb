def prompt
	print "> "
end

class Intro

	def start
		puts(<<-INTRO)

Welcome to the Zombie Apocalypse Adventure game!
You're goal is to survive while collecting supplies for your family.
You begin by exploring an abandoned warehouse...
------------------
INTRO

	first_room = Lobby.new
	first_room.enter_lobby

	end
end

class Lobby 

	require './zaa_inventory'

	include Inventory

	def enter_lobby
		room_info = "You're in the lobby of the warehouse.\nAhead of you is a door marked \"lab\"."

		puts room_info
		puts "\nThere is a bat with blood stains on the floor.\n\nWhat would you like to do?"
		
		while true
			prompt; action = gets.chomp

			if action == "take bat"		# use case statements instead?
				Inventory.inventory("bat")  
				puts "Bat taken."
			elsif action == "show inventory"
				puts Inventory.inventory("show")
			elsif action.include? "lab"
				lab = Lab.new
				lab.enter_room
			else
				puts "I don't know what you mean."
			end
		end
	end
end

class Lab

	def enter_room
		room_info = <<-TEXT

You're in the lab. 

There is a door marked "clean room" 
and a door marked "biohazard room".

TEXT

		puts room_info

		zombie_dead = false

		puts zombie_dead ? nil : "Oh crap! There's a zombie! What do you do?"

		while true
			prompt; action = gets.chomp

			if action == "use bat"    # and it's in the inventory?
				puts(<<-TEXT)

All those years of little-league paid off.
You bludgeon the undead monster back to the hell from whence it came.

You also see a shotgun in the corner of the room.

What would you like to do?
TEXT
				zombie_dead = true
			elsif action.include? "lobby"
				puts "You can't go back to your family empty-handed."
			elsif action == "take shotgun"
				Inventory.inventory("shotgun")
				puts "Shotgun taken."
			elsif action == "show inventory"
				puts Inventory.inventory("show")
			elsif action.include? "clean" and zombie_dead
				clean = CleanRoom.new
				clean.enter_room
			elsif action.include? "biohazard" and zombie_dead
				biohazard = BiohazardRoom.new
				biohazard.enter_room
			else
				puts "I don't know what you mean."
			end
		end
	end
end

class CleanRoom

	def enter_room
		room_info = "\nYou're in the clean room. No zombies here."

		puts room_info

		puts "\nYou see an apple next to a first aid kit.\n\nWhat do you do?"

		while true
			prompt; action = gets.chomp

			if action == "take apple"
				Inventory.inventory("apple")
				puts "Apple taken."
			elsif action == "take first aid kit"
				Inventory.inventory("first aid kit")
				puts "Kit taken."
			elsif action == "show inventory"
				puts Inventory.inventory("show")
			elsif action == "enter lab"
				lab = Lab.new
				lab.enter_room
			else
				puts "I don't know what you mean."
			end
		end
	end
end

class BiohazardRoom

	def enter_room
		room_info = "\nYou're in the biohazard room."

		puts room_info

		puts "\nNear your feet, you see a small bottle labeled \"vicodin\"."

		two_zombies_dead = false

		puts two_zombies_dead ? nil : "\nYou see two zombies fighting over a can of spam!\nWhat do you do?"

		while true
			prompt; action = gets.chomp

			if action.include? "bottle" or action.include? "vicodin"
				Inventory.inventory("vicodin")
				puts "Vicodin taken."
			elsif action == "use shotgun" # and it's in the inventory
				puts "\nYou drop both zombies like targets in a carnival game."
				two_zombies_dead = true
				puts "\nWhat do you do?"
			elsif action == "take spam" and two_zombies_dead
				Inventory.inventory("spam")
				puts "Spam taken."
			elsif action == "show inventory"
				puts Inventory.inventory("show")
			elsif action == "enter lab"
				lab = Lab.new
				lab.enter_room
			else
				puts "I don't know what you mean."
			end
		end
	end
end

game = Intro.new
game.start






