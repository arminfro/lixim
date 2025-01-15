-- vi: ft=lua

function _G.merge_arrays(array1, array2)
	local ret = {}
	for _, value in ipairs(array1) do
		table.insert(ret, value)
	end
	for _, value in ipairs(array2) do
		table.insert(ret, value)
	end
	return ret
end

function _G.copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = {}
	s[obj] = res
	for k, v in next, obj do
		res[copy(k, s)] = copy(v, s)
	end
	return setmetatable(res, getmetatable(obj))
end

function _G.truncating_label(label, max_width)
	local ELLIPSIS_CHAR = "…"
	local truncated_label = vim.fn.strcharpart(label, 0, max_width)
	if truncated_label ~= label then
		return truncated_label .. ELLIPSIS_CHAR
	else
		return label
	end
end

-- print tables
function _G.P(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end

-- expressive if
function _G.if_exp(bool, a, b)
	if bool then
		return a
	else
		return b
	end
end

function _G.extractLastPathSegments(path, count, separator)
	local segments = {}
	for segment in path:gmatch("[^/]+") do
		table.insert(segments, segment)
	end

	if #segments <= count then
		return path
	else
		local lastThree =
			table.concat({ segments[#segments - 2], segments[#segments - 1], segments[#segments] }, separator or "/")
		return lastThree
	end
end

-- todo, update blink with configured dictionary provider
function _G.setCmpDictionaryByCurrentLanguages(current_languages)
	local ok, cmp_dictionary = pcall(require, "cmp_dictionary")
	if not ok or not lixim_config.cmpDicts or #current_languages == 0 then
		return
	end

	-- local current_languages = vim.opt.spelllang:get()
	-- Create a table of dictionary paths
	local paths = {}
	for _, lang in ipairs(current_languages) do
		local path = lixim_config.cmpDicts[lang]
		if path then
			table.insert(paths, path)
		end
	end

	-- todo, calling it more than once does not seem to work
	cmp_dictionary.setup({
		paths = paths,
		first_case_insensitive = true,
	})
end

-- function _G.is_buffer_in_root_path(buf)
-- 	local root_path = LazyVim.root()
-- 	local buffer_path = vim.api.nvim_buf_get_name(buf or 0)
-- 	return buffer_path:sub(1, #root_path) == root_path
-- end

function _G.get_git_root_by_path(path)
	local git_root = vim.fs.find(".git", { path = path, upward = true })[1]
	local ret = git_root and vim.fn.fnamemodify(git_root, ":h") or path
	return ret
end

function _G.print_table_to_file(t, fd)
	fd = fd or io.stdout
	local function print(str)
		str = str or ""
		fd:write(str .. "\n")
	end

	local print_r_cache = {}
	local function sub_print_r(t, indent)
		if print_r_cache[tostring(t)] then
			print(indent .. "*" .. tostring(t))
		else
			print_r_cache[tostring(t)] = true
			if type(t) == "table" then
				for pos, val in pairs(t) do
					if type(val) == "table" then
						print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
						sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
						print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
					elseif type(val) == "string" then
						print(indent .. "[" .. pos .. '] => "' .. val .. '"')
					else
						print(indent .. "[" .. pos .. "] => " .. tostring(val))
					end
				end
			else
				print(indent .. tostring(t))
			end
		end
	end

	if type(t) == "table" then
		print(tostring(t) .. " {")
		sub_print_r(t, "  ")
		print("}")
	else
		sub_print_r(t, "  ")
	end
	print()
end

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

return {}

