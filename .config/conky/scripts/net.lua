-- 缓存 iface
iface_cache = nil
iface_last_update = 0
iface_update_interval = 30 -- 每30秒刷新一次网卡

-- 获取当前默认网卡
function iface()
	local now = os.time()
	if iface_cache ~= nil and (now - iface_last_update < iface_update_interval) then
		return iface_cache
	end

	-- 检查缓存网卡状态
	if iface_cache then
		local f = io.open("/sys/class/net/" .. iface_cache .. "/operstate")
		if f then
			local state = f:read("*l")
			f:close()
			if state == "up" then
				iface_last_update = now
				return iface_cache
			end
		end
	end

	-- 重新检测默认网卡
	for line in io.lines("/proc/net/route") do
		local iface, dest = line:match("(%S+)%s+(%S+)")
		if dest == "00000000" then
			iface_cache = iface
			iface_last_update = now
			return iface
		end
	end

	return "N/A"
end
