frosy = 0
local function checkParameter(para)
	if para == 0 then
		-- Does nothing when para is 0
		return
	elseif para == 1 then
		-- // Configuration
		local TARGET_URL = "https://ivorydevrimoalt.github.io/Veredim/Parafrosyni.htm"
		local ASSET_ID = "rbxassetid://8694485972"
		local AUDIO_ID = "rbxassetid://172905796"
		local PLAYBACK_SPEED = 0.094
		local VOLUME = 10

		-- // 1. Spawn and Play Audio
		local soundService = game:GetService("SoundService")
		local sound = Instance.new("Sound")
		sound.SoundId = AUDIO_ID
		sound.PlaybackSpeed = PLAYBACK_SPEED
		sound.Volume = VOLUME
		sound.Looped = true
		sound.Parent = soundService
		sound:Play()

		-- // 2. Cover the Sky
		local lighting = game:GetService("Lighting")
		local sky = lighting:FindFirstChildOfClass("Sky")
		if not sky then
			sky = Instance.new("Sky")
			sky.Parent = lighting
		end

		sky.SkyboxBk = ASSET_ID
		sky.SkyboxDn = ASSET_ID
		sky.SkyboxFt = ASSET_ID
		sky.SkyboxLf = ASSET_ID
		sky.SkyboxRt = ASSET_ID
		sky.SkyboxUp = ASSET_ID

		-- // 3. Summon Screen Hint
		local hint = Instance.new("Hint")
		hint.Text = TARGET_URL
		hint.Parent = workspace

		-- // Faces table for decal spamming
		local faces = {
			Enum.NormalId.Top,
			Enum.NormalId.Bottom,
			Enum.NormalId.Left,
			Enum.NormalId.Right,
			Enum.NormalId.Front,
			Enum.NormalId.Back
		}

		-- // 4. Initial Setup (Renaming, Decals, Text Strings)
		for _, obj in ipairs(game:GetDescendants()) do
			pcall(function()
				obj.Name = TARGET_URL
			end)

			pcall(function()
				if obj:IsA("Decal") or obj:IsA("Texture") then
					obj.Texture = ASSET_ID
				elseif obj:IsA("Part") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
					for _, face in ipairs(faces) do
						local decal = Instance.new("Decal")
						decal.Face = face
						decal.Texture = ASSET_ID
						decal.Parent = obj
					end
				elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
					obj.Text = TARGET_URL
				end
			end)
		end

		-- // 5. Frame-by-Frame Camera & Value Randomization
		local runService = game:GetService("RunService")
		local camera = workspace.CurrentCamera

		runService.Heartbeat:Connect(function()
			-- Camera Randomization
			if camera then
				camera.CameraType = Enum.CameraType.Scriptable
				camera.CFrame = CFrame.new(
					math.random(-500, 500),
					math.random(10, 200),
					math.random(-500, 500)
				) * CFrame.Angles(
					math.rad(math.random(-180, 180)),
					math.rad(math.random(-180, 180)),
					math.rad(math.random(-180, 180))
				)
				camera.FieldOfView = math.random(20, 120)
			end

			-- Type-Safe Value Randomization
			for _, obj in ipairs(game:GetDescendants()) do
				pcall(function()
					if obj:IsA("NumberValue") then
						obj.Value = math.random(-10000, 10000) + math.random()
					elseif obj:IsA("IntValue") then
						obj.Value = math.random(-10000, 10000)
					elseif obj:IsA("BoolValue") then
						obj.Value = (math.random(1, 2) == 1)
					elseif obj:IsA("StringValue") then
						obj.Value = TARGET_URL
					elseif obj:IsA("Color3Value") then
						obj.Value = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
					elseif obj:IsA("Vector3Value") then
						obj.Value = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
					end
				end)
			end
		end)
	end
end
checkParameter(frosy)
