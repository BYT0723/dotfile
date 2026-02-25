function conky_format(format, number)
	return string.format(format, conky_parse(number))
end

-- 缓存 iface
iface_cache = nil
iface_last_update = 0
iface_update_interval = 30 -- 每30秒刷新一次网卡

-- 获取当前默认网卡
function conky_iface()
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

-- 获取 IP
function conky_ip()
	local iface = conky_iface()
	return conky_parse("${addr " .. iface .. "}")
end

-- wireless_essid wlp0s20f3}(${wireless_link_qual_perc wlp0s20f3}%)
-- 获取 ESSID 和信号强度（如果无线）
function conky_wlan()
	local iface = conky_iface()
	return conky_parse("${wireless_essid " .. iface .. "}(${wireless_link_qual_perc " .. iface .. "}%)")
end

-- Down/Up speed
function conky_down()
	local iface = conky_iface()
	return conky_parse("${downspeed " .. iface .. "}")
end

function conky_up()
	local iface = conky_iface()
	return conky_parse("${upspeed " .. iface .. "}")
end

-- Graph
function conky_downgraph()
	local iface = conky_iface()
	return conky_parse("${downspeedgraph " .. iface .. " 40,180}")
end

function conky_upgraph()
	local iface = conky_iface()
	return conky_parse("${upspeedgraph " .. iface .. " 40,180}")
end
