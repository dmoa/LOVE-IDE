local Release = {}

-- local OS = "Unix"

Release.exportGame = function(parameters)
    local OS = love.system.getOS()
    if (OS == "OS X") or (OS == "Linux") then
        print("Unix detected!")
        os.execute("time sh main.sh "..table.concat(parameters, " "))
    end
end

Release.exportGame({"/Users/Stanislav003/Desktop/juice-master/", "juice", "mac", "64"})