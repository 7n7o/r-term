local BetterConsole = script:FindFirstAncestor("BetterConsole")

local Class = require(BetterConsole.Common.Class)
local Validate = require(BetterConsole.Common.Validate)
local Console = require(BetterConsole.Console)
local Colors = require(BetterConsole.Colors)
local Directory = require(BetterConsole.Directory)

local LocalPlayer = game.Players.LocalPlayer

local Terminal = Class {
    __type = "terminal",
    [Class.extends] = Console,
    __directory = Directory("home"),
    Colors = Colors,
    store = {},
    constructor = function(name, template)
        super(name)
        self.__template = template or Colors.fromRGB(0, 128, 0).."┌──("..Colors.fromRGB(0, 0, 255).."{user}@{machine}"..Colors.fromRGB(0, 128, 0)..")-["..Colors.fromRGB(255,255,255).."{dir}"..Colors.fromRGB(0, 128, 0).."]\n└─"..Colors.new(0,0,1).."$ "..Colors.default..""
        makefolder("home")
        makefolder(".path")
        self:nextCommand()
    end,
    getPath = function(self)
        return self.__directory:getPath()
    end,
    nextCommand = function(self)
        self:write(self.__template:gsub("{user}", LocalPlayer.DisplayName):gsub("{machine}", LocalPlayer.Name):gsub("{dir}", self.__directory:format()))
        self:inputAsync(function(input)
            self:processCommand(input)
            self:write("\n\n")
            self:nextCommand()
        end)
    end,
    storeValue = function(self, key, value)
        self.store[key] = value
    end,
    getValue = function(self, key)
        return self.store[key]
    end,
    processCommand = function(self, str)
        local args = str:split(" ")
        local cmd = args[1]
        table.remove(args, 1)
        if isfile(self.__directory:getPath().."/"..cmd) then
            local f = loadfile(self.__directory:getPath().."/"..cmd)
            local s, e = pcall(f, self, unpack(args))
            if not s then
                self:write(Colors.new(1,0,0).."Error: "..e)
            end
        elseif isfile("/.path/"..cmd) then
            local f = loadfile("/.path/"..cmd)
            local s, e = pcall(f, self, unpack(args))
            if not s then
                self:write(Colors.new(1,0,0).."Error: "..e)
            end
        else
            self:write("command not found: "..cmd)
        end
    end,
}

return Terminal