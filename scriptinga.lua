-- 🔧 ADVANCED SYSTEM OPTIMIZER v4.1 (COMPLETE)
-- loadstring(game:HttpGet(""))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer

-- ============================================
-- 🧠 INTELLIGENT CONTROL SYSTEM
-- ============================================
local Optimizer = {
    _session = "OPT_" .. os.time(),
    _active = false,
    _speed = 1.2,
    _failCount = 0,
    _currentTarget = nil,
    
    ThreatDetector = {
        lastKickTime = 0,
        suspiciousEvents = 0,
        
        checkEnvironment = function(self)
            local redFlags = 0
            
            for _, script in pairs(game:GetDescendants()) do
                if script:IsA("Script") then
                    local name = script.Name:lower()
                    if name:find("cheat") or name:find("scan") or name:find("detect") then
                        redFlags = redFlags + 1
                    end
                end
            end
            
            if #game:GetService("NetworkClient"):GetChildren() > 50 then
                redFlags = redFlags + 1
            end
            
            return redFlags
        end
    },
    
    SpeedController = {
        adjustBasedOnRisk = function(self, riskLevel)
            if riskLevel > 2 then return 3.0
            elseif riskLevel > 0 then return 2.0
            else return 0.8 end
        end
    }
}

-- ============================================
-- 🔄 SMART EXECUTION ENGINE
-- ============================================
function Optimizer:executeSmartOperation()
    if not self._currentTarget then return {} end
    if self._active then return {} end
    
    self._active = true
    local results = {}
    local targetId = self._currentTarget
    local riskLevel = self.ThreatDetector:checkEnvironment()
    
    self._speed = self.SpeedController:adjustBasedOnRisk(riskLevel)
    
    local prioritizedRemotes = {}
    
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local priority = 1
            local name = remote.Name:lower()
            
            if name:find("item") or name:find("give") then priority = 2 end
            if name:find("gamepass") or name:find("purchase") then priority = 3 end
            
            table.insert(prioritizedRemotes, {
                object = remote,
                priority = priority,
                name = name
            })
        end
    end
    
    table.sort(prioritizedRemotes, function(a, b)
        return a.priority > b.priority
    end)
    
    for _, remoteInfo in ipairs(prioritizedRemotes) do
        if not self._active then break end
        
        wait(self._speed + math.random() * 0.5)
        
        local payloads = {
            {id = targetId, sync = true},
            targetId,
            {resource = targetId}
        }
        
        for _, payload in ipairs(payloads) do
            if not self._active then break end
            
            local success = pcall(function()
                remoteInfo.object:FireServer(payload)
                return true
            end)
            
            if success then
                table.insert(results, "✓ " .. remoteInfo.name)
                break
            else
                self._failCount = self._failCount + 1
                if self._failCount > 5 then
                    self._active = false
                    return results
                end
            end
        end
    end
    
    self._active = false
    return results
end

-- ============================================
-- 🔄 AUTO-RESTART SYSTEM
-- ============================================
function Optimizer:startPersistentOperation(targetId)
    self._currentTarget = targetId
    
    spawn(function()
        local cycle = 0
        
        while self._currentTarget do
            cycle = cycle + 1
            
            local results = self:executeSmartOperation()
            
            if #results > 0 then
                print("✅ Cycle " .. cycle .. ": " .. #results .. " ops")
            end
            
            local waitTime = math.random(30, 180)
            wait(waitTime)
            
            self._speed = math.random(8, 15) / 10
        end
    end)
end

function Optimizer:stopOperation()
    self._currentTarget = nil
    self._active = false
    print("⏹️ Operation stopped")
end

-- ============================================
-- 🖥️ STEALTH INTERFACE WITH HIDDEN INPUT
-- ============================================
local function createStealthUI()
    if localPlayer.PlayerGui:FindFirstChild("SystemMonitor") then
        localPlayer.PlayerGui.SystemMonitor:Destroy()
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "SystemMonitor"
    gui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 120)
    frame.Position = UDim2.new(1, -260, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
    frame.BackgroundTransparency = 0.2
    
    local title = Instance.new("TextLabel")
    title.Text = "🖥️ System Monitor"
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundColor3 = Color3.fromRGB(30, 35, 40)
    title.TextColor3 = Color3.fromRGB(220, 220, 220)
    title.Font = Enum.Font.SourceSans
    title.TextSize = 14
    
    local stats = Instance.new("TextLabel")
    stats.Text = "FPS: 60\nRAM: 125MB\nCPU: 12%\nStatus: Idle"
    stats.Size = UDim2.new(1, -10, 1, -30)
    stats.Position = UDim2.new(0, 5, 0, 30)
    stats.BackgroundTransparency = 1
    stats.TextColor3 = Color3.fromRGB(180, 180, 180)
    stats.TextXAlignment = Enum.TextXAlignment.Left
    stats.Font = Enum.Font.SourceSans
    stats.TextSize = 12
    
    -- 🔥 HIDDEN INPUT SYSTEM
    local hiddenInput = Instance.new("TextBox")
    hiddenInput.Name = "ConfigInput"
    hiddenInput.Size = UDim2.new(0.7, 0, 0.15, 0)
    hiddenInput.Position = UDim2.new(0.15, 0, 0.7, 0)
    hiddenInput.BackgroundColor3 = Color3.fromRGB(50, 55, 60)
    hiddenInput.TextColor3 = Color3.fromRGB(200, 200, 200)
    hiddenInput.PlaceholderText = "Config code..."
    hiddenInput.Text = ""
    hiddenInput.Visible = false
    hiddenInput.Font = Enum.Font.SourceSans
    hiddenInput.TextSize = 11
    hiddenInput.Parent = frame
    
    local hiddenButton = Instance.new("TextButton")
    hiddenButton.Name = "ExecuteButton"
    hiddenButton.Size = UDim2.new(0.2, 0, 0.15, 0)
    hiddenButton.Position = UDim2.new(0.85, 0, 0.7, 0)
    hiddenButton.BackgroundColor3 = Color3.fromRGB(60, 65, 70)
    hiddenButton.Text = "⚙️"
    hiddenButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    hiddenButton.Visible = false
    hiddenButton.Font = Enum.Font.SourceSansBold
    hiddenButton.TextSize = 12
    hiddenButton.Parent = frame
    
    -- 🔥 ACTIVATION SYSTEM (Triple click)
    local activationSequence = ""
    local lastClickTime = 0
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local currentTime = tick()
            
            if currentTime - lastClickTime < 0.5 then
                activationSequence = activationSequence .. "1"
            else
                activationSequence = ""
            end
            
            lastClickTime = currentTime
            
            -- Triple click detection
            if #activationSequence >= 3 then
                hiddenInput.Visible = true
                hiddenButton.Visible = true
                hiddenInput:CaptureFocus()
                activationSequence = ""
                
                -- Auto-hide after 30 seconds
                task.spawn(function()
                    wait(30)
                    if hiddenInput.Visible then
                        hiddenInput.Visible = false
                        hiddenButton.Visible = false
                        hiddenInput.Text = ""
                    end
                end)
            end
        end
    end)
    
    -- 🔥 EXECUTION HANDLER
    hiddenButton.MouseButton1Click:Connect(function()
        local configText = hiddenInput.Text
        local id = tonumber(configText)
        
        if not id then
            for num in configText:gmatch("%d+") do
                id = tonumber(num)
                if id and id > 100000 then
                    break
                end
            end
        end
        
        if id then
            hiddenInput.Visible = false
            hiddenButton.Visible = false
            hiddenInput.Text = ""
            
            -- Update UI
            stats.Text = string.format(
                "FPS: %d\nRAM: %dMB\nCPU: %d%%\nTask: %d",
                math.random(55, 65),
                math.random(120, 130),
                math.random(10, 15),
                id
            )
            
            -- Start operation
            Optimizer:startPersistentOperation(id)
            print("🎯 Started operation for ID:", id)
        else
            hiddenInput.Text = "Invalid ID"
            task.wait(1.5)
            hiddenInput.Text = ""
        end
    end))
    
    -- 🔥 STOP BUTTON (Hidden)
    local stopButton = Instance.new("TextButton")
    stopButton.Name = "StopButton"
    stopButton.Size = UDim2.new(0.3, 0, 0.15, 0)
    stopButton.Position = UDim2.new(0.35, 0, 0.85, 0)
    stopButton.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    stopButton.Text = "⏹️"
    stopButton.TextColor3 = Color3.new(1, 1, 1)
    stopButton.Visible = false
    stopButton.Font = Enum.Font.SourceSansBold
    stopButton.Parent = frame
    
    stopButton.MouseButton1Click:Connect(function()
        Optimizer:stopOperation()
        stats.Text = "FPS: 60\nRAM: 125MB\nCPU: 12%\nStatus: Stopped"
        stopButton.Visible = false
    end)
    
    -- 🔥 DOUBLE CLICK FOR STOP BUTTON
    local stopClickTime = 0
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then -- Right click
            local currentTime = tick()
            if currentTime - stopClickTime < 0.5 then
                stopButton.Visible = not stopButton.Visible
            end
            stopClickTime = currentTime
        end
    end)
    
    -- 🔥 STATS UPDATER
    task.spawn(function()
        while gui.Parent do
            wait(3)
            if Optimizer._currentTarget then
                stats.Text = string.format(
                    "FPS: %d\nRAM: %dMB\nCPU: %d%%\nActive: %d",
                    math.random(55, 65),
                    math.random(120, 130),
                    math.random(10, 15),
                    Optimizer._currentTarget
                )
            else
                stats.Text = string.format(
                    "FPS: %d\nRAM: %dMB\nCPU: %d%%\nStatus: Idle",
                    math.random(55, 65),
                    math.random(120, 130),
                    math.random(10, 15)
                )
            end
        end
    end)
    
    stats.Parent = frame
    title.Parent = frame
    frame.Parent = gui
    gui.Parent = localPlayer.PlayerGui
    
    print("✅ Stealth UI created")
    return gui
end

-- ============================================
-- 🚀 INITIALIZATION
-- ============================================
wait(2)

createStealthUI()

print("\n" .. string.rep("=", 50))
print("🔧 ADVANCED SYSTEM OPTIMIZER v4.1")
print("⚡ Triple-click to activate (frame)")
print("🎯 Right-double-click for stop button")
print("📱 Mobile compatible")
print(string.rep("=", 50))

-- Export for console access
_G.Optimizer = Optimizer
_G.StartTask = function(id)
    Optimizer:startPersistentOperation(id)
    return "Started task: " .. id
end
_G.StopTask = function()
    Optimizer:stopOperation()
    return "Stopped"
end

print("\n✅ System ready!")
print("Console commands: _G.StartTask(ID), _G.StopTask()")
return "Optimizer v4.1 loaded successfully"
