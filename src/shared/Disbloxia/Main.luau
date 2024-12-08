--[[
MIT License

Permission is hereby granted, free of charge, to use, copy, modify, and merge the software under the following conditions:

1. Users may not distribute copies of the software.
2. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
3. Neither the name of the project nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF, OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]


local HttpService = game:GetService("HttpService")
local Disbloxia = {}
Disbloxia.__index = Disbloxia

if game:GetService("RunService"):IsClient() then
	error("Running Disbloxia on client is NOT allowed")
	return
end

function Disbloxia.client()
	local self = setmetatable({}, Disbloxia)
	return self
end

function Disbloxia:login(token)
	self._token = token
	print('token set')
end

function Disbloxia:sendMessage(message, channelId)
	assert(self._token, "No token provided")

	local url = "https://discord.com/api/v9/channels/" .. tostring(channelId) .. "/messages"
	local data = {
		["content"] = message
	}

	local headers = {
		["Authorization"] = "Bot " .. tostring(self._token),
		["Content-Type"] = "application/json"
	}

	local finalData = HttpService:JSONEncode(data)

	local response = HttpService:RequestAsync({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = finalData
	})

	if response.Success then
		print("Message sent successfully!")
		print("Response:", response.StatusCode, response.Body)
	else
		print("Failed to send message!")
		print("Error:", response.StatusCode, response.StatusMessage, response.Body)
	end
end

function Disbloxia:sendEmbed(embed, channelId)
	assert(self._token, "No token provided")

	local url = "https://discord.com/api/v9/channels/" .. tostring(channelId) .. "/messages"
	local data = {
		["embeds"] = {embed}
	}

	local headers = {
		["Authorization"] = "Bot " .. tostring(self._token),
		["Content-Type"] = "application/json"
	}

	local finalData = HttpService:JSONEncode(data)

	local response = HttpService:RequestAsync({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = finalData
	})

	if response.Success then
		print("Embed sent successfully!")
		print("Response:", response.StatusCode, response.Body)
	else
		print("Failed to send embed!")
		print("Error:", response.StatusCode, response.StatusMessage, response.Body)
	end
end


return Disbloxia
