
local min = math.min
local abs = math.abs
--local deg = math.deg

function ju52.physics(self)
    local friction = 0.99
	local vel=self.object:get_velocity()
		-- dumb friction
	if self.isonground and not self.isinliquid then
		self.object:set_velocity({x=vel.x*friction,
								y=vel.y,
								z=vel.z*friction})
	end
	
	-- bounciness
	if self.springiness and self.springiness > 0 then
		local vnew = vector.new(vel)
		
		if not self.collided then						-- ugly workaround for inconsistent collisions
			for _,k in ipairs({'y','z','x'}) do
				if vel[k]==0 and abs(self.lastvelocity[k])> 0.1 then
					vnew[k]=-self.lastvelocity[k]*self.springiness
				end
			end
		end
		
		if not vector.equals(vel,vnew) then
			self.collided = true
		else
			if self.collided then
				vnew = vector.new(self.lastvelocity)
			end
			self.collided = false
		end
		
		self.object:set_velocity(vnew)
    else
        self.object:set_pos(self.object:get_pos())
        self.object:set_velocity(vel)        
	end
    --self.object:set_acceleration({x=0,y=mobkit.gravity,z=0})

end
