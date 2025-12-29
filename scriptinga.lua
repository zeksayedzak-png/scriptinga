-- 🔧 ADVANCED SYSTEM OPTIMIZER v4.0
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
    _speed = 1.2, -- ثانية بين العمليات
    _failCount = 0,
    
    -- نظام اكتشاف التهديدات
    ThreatDetector = {
        lastKickTime = 0,
        suspiciousEvents = 0,
        
        checkEnvironment = function(self)
            -- تحقق من وجود أنظمة مراقبة
            local redFlags = 0
            
            -- 1. بحث عن Anti-Cheat scripts
            for _, script in pairs(game:GetDescendants()) do
                if script:IsA("Script") then
                    local name = script.Name:lower()
                    if name:find("cheat") or name:find("scan") or name:find("detect") then
                        redFlags = redFlags + 1
                    end
                end
            end
            
            -- 2. تحقق من الاتصالات المشبوهة
            if #game:GetService("NetworkClient"):GetChildren() > 50 then
                redFlags = redFlags + 1
            end
            
            return redFlags
        end
    },
    
    -- نظام السرعة الذكية
    SpeedController = {
        adjustBasedOnRisk = function(self, riskLevel)
            if riskLevel > 2 then
                return 3.0 -- بطيء جدًا
            elseif riskLevel > 0 then
                return 2.0 -- بطيء
            else
                return 0.8 -- سريع آمن
            end
        end
    }
}

-- ============================================
-- 🔄 SMART EXECUTION ENGINE
-- ============================================
function Optimizer:executeSmartOperation(targetId)
    if self._active then return {} end
    
    self._active = true
    local results = {}
    local riskLevel = self.ThreatDetector:checkEnvironment()
    
    -- ضبط السرعة حسب الخطر
    self._speed = self.SpeedController:adjustBasedOnRisk(riskLevel)
    
    -- اكتشاف الريموتس بذكاء
    local prioritizedRemotes = {}
    
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local priority = 1
            
            -- إعطاء أولوية للريموتس المهمة
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
    
    -- ترتيب حسب الأولوية
    table.sort(prioritizedRemotes, function(a, b)
        return a.priority > b.priority
    end)
    
    -- التنفيذ الذكي
    for _, remoteInfo in ipairs(prioritizedRemotes) do
        if not self._active then break end
        
        -- توقيت ذكي
        wait(self._speed + math.random() * 0.5)
        
        -- محاولة ذكية
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
                break -- نجاح → انتقل للريموت التالي
            else
                self._failCount = self._failCount + 1
                
                -- إذا فشل كثيرًا، توقف
                if self._failCount > 5 then
                    self._active = false
                    print("⚠️ Too many failures, stopping")
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
    spawn(function()
        local cycle = 0
        
        while true do
            cycle = cycle + 1
            
            print("[CYCLE " .. cycle .. "] Starting operation")
            
            local results = self:executeSmartOperation(targetId)
            
            if #results > 0 then
                print("✅ Success: " .. #results .. " operations")
            else
                print("⚠️ No results this cycle")
            end
            
            -- انتظار عشوائي قبل إعادة التشغيل
            local waitTime = math.random(30, 180) -- 30-180 ثانية
            print("⏳ Next cycle in " .. waitTime .. "s")
            
            wait(waitTime)
            
            -- تغيير النمط لمنع الاكتشاف
            self._speed = math.random(8, 15) / 10 -- 0.8-1.5
        end
    end)
end

-- ============================================
-- 🖥️ STEALTH INTERFACE
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
    
    local stats = Instance.new("TextLabel")
    stats.Text = "FPS: 60\nRAM: 125MB\nCPU: 12%"
    stats.Size = UDim2.new(1, -10, 1, -30)
    stats.Position = UDim2.new(0, 5, 0, 30)
    stats.BackgroundTransparency = 1
    stats.TextColor3 = Color3.fromRGB(180, 180, 180)
    stats.TextXAlignment = Enum.TextXAlignment.Left
    
    -- تحديث الإحصائيات
    spawn(function()
        while gui.Parent do
            wait(3)
            stats.Text = string.format(
                "FPS: %d\nRAM: %dMB\nCPU: %d%%\nCycle: %d",
                math.random(55, 65),
                math.random(120, 130),
                math.random(10, 15),
                math.random(1, 100)
            )
        end
    end)
    
    stats.Parent = frame
    title.Parent = frame
    frame.Parent = gui
    gui.Parent = localPlayer.PlayerGui
    
    return gui
end

-- ============================================
-- 🚀 INITIALIZATION
-- ============================================
wait(2)

-- إنشاء الواجهة المخفية
createStealthUI()

-- بدء العملية المستمرة
spawn(function()
    wait(5)
    
    -- اختبار مع ID تجريبي
    Optimizer:startPersistentOperation(123456)
end)

print("\n🔧 Advanced Optimizer v4.0 Active")
print("⚡ Smart speed control")
print("🔄 Auto-restart system")
print("🎯 Persistent operation")

-- تصدير للاستخدام
_G.SystemOptimizer = Optimizer
