module Inventory

	def Inventory.inventory(item)

		@@items ||= Array.new

		if item == "show"
			@@items.inspect
		else
			@@items << item
		end
	end
end