-------------------------------------------------------------------------------
-- Saves logging information in a file
--
-- @author Thiago Costa Ponte (thiago@ideais.com.br)
--
-- @copyright 2004-2011 Kepler Project
--
-------------------------------------------------------------------------------

local logging = import(".logging")

local lastFileNameDatePattern
local lastFileHandler

local openFileLogger = function (filename, datePattern)
	
	local filename = string.format(filename, os.date(datePattern))
	if (lastFileNameDatePattern ~= filename) then
		
		local f = io.open(filename, "a")
		if (f) then
			f:setvbuf ("line")
			lastFileNameDatePattern = filename
			lastFileHandler = f
			return f
		else
			return nil, string.format("file `%s' could not be opened for writing", filename)	
		end
	else
		return lastFileHandler		
	end
	
end

function logging.file(filename, datePattern, logPattern)

    if type(filename) ~= "string" then
        filename = "lualogging.log"
    end

    return logging.new( function(self, level, message)
                            
                            local f, msg = openFileLogger(filename, datePattern)
                            if not f then
                            	error(filename)
						       return nil, msg
						    end              
                            local s = logging.prepareLogMsg(logPattern, os.date("%X"), level, message)
                            f:write(s)
                            return s
                        end
                      )
end

function logging.writeToFile(filename, str)

end

function logging.file(filename, datePattern, logPattern)

    if type(filename) ~= "string" then
        filename = "lualogging.log"
    end

    return logging.new( function(self, level, message)          
                            local s = logging.prepareLogMsg(logPattern, os.date("%X"), level, message)
                            return s
                        end
                      )
end

function logging.writeToFile(filename, str)
	if type(filename) ~= "string" then
        filename = "lualogging.log"
    end
    local f, msg = openFileLogger(filename)
    if not f then
    	error(filename)
       return nil, msg
    end
    f:write(str)
    f:write("\n")
    f:flush()
end

return logging.file

