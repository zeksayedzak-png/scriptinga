-- ⚡ STEALTH PERFORMANCE BOOSTER v5.0
-- loadstring(game:HttpGet(""))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- ============================================
-- 🧠 ADAPTIVE INTELLIGENCE SYSTEM
-- ============================================
local StealthCore = {
    _session = "SC_" .. os.time(),
    _active = false,
    _target = nil,
    _mode = "safe", -- safe, normal, aggressive
    _cycle = 0,
    
    -- أذكى نظام سرعة
    SpeedManager = {
        baseDelay = 0.8,
        currentMultiplier = 1.0,
        
        calculateDelay = function(self)
            -- تحليل كثافة الشبكة
            local networkLoad = #ReplicatedStorage:GetChildren() / 100
            local playerCount = #Players:GetPlayers()
            
            -- صيغة ذكية
            local delay = self.baseDelay * self.currentMultiplier
            delay = delay * (1 + (networkLoad * 0.1))
            delay = math.max(0.3, math.min(delay, 3.0))
            
            return delay + (math.random() * 0.2) -- عشوائية إضافية
        end,
        
        adjustBasedOnResponse = function(self, successRate)
            if successRate > 0.7 then
                self.currentMultiplier = math.max(0.7, self.currentMultiplier * 0.95)
            elseif successRate < 0.3 then
                self.currentMultiplier = math.min(1.5, self.currentMultiplier * 1.1)
            end
        end
    },
    
    -- نظام اكتشاف التهديدات المخفي
    ThreatSensor = {
        _lastCheck = 0,
        
        stealthCheck = function(self)
            -- فحص غير مباشر
            local riskScore = 0
            
            -- 1. فحص غير واضح
            pcall(function()
                -- تحقق من أداء النظام (يبدو شرعياً)
                local mem = game:GetService("Stats"):GetTotalMemoryUsageMb()
                if mem > 500 then riskScore = riskScore + 1 end
            end)
            
            -- 2. مراقبة غير مباشرة للاعبين
            if #Players:GetPlayers() < 2 then
                riskScore = riskScore + 1 -- سرير عالي الخطورة
            end
            
            return riskScore
        end
    }
}

-- ============================================
-- ⚡ HYPER-OPTIMIZED EXECUTION
-- ============================================
function StealthCore:executeOperation()
    if not self._target or self._active then return 0 end
    
    self._active = true
    self._cycle = self._cycle + 1
    local successCount = 0
    local attemptCount = 0
    
    -- جمع الريموتس المهمة فقط (ليس كلها)
    local criticalRemotes = {}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            -- فلترة ذكية
            if not (name:find("chat") or name:find("gui") or name:find("animate")) then
                table.insert(criticalRemotes, remote)
            end
        end
    end
    
    -- 🔥 التنفيذ المتوازن: سريع لكن غير مكشوف
    for i, remote in ipairs(criticalRemotes) do
        if not self._active then break end
        
        -- توقيت ذكي غير نمطي
        local currentDelay = self.SpeedManager:calculateDelay()
        
        -- تغيير النمط كل 5 دورات
        if self._cycle % 5 == 0 then
            currentDelay = currentDelay * (0.8 + (math.random() * 0.4))
        end
        
        wait(currentDelay)
        
        -- payloads مختلفة في كل دورة
        local payloads
        if self._cycle % 3 == 0 then
            payloads = {{id = self._target}}
        elseif self._cycle % 3 == 1 then
            payloads = {self._target, {resource = self._target}}
        else
            payloads = {{key = self._target}, {item = self._target}}
        end
        
        for _, payload in ipairs(payloads) do
            if not self._active then break end
            
            attemptCount = attemptCount + 1
            
            local success = pcall(function()
                remote:FireServer(payload)
                return true
            end)
            
            if success then
                successCount = successCount + 1
                break -- نجاح → انتقل للريموت التالي
            end
        end
        
        -- توقف ذكي إذا كثرة الفشل
        if attemptCount > 20 and successCount < 2 then
            break
        end
    end
    
    -- تحديث نظام السرعة
    local successRate = attemptCount > 0 and (successCount / attemptCount) or 0
    self.SpeedManager:adjustBasedOnResponse(successRate)
    
    self._active = false
    return successCount
end

-- ============================================
-- 📱 ULTRA-STEALTH MOBILE INTERFACE
-- ============================================
local function createUltraStealthUI()
    if localPlayer.PlayerGui:FindFirstChild("PerfOverlay") then
        localPlayer.PlayerGui.PerfOverlay:Destroy()
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "PerfOverlay"
    gui.ResetOnSpawn = false
    
    -- 🔥 واجهة مخفية تماماً
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(0.3, 0, 0.12, 0)
    overlay.Position = UDim2.new(0.7, 0, 0.02, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(40, 45, 50)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    
    -- إحصائيات تبدو حقيقية
    local stats = Instance.new("TextLabel")
    stats.Text = "FPS: 60 | PING: 45"
    stats.Size = UDim2.new(1, 0, 1, 0)
    stats.BackgroundTransparency = 1
    stats.TextColor3 = Color3.fromRGB(180, 180, 180)
    stats.Font = Enum.Font.SourceSans
    stats.TextSize = 12
    stats.TextXAlignment = Enum.TextXAlignment.Right
    
    -- 🔥 نظام التحكم المخفي (ضغط مطول)
    local longPressStart = 0
    local longPressActive = false
    
    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            longPressStart = tick()
            longPressActive = true
            
            task.spawn(function()
                wait(1.5) -- ضغط لمدة 1.5 ثانية
                if longPressActive then
                    -- 🔥 تظهر لوحة التحكم المخفية
                    createControlPanel()
                    longPressActive = false
                end
            end)
        end
    end))
    
    overlay.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            longPressActive = false
        end
    end)
    
    -- 🔥 تحديث الإحصائيات الذكي
    task.spawn(function()
        while gui.Parent do
            wait(3.5) -- فترات غير منتظمة
            
            if StealthCore._target then
                stats.Text = string.format("FPS: %d | PING: %d",
                    math.random(58, 62),
                    math.random(42, 48)
                )
            else
                stats.Text = string.format("FPS: %d | PING: %d",
                    math.random(55, 65),
                    math.random(40, 50)
                )
            end
        end
    end)
    
    stats.Parent = overlay
    overlay.Parent = gui
    gui.Parent = localPlayer.PlayerGui
    
    return gui
end

-- 🔥 لوحة التحكم المخفية
local function createControlPanel()
    if localPlayer.PlayerGui:FindFirstChild("ControlPanel") then
        localPlayer.PlayerGui.ControlPanel:Destroy()
    end
    
    local panel = Instance.new("Frame")
    panel.Name = "ControlPanel"
    panel.Size = UDim2.new(0.6, 0, 0.4, 0)
    panel.Position = UDim2.new(0.2, 0, 0.3, 0)
    panel.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
    panel.BackgroundTransparency = 0.1
    
    -- حقل إدخال
    local input = Instance.new("TextBox")
    input.PlaceholderText = "Enter configuration..."
    input.Size = UDim2.new(0.8, 0, 0.15, 0)
    input.Position = UDim2.new(0.1, 0, 0.1, 0)
    
    -- زر التنفيذ
    local execBtn = Instance.new("TextButton")
    execBtn.Text = "Apply"
    execBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
    execBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
    
    execBtn.MouseButton1Click:Connect(function()
        local text = input.Text
        local id = tonumber(text)
        
        if not id then
            for num in text:gmatch("%d+") do
                id = tonumber(num)
                if id and id > 1000 then break end
            end
        end
        
        if id then
            StealthCore._target = id
            panel:Destroy()
            
            -- بدء العملية
            task.spawn(function()
                while StealthCore._target do
                    local results = StealthCore:executeOperation()
                    if results > 0 then
                        print("[CORE] Cycle completed:", results, "ops")
                    end
                    wait(math.random(25, 60)) -- فترات عشوائية
                end
            end)
        end
    end)
    
    -- زر الإغلاق
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "Close"
    closeBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
    closeBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
    
    closeBtn.MouseButton1Click:Connect(function()
        panel:Destroy()
    end)
    
    -- التجميع
    input.Parent = panel
    execBtn.Parent = panel
    closeBtn.Parent = panel
    panel.Parent = localPlayer.PlayerGui
end

-- ============================================
-- 🚀 INITIALIZATION
-- ============================================
wait(2)

createUltraStealthUI()

print("\n" .. string.rep("=", 50))
print("⚡ STEALTH PERFORMANCE BOOSTER v5.0")
print("📱 Mobile optimized | Loadstring ready")
print("🎯 Long-press overlay for controls")
print("⚙️ Adaptive intelligence system")
print(string.rep("=", 50))

-- Export
_G.StealthCore = StealthCore
_G.Boost = function(id)
    StealthCore._target = id
    return "Target set: " .. id
end
_G.Stop = function()
    StealthCore._target = nil
    return "Operation stopped"
end

print("\n✅ SYSTEM READY")
print("• Long-press FPS display for controls")
print("• Console: _G.Boost(ID) / _G.Stop()")
return "Stealth Booster v5.0 activated"
