class Coord
	def initialize(mn, mx, stp)
		@min = mn
		@max = mx
		@step = stp
		@now = @min
	end

	def back(shifted)
		@now = shifted ? @min + @step : @min
	end

	def step(times = 1)
		@now += @step*times
	end

	def prev()
		@now - @step
	end

	def next(times = 1)
		@now + @step*times
	end

	def now()
		@now
	end

	def max()
		@max
	end
end

x = Coord.new(-12, 2771, 59)
y = Coord.new(-10, 1921, 36)

shifted_row = false

pile = []

1.step do |j|
	1.step do |i|
		arr = [[x.now, y.now], [x.next, y.next], [x.next(2), y.now], [x.next, y.prev]]
		pile.push ("\"" + arr.flatten.map{|po| po.to_s }.join(",") + "\",\n") if !arr.any?{|a,b| !a.between?(0, x.max) || !b.between?(0, y.max) }		
		x.step(2)
		break if x.now > x.max
	end

	shifted_row = !shifted_row
	x.back(shifted_row)
	y.step
	break if y.now > y.max
end

open('image_areas.txt', 'w') { |f| pile.each{|rh| f << rh }}
