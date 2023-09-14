function love.load()
	b_x, b_y = 100, 100
	R = 20

	v_x, v_y = 0, 0
	love.graphics.setColor(255,255,255)
	love.graphics.setBackgroundColor(0,0,0)

	a = 0
	a_k = 500 
	k_s = 2 -- slingshot strength
end

function love.draw()
	love.graphics.circle("fill", b_x, b_y, R)

	local x, y = love.mouse.getPosition()
	if love.mouse.isDown(1) then
		love.graphics.line(x,y,x_press,y_press)
	end
	if love.mouse.isDown(2) then
		love.graphics.line(x,y,b_x,b_y)
	end
	love.graphics.print("k="..a_k .." a="..a, 10, 10)
end

function love.update(dt)
	local x, y = love.mouse.getPosition()

	if love.mouse.isDown(1) then
		b_x = x
		b_y = y
	elseif love.mouse.isDown(2) then
		local t = love.timer.getTime()
		local dx, dy = x - b_x, y - b_y
		local d = math.sqrt(dx*dx+dy*dy)
		local d = math.max(d, R) -- else acceleration gets huge at small distance
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
end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		v_x = k_s * (x_press - x)
		v_y = k_s * (y_press - y)
	end
end

function love.wheelmoved(x, y)
	a_k = a_k + a_k / 20 * y -- 5% change
end
