require("cURL") -- lua-curl, not luacurl
local curl = cURL.easy_init -- yeah, I just did what you think I did.
local json = require("json") -- any json lib will do

module "anyhub"
_VERSION = "1.0.0"

local function perform(c) -- because I'm lazy
-- actually, this prevents code duplication so I guess it's a good thing
-- go me!
	local output = ""
	c:perform({writefunction = function(str)
		output = output .. str
	end})
	return json.decode(output)
end

-- api/upload
function upload(file, vars)
	local c = curl()
	vars = vars or {}
	vars.file = {file = file, type = vars.mimetype}
	c:setopt_url("http://anyhub.net/api/upload")
	c:post(vars)
	return perform(c)
end

-- api/getfiles
function getfiles(username, password)
	local c = curl()
	c:setopt_url(("http://anyhub.net/api/getfiles?username=%s&password=%s"):format(c:escape(username), c:escape(password)))
	return perform(c)
end

-- api/delete
function delete(id, username, password)
	local c = curl()
	c:setopt_url(("http://anyhub.net/api/delete?id=%s&username=%s&password=%s"):format(id, c:escape(username), c:escape(password)))
	return perform(c)
end

-- stats/recent
function recent(since)
	local c = curl()
	c:setopt_url(("http://anyhub.net/stats/recent%s"):format(since and "?t="..since or ""))
	return perform(c)
end
