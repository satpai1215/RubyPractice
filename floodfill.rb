x = 'x'
O = 'O'

map = [	[x, x, x, x, x, x, x, x, x, x, x],
		[x, x, x, x, x, x, x, x, x, x, x],
		[x, x, x, x, O, O, x, x, x, x, x],
		[x, x, x, O, x, x, O, x, x, x, x],
		[x, x, x, O, x, x, O, x, x, x, x],
		[x, x, x, O, x, O, x, x, x, x, x],
		[x, x, x, x, O, O, x, x, x, x, x],
		[x, x, x, x, x, x, x, x, x, x, x],
		[x, x, x, x, x, x, x, x, x, x, x],
		[x, x, x, x, x, x, x, x, x, x, x],
		[x, x, x, x, x, x, x, x, x, x, x]]


def flood_fill(map, x, y)

	if x < 0 || x > map.length - 1 || y < 0 || y > map.length - 1
		return
	end

	if map[x][y] != 'x'
		return
	end

	map[x][y] = '-'

	flood_fill(map, x+1, y)
	flood_fill(map, x, y+1)
	flood_fill(map, x-1, y)
	flood_fill(map, x, y-1)
		
end

def print_map(map)
	map.each do |row|
		puts row.join(' ')
	end

end

print_map(map)
flood_fill(map, 3, 4)
puts
print_map(map)