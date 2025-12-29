-- 📱 DELTA MOBILE EXECUTOR v2.0 (PROTECTED)
-- loadstring(game:HttpGet("URL"))()

while not game:IsLoaded() do wait() end

local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage
local player = Players.LocalPlayer

-- ============================================
-- 🛡️ PROTECTION SYSTEM
-- ============================================
local Protection = {
    _lastRequestTime = 0,
    _requestCount = 0,
    _maxRequestsPerMinute = 15,
    _blocked = false,
    
    -- Rate Limiting
    checkRateLimit = function(self)
        local currentTime = os.time()
        
        -- Reset counter every minute
        if currentTime - self._lastRequestTime > 60 then
            self._requestCount = 0
            self._lastRequestTime = currentTime
        end
        
        self._requestCount = self._requestCount + 1
        
        if self._requestCount > self._maxRequestsPerMinute then
            self._blocked = true
            wait(30) -- Block for 30 seconds
            self._blocked = false
            self._requestCount = 0
            return false
        end
        
        return true
    end,
    
    -- Fake Legitimate Activity
    createFakeActivity = function()
        -- Create fake system events
        local fakeEvents = {
            "PlayerDataUpdate",
            "GameStateSync", 
            "PerformanceCheck",
            "NetworkPing"
        }
        
        return fakeEvents[math.random(1, #fakeEvents)]
    end
}

-- ============================================
-- ⚡ SMART EXECUTION WITH PROTECTION
-- ============================================
local targetID = nil
local isRunning = false

local function executeProtectedOperation()
    if not targetID or isRunning or Protection._blocked then 
        return 0 
    end
    
    -- Check rate limit
    if not Protection:checkRateLimit() then
        print("⚠️ Rate limit exceeded, waiting...")
        return 0
    end
    
    isRunning = true
    local successCount = 0
    local totalAttempts = 0
    
    -- Get remotes intelligently
    local potentialRemotes = {}
    
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            
            -- Skip obvious non-target remotes
            if not (name:find("chat") or name:find("gui") or name:find("sound")) then
                table.insert(potentialRemotes, obj)
            end
        end
    end
    
    -- Execute with protection
    for _, remote in pairs(potentialRemotes) do
        if not targetID or Protection._blocked then break end
        
        -- Random delay between attempts
        local delay = 0.4 + (math.random() * 0.4)
        wait(delay)
        
        -- Try different payload patterns
        local payloads = {
            targetID,
            {id = targetID, timestamp = os.time()},
            {resource = targetID, action = "update"}
        }
        
        for _, payload in ipairs(payloads) do
            if not targetID then break end
            
            totalAttempts = totalAttempts + 1
            
            -- Mix with fake requests
            if math.random(1, 4) == 1 then
                local fakeEvent = Protection.createFakeActivity()
                pcall(function()
                    remote:FireServer({action = fakeEvent})
                end)
                wait(0.1)
            end
            
            -- Real attempt
            local success = pcall(function()
                remote:FireServer(payload)
                return true
            end)
            
            if success then
                successCount = successCount + 1
                break -- Move to next remote
            end
            
            -- If too many failures, slow down
            if totalAttempts > 10 and successCount == 0 then
                wait(2)
            end
        end
        
        -- Don't scan all remotes at once
        if #potentialRemotes > 20 then
            if math.random(1, 3) == 1 then
                break
            end
        end
    end
    
    isRunning = false
    
    -- Auto-adjust based on success rate
    if successCount == 0 and totalAttempts > 5 then
        Protection._maxRequestsPerMinute = math.max(5, Protection._maxRequestsPerMinute - 2)
        print("🔻 Slowing down due to low success")
    elseif successCount > 3 then
        Protection._maxRequestsPerMinute = math.min(25, Protection._maxRequestsPerMinute + 1)
    end
    
    return successCount
end

-- ============================================
-- 📱 PROTECTED UI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SystemMonitor"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.8, 0, 0.35, 0)
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Text = "🖥️ System Monitor"
title.Size = UDim2.new(1, 0, 0.15, 0)
title.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- Stats display
local stats = Instance.new("TextLabel")
stats.Text = "FPS: 60\nRAM: 125MB\nStatus: Idle"
stats.Size = UDim2.new(0.45, 0, 0.6, 0)
stats.Position = UDim2.new(0.05, 0, 0.2, 0)
stats.BackgroundTransparency = 1
stats.TextColor3 = Color3.fromRGB(180, 180, 180)
stats.TextXAlignment = Enum.TextXAlignment.Left
stats.Font = Enum.Font.SourceSans
stats.Parent = mainFrame

-- Input field
local input = Instance.new("TextBox")
input.PlaceholderText = "Config code..."
input.Size = UDim2.new(0.45, 0, 0.2, 0)
input.Position = UDim2.new(0.5, 0, 0.2, 0)
input.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
input.TextColor3 = Color3.new(1, 1, 1)
input.Font = Enum.Font.SourceSans
input.Parent = mainFrame

-- Start button
local startBtn = Instance.new("TextButton")
startBtn.Text = "▶️ Run"
startBtn.Size = UDim2.new(0.45, 0, 0.2, 0)
startBtn.Position = UDim2.new(0.5, 0, 0.45, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 200)
startBtn.TextColor3 = Color3.new(1, 1, 1)
startBtn.Font = Enum.Font.SourceSansBold
startBtn.Parent = mainFrame

-- Stop button
local stopBtn = Instance.new("TextButton")
stopBtn.Text = "⏹️ Stop"
stopBtn.Size = UDim2.new(0.45, 0, 0.2, 0)
stopBtn.Position = UDim2.new(0.5, 0, 0.7, 0)
stopBtn.BackgroundColor3 = Color3.fromRGB(110, 30, 30)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.Parent = mainFrame

-- Status updater
task.spawn(function()
    while screenGui.Parent do
        wait(4)
        
        if targetID then
            stats.Text = string.format("FPS: %d\nRAM: %dMB\nTarget: %d\nOps/min: %d",
                math.random(58, 62),
                math.random(120, 130),
                targetID,
                Protection._requestCount
            )
        else
            stats.Text = string.format("FPS: %d\nRAM: %dMB\nStatus: Idle\nRate: %d/min",
                math.random(55, 65),
                math.random(120, 130),
                Protection._maxRequestsPerMinute
            )
        end
    end
end)

-- Button logic
startBtn.MouseButton1Click:Connect(function()
    local text = input.Text
    local id = tonumber(text)
    
    if not id then
        for num in text:gmatch("%d+") do
            id = tonumber(num)
            if id and id > 1000 then break end
        end
    end
    
    if id then
        if targetID then
            targetID = nil
            wait(0.5)
        end
        
        targetID = id
        input.Text = ""
        
        -- Start protected operation
        task.spawn(function()
            while targetID == id do
                local results = executeProtectedOperation()
                
                if results > 0 then
                    print("✅ Protected ops:", results)
                end
                
                -- Random interval between cycles
                wait(math.random(20, 40))
            end
        end)
    else
        input.Text = "Invalid"
        wait(1.5)
        input.Text = ""
    end
end)

stopBtn.MouseButton1Click:Connect(function()
    targetID = nil
    Protection._requestCount = 0
end)

-- ============================================
-- 🚀 INITIALIZATION
-- ============================================
print("\n" .. string.rep("=", 50))
print("🛡️ PROTECTED DELTA EXECUTOR v2.0")
print("📱 Mobile optimized | Rate limited")
print("🎯 Smart execution | Fake activity")
print(string.rep("=", 50))

_G.ProtectedCore = {
    start = function(id) 
        targetID = id 
        return "Protected start: " .. id 
    end,
    stop = function() 
        targetID = nil 
        return "Stopped" 
    end,
    status = function() 
        return {
            active = targetID ~= nil,
            rateLimit = Protection._maxRequestsPerMinute,
            requests = Protection._requestCount
        }
    end
}

print("\n✅ PROTECTED SYSTEM READY")
print("• Rate limiting: " .. Protection._maxRequestsPerMinute .. "/min")
print("• Fake activity generation")
print("• Smart payload variation")
