function love.load()
	b = love.graphics.newImage("Snow_Ball.png")
	b_x, b_y = 100, 100
	b_w, b_h = 36, 36

	v_x, v_y = 0, 0
	love.graphics.setColor(255,255,255)
	love.graphics.setBackgroundColor(0,0,0)

	a = 0
	a_k = 500 
end

function love.draw()
	local x, y = love.mouse.getPosition()
	love.graphics.draw(b, b_x, b_y)

	if love.mouse.isDown(1) then
		love.graphics.line(x,y,x_press,y_press)
	end
	if love.mouse.isDown(2) then
		love.graphics.line(x,y,b_x+b_w/2,b_y+b_h/2)
	end
	love.graphics.print("k="..a_k .." a="..a, 10, 10)
end

function love.update(dt)
	local x, y = love.mouse.getPosition()

	if love.mouse.isDown(1) then
		b_x = x - b_w / 2
		b_y = y - b_h / 2
		return -- quit function?
	elseif love.mouse.isDown(2) then
		local t = love.timer.getTime()
		local dx, dy = x - b_x, y - b_y
		local d = norm(dx, dy)
		local d = math.max(d, 10)
		-- local k = 500
		-- a = k * (t - t_start) / (d*d)
		k = 500
		a = a_k / (d*d)
		v_x = v_x + dx/d * a
		v_y = v_y + dy/d * a 

	end

	b_x = b_x + v_x * dt
	b_y = b_y + v_y * dt
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		x_press = x
		y_press = y
	end
	if button == 2 then
		t_start = love.timer.getTime()
	end
end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		local k = 1
		v_x = k * (x_press - x)
		v_y = k * (y_press - y)
	end
end

function love.wheelmoved(x, y)
	a_k = a_k + 20 * y
end

function norm(x, y)
	return math.sqrt(x*x+y*y)
end
