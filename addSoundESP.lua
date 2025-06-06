-- Sound ESP Integration Function для добавления в существующий GUI
-- https://github.com/ipso1337/neversuckcock/blob/main/soundESP

local function addSoundESPToGUI(gui, tabName)
    tabName = tabName or "Sound ESP"
    
    -- Загрузка Sound ESP модуля с GitHub
    local SoundESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ipso1337/neversuckcock/main/soundESP"))()
    
    -- Создание нового таба
    local soundTab = gui:tab{
        Icon = "rbxassetid://6764432408",
        Name = tabName
    }
    
    -- Переменные состояния
    local isEnabled = false
    
    -- Кнопка включения/выключения
    soundTab:button({
        Name = "Toggle Sound ESP",
        Callback = function()
            if isEnabled then
                SoundESP:Stop()
                gui:set_status("Sound ESP: OFF")
                isEnabled = false
            else
                SoundESP:Start()
                gui:set_status("Sound ESP: ON")
                isEnabled = true
            end
        end,
    })
    
    -- Настройка размера кругов
    soundTab:slider({
        Name = "Circle Size",
        Min = 1,
        Max = 10,
        Default = 3,
        Callback = function(v)
            SoundESP:SetSize(v)
        end
    })
    
    -- Настройка прозрачности
    soundTab:slider({
        Name = "Transparency",
        Min = 0,
        Max = 1,
        Default = 0.3,
        Callback = function(v)
            SoundESP:SetTransparency(v)
        end
    })
    
    -- Настройка длительности
    soundTab:slider({
        Name = "Duration (sec)",
        Min = 0.5,
        Max = 5,
        Default = 2,
        Callback = function(v)
            SoundESP:SetDuration(v)
        end
    })
    
    -- Настройка расстояния между шагами
    soundTab:slider({
        Name = "Step Distance",
        Min = 1,
        Max = 10,
        Default = 3,
        Callback = function(v)
            SoundESP:SetStepDistance(v)
        end
    })
    
    -- Выбор цвета
    soundTab:color_picker({
        Name = "Circle Color",
        Style = Library.ColorPickerStyles.Legacy,
        Description = "Click to adjust color...",
        Callback = function(color)
            SoundESP:SetColor(color)
        end,
    })
    
    -- Выбор кого отслеживать
    soundTab:dropdown({
        Name = "Target Players",
        StartingText = "All Players",
        Items = {
            "All Players",
            "Local Player Only"
        },
        Description = "Choose who to track",
        Callback = function(v)
            SoundESP:SetShowAllPlayers(v == "All Players")
            if isEnabled then
                SoundESP:Stop()
                SoundESP:Start()
            end
        end,
    })
    
    -- Кнопка очистки всех кругов
    soundTab:button({
        Name = "Clear All Circles",
        Callback = function()
            for _, part in pairs(workspace:GetChildren()) do
                if part.Name == "SoundCircle" then
                    part:Destroy()
                end
            end
            gui:set_status("Circles cleared")
        end,
    })
    
    return soundTab
end

return addSoundESPToGUI
