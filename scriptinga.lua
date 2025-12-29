-- 📱 DELTA MOBILE EXECUTOR v1.0
-- loadstring(game:HttpGet("URL"))()

-- انتظر اللعبة
while not game:IsLoaded() do wait() end

-- الخدمات الأساسية
local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage

-- تحقق من اللاعب
local player = Players.LocalPlayer
if not player then
    print("❌ No player found")
    return
end

-- المتغيرات الأساسية
local targetID = nil
local isRunning = false

-- الدالة الأساسية
local function executeOperation()
    if not targetID or isRunning then return 0 end
    
    isRunning = true
    local count = 0
    
    -- ابحث عن RemoteEvents بسيط
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            -- حاول
            local success = pcall(function()
                obj:FireServer(targetID)
            end)
            
            if success then
                count = count + 1
            end
            
            -- انتظر قليلاً
            wait(0.3)
        end
    end
    
    isRunning = false
    return count
end

-- ============================================
-- 📱 واجهة بسيطة جداً للهاتف
-- ============================================

-- أنشئ UI بسيط
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaMobileUI"
screenGui.Parent = player.PlayerGui

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.8, 0, 0.3, 0)
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.Parent = screenGui

-- العنوان
local title = Instance.new("TextLabel")
title.Text = "📱 Delta Tool"
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- حقل الإدخال
local inputBox = Instance.new("TextBox")
inputBox.PlaceholderText = "Enter ID"
inputBox.Size = UDim2.new(0.8, 0, 0.2, 0)
inputBox.Position = UDim2.new(0.1, 0, 0.25, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Parent = mainFrame

-- زر البدء
local startButton = Instance.new("TextButton")
startButton.Text = "▶️ START"
startButton.Size = UDim2.new(0.8, 0, 0.2, 0)
startButton.Position = UDim2.new(0.1, 0, 0.5, 0)
startButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Parent = mainFrame

-- زر الإيقاف
local stopButton = Instance.new("TextButton")
stopButton.Text = "⏹️ STOP"
stopButton.Size = UDim2.new(0.8, 0, 0.2, 0)
stopButton.Position = UDim2.new(0.1, 0, 0.75, 0)
stopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.Parent = mainFrame

-- الحالة
local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "Ready"
statusLabel.Size = UDim2.new(1, 0, 0.15, 0)
statusLabel.Position = UDim2.new(0, 0, 0.95, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.Parent = mainFrame

-- ============================================
-- ⚡ منطق الأزرار
-- ============================================

startButton.MouseButton1Click:Connect(function()
    local text = inputBox.Text
    local id = tonumber(text)
    
    if id then
        targetID = id
        statusLabel.Text = "Running: " .. id
        
        -- ابدأ العملية في الخلفية
        task.spawn(function()
            while targetID == id do
                local result = executeOperation()
                if result > 0 then
                    print("✅ Operations: " .. result)
                end
                wait(5) -- انتظر 5 ثواني
            end
        end)
    else
        inputBox.Text = "Invalid ID"
        wait(1)
        inputBox.Text = ""
    end
end)

stopButton.MouseButton1Click:Connect(function()
    targetID = nil
    statusLabel.Text = "Stopped"
end)

-- ============================================
-- 🚀 بدء النظام
-- ============================================

print("\n" .. string.rep("=", 40))
print("📱 DELTA MOBILE TOOL v1.0")
print("✅ Loaded successfully")
print(string.rep("=", 40))

-- تصدير للكونسول
_G.DeltaTool = {
    start = function(id)
        targetID = id
        return "Started: " .. id
    end,
    stop = function()
        targetID = nil
        return "Stopped"
    end
}

print("\n🎮 UI Ready! Enter ID and press START")
print("💻 Console: _G.DeltaTool.start(ID)")
