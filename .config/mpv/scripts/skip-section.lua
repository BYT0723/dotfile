-- skip-section.lua - 基于目录下 .mpvc 配置文件跳过片头片尾
--
-- 每个视频目录可放置一个 .mpvc 文件，该目录下所有视频共用配置:
--   /path/to/show/.mpvc
--
-- .mpvc 格式:
--   intro=<秒>, 从开头跳过的秒数
--   outro=<秒>, 从结尾跳过的秒数
--
-- 快捷键:
--   Alt+i      标记当前位置为片头结束
--   Alt+o      标记当前位置为片尾开始
--   Alt+I      单次跳过片头（无配置时自动标记当前位置，不写入文件）
--   Alt+O      单次跳过片尾（无配置时自动标记当前位置，不写入文件）

local mpvc_name = ".mpvc"

local intro_skip = 0
local outro_skip = 0
local outro_skipped = false
local current_mpvc_path = nil

local function get_mpvc_path()
	local path = mp.get_property("path")
	if not path then
		return nil
	end
	if path:match("^%w+://") or path:match("^%w+:%/%/%") then
		return nil
	end

	if not path:match("^/") and not path:match("^%a:\\") then
		local wd = mp.get_property("working-directory")
		if wd then
			path = wd .. "/" .. path
		end
	end

	local dir = path:match("^(.*)/[^/]+$")
	if not dir then
		return nil
	end
	return dir .. "/" .. mpvc_name
end

local function read_mpvc(path)
	local file = io.open(path, "r")
	if not file then
		return 0, 0
	end
	local intro, outro = 0, 0
	for line in file:lines() do
		local k, v = line:match("^(%a+)=(%-?%d+%.?%d*)$")
		if k == "intro" then
			intro = tonumber(v) or 0
		elseif k == "outro" then
			outro = tonumber(v) or 0
		end
	end
	file:close()
	return math.floor(intro), math.floor(outro)
end

local function write_mpvc(path, intro, outro)
	local file, err = io.open(path, "w")
	if not file then
		mp.osd_message("无法写入: " .. (err or path))
		return false
	end
	file:write("intro=" .. tostring(intro) .. "\n")
	file:write("outro=" .. tostring(outro) .. "\n")
	file:close()
	return true
end

local function on_start_file()
	outro_skipped = false
	intro_skip = 0
	outro_skip = 0
	current_mpvc_path = get_mpvc_path()

	if not current_mpvc_path then
		return
	end

	intro_skip, outro_skip = read_mpvc(current_mpvc_path)

	if intro_skip > 0 then
		local function do_intro_seek()
			local time_pos = mp.get_property_number("time-pos")
			if not time_pos then
				mp.add_timeout(0.05, do_intro_seek)
				return
			end
			if time_pos < intro_skip then
				mp.commandv("seek", tostring(intro_skip), "absolute", "exact")
			end
		end
		mp.add_timeout(0.05, do_intro_seek)
	end

	if intro_skip > 0 or outro_skip > 0 then
		local msg = ""
		if intro_skip > 0 then
			msg = "片头: " .. intro_skip .. "s"
		end
		if outro_skip > 0 then
			if msg ~= "" then
				msg = msg .. "  "
			end
			msg = msg .. "片尾: " .. outro_skip .. "s"
		end
		mp.osd_message(msg, 2)
	end
end

local function on_outro_time(name, val)
	if outro_skip <= 0 or outro_skipped then
		return
	end
	local duration = mp.get_property_number("duration")
	if not duration or not val or duration <= 0 then
		return
	end
	if val >= duration - outro_skip then
		outro_skipped = true
		local playlist_count = mp.get_property_number("playlist-count")
		local playlist_pos = mp.get_property_number("playlist-pos")
		if playlist_pos and playlist_count and playlist_pos >= playlist_count - 1 then
			mp.commandv("stop")
		else
			mp.commandv("playlist-next")
		end
		mp.osd_message("跳过片尾 (" .. outro_skip .. "s)")
	end
end

local function mark_intro()
	if not current_mpvc_path then
		mp.osd_message("不支持该媒体")
		return
	end
	local time_pos = mp.get_property_number("time-pos")
	if not time_pos or time_pos <= 0 then
		return
	end

	intro_skip = math.floor(time_pos)
	write_mpvc(current_mpvc_path, intro_skip, outro_skip)
	mp.osd_message("片头标记: " .. intro_skip .. "s")
end

local function mark_outro()
	if not current_mpvc_path then
		mp.osd_message("不支持该媒体")
		return
	end
	local duration = mp.get_property_number("duration")
	local time_pos = mp.get_property_number("time-pos")
	if not time_pos or not duration or duration <= 0 then
		return
	end

	outro_skip = math.floor(duration - time_pos)
	if outro_skip < 0 then
		outro_skip = 0
	end

	write_mpvc(current_mpvc_path, intro_skip, outro_skip)
	mp.osd_message("片尾标记: " .. outro_skip .. "s (从末尾)")
end

local function clear_intro()
	if not current_mpvc_path then
		return
	end
	intro_skip = 0
	write_mpvc(current_mpvc_path, 0, outro_skip)
	mp.osd_message("片头标记已清除")
end

local function clear_outro()
	if not current_mpvc_path then
		return
	end
	outro_skip = 0
	write_mpvc(current_mpvc_path, intro_skip, 0)
	mp.osd_message("片尾标记已清除")
end

mp.register_event("start-file", on_start_file)

mp.add_key_binding("Alt+i", "mark-intro", mark_intro)
mp.add_key_binding("Alt+o", "mark-outro", mark_outro)
mp.add_key_binding("Alt+I", "clear-intro", clear_intro)
mp.add_key_binding("Alt+O", "clear-outro", clear_outro)

mp.observe_property("time-pos", "number", on_outro_time)
