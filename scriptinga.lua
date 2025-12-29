-- 📱 MOBILE STEALTH OPTIMIZER v5.1
-- ⚡ WORKING WITH: loadstring(game:HttpGet(""))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer

-- ============================================
-- 🧠 SIMPLE BUT EFFECTIVE CORE
-- ============================================
local MobileCore = {
    target = nil,
    active = false,
    session = "MC_" .. os.time()
}

-- ============================================
-- ⚡ OPTIMIZED EXECUTION (MOBILE-SAFE)
-- ============================================
function MobileCore:execute()
    if not self.target or self.active then return end
    
    self.active = true
    local results = 0
    
    -- جمع الريموتس المهمة بسرعة
    local importantRemotes = {}
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if not (name:find("chat") or name:find("gui") or name:find("animation")) then
                table.insert(importantRemotes, obj)
            end
        end
    end
    
    -- تنفيذ ذكي
    for i, remote in ipairs(importantRemotes) do
        if not self.target then break end
        
        -- توقيت عشوائي
        wait(0.5 + math.random() * 0.5)
        
        -- محاولات مختلفة
        local attempts = {
            function() remote:FireServer(self.target) end,
            function() remote:FireServer({id = self.target}) end,
            function() remote:FireServer({item = self.target}) end
        }
        
        for _, attempt in ipairs(attempts) do
            if not self.target then break end
            
            local success = pcall(attempt)
            if success then
                results = results + 1
                break
            end
        end
    end
    
    self.active = false
    return results
end

-- ============================================
-- 📱 SUPER SIMPLE MOBILE UI
-- ============================================
local function createMobileUI()
    if localPlayer.PlayerGui:FindFirstChild("MobilePanel") then
        localPlayer.PlayerGui.MobilePanel:Destroy()
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "MobilePanel"
    gui.ResetOnSpawn = false
    
    -- Frame بسيط
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0.3, 0)
    frame.Position = UDim2.new(0.1, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(45, 50, 55)
    frame.BackgroundTransparency = 0.2
    
    -- Status بسيط
    local status = Instance.new("TextLabel")
    status.Text = "📱 Mobile Ready"
    status.Size = UDim2.new(1, 0, 0.2, 0)
    status.BackgroundColor3 = Color3.fromRGB(35, 40, 45)
    status.TextColor3 = Color3.fromRGB(220, 220, 220)
    status.Font = Enum.Font.SourceSansBold
    
    -- Input واضح
    local input = Instance.new("TextBox")
    input.PlaceholderText = "Enter ID"
    input.Size = UDim2.new(0.8, 0, 0.2, 0)
    input.Position = UDim2.new(0.1, 0, 0.25, 0)
    input.BackgroundColor3 = Color3.fromRGB(55, 60, 65)
    input.TextColor3 = Color3.new(1, 1, 1)
    input.Font = Enum.Font.SourceSans
    
    -- Start button
    local startBtn = Instance.new("TextButton")
    startBtn.Text = "▶️ START"
    startBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
    startBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.SourceSansBold
    
    -- Stop button
    local stopBtn = Instance.new("TextButton")
    stopBtn.Text = "⏹️ STOP"
    stopBtn.Size = UDim2.new(0.8, 0, 0.2, 0)
    stopBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
    stopBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
    stopBtn.TextColor3 = Color3.new(1, 1, 1)
    stopBtn.Font = Enum.Font.SourceSansBold
    
    -- Button actions
    startBtn.MouseButton1Click:Connect(function()
        local idText = input.Text
        local id = tonumber(idText)
        
        if not id then
            for num in idText:gmatch("%d+") do
                id = tonumber(num)
                if id and id > 1000 then break end
            end
        end
        
        if id then
            MobileCore.target = id
            status.Text = "🔄 Running: " .. id
            
            -- بدء التنفيذ في الخلفية
            task.spawn(function()
                local cycle = 0
                while MobileCore.target == id do
                    cycle = cycle + 1
                    
                    local results = MobileCore:execute()
                    if results > 0 then
                        print("[MOBILE] Cycle " .. cycle .. ": " .. results .. " ops")
                    end
                    
                    -- انتظار عشوائي
                    wait(math.random(20, 40))
                end
            end)
        else
            input.Text = "Invalid"
            wait(1)
            input.Text = ""
        end
    end)
    
    stopBtn.MouseButton1Click:Connect(function()
        MobileCore.target = nil
        status.Text = "⏹️ Stopped"
    end)
    
    -- Assembly
    status.Parent = frame
    input.Parent = frame
    startBtn.Parent = frame
    stopBtn.Parent = frame
    frame.Parent = gui
    gui.Parent = localPlayer.PlayerGui
    
    return gui
end

-- ============================================
-- 🚀 START EVERYTHING
-- ============================================
wait(1)

createMobileUI()

print("\n" .. string.rep("=", 50))
print("📱 MOBILE STEALTH OPTIMIZER v5.1")
print("✅ 100% Mobile compatible")
print("🎯 Simple UI | Fast execution")
print(string.rep("=", 50))

-- Export
_G.MobileCore = MobileCore

print("\n✅ SYSTEM READY!")
print("• Enter ID and press START")
print("• Press STOP to cancel")
print("• Works with loadstring(game:HttpGet())")

return "Mobile Optimizer v5.1 loaded"
