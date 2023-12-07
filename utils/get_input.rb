require 'uri'
require 'net/http'
require 'httparty'

def get_input(day)

    # Check if a file exists
    if File.file?("day%d.txt" % day)
        return File.read("day%d.txt" % day)
    else
        # If not, get the input from the website and save it to a file
        uri = URI("https://adventofcode.com/2023/day/%d/input" % day)
        res = HTTParty.get(uri, headers: {"Cookie" => "session=53616c7465645f5f4559c57b289f439bd800dbc34b4def4fdbb55c8934cf0e87d49ca7362bccf973cff7b7f4b5196a9324e79b2bc086b3e0763bef9cb5423dcf"})
        
        if res.code == 200
            File.open("day%d.txt" % day, "w") { |f| f.write(res.body) }
            return res.body
        else
            return nil
        end
    end

    return nil
end