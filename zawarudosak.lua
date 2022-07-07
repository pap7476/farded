local c = {}
local stop = {}
local function epic(amountOfTime)
  local t = tick()
  while tick()-t < amountOfTime do
      game:GetService("RunService").Heartbeat:Wait()
  end
end

local function playsound(id)
  c[id] = 0
  stop[id] = false
  local s = Instance.new("Sound")
  s.SoundId = "rbxassetid://"..id
  s.Parent = workspace
  s.Volume = 0
  repeat wait() until s.TimeLength > 0
  local maxtime = s.TimeLength
  s:Destroy()
  coroutine.wrap(function()
      workspace.Effects.ChildAdded:Connect(function(d)
          game.RunService.Heartbeat:Wait()
          for i,v in pairs(workspace.Effects:GetDescendants()) do
              if v.Parent == d and v:IsA("Sound") and v.SoundId == "rbxassetid://"..id and stop[id] == false then
                  stop[id] = true
                  v.TimePosition = c[id]
                  if v.TimePosition >= maxtime then return end
              end
          end
      end)
      for i = 1,maxtime,0.1 do
          game:GetService("ReplicatedStorage").Damage11Sans:FireServer(game.Players.LocalPlayer.Character.Humanoid,game.Players.LocalPlayer.Character.Head.CFrame * CFrame.new(0,-5,0),0,0, Vector3.new(0, 0, 0),0, "rbxassetid://"..id,1,10)
          c[id] = c[id] + 0.1
          epic(0.1)
          stop[id] = false
      end
      c[id] = 0
  end)()
end

playsound(6760590605)
