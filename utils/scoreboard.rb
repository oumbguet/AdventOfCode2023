require 'uri'
require 'httparty'
require 'json'

leaderboards = {
    "epitech" => "2442831",
    "inria" => "3260775"
}

members = {
    "Vincent Italiano" => "3291443",
    "Vy" => "1553831",
    "Florian Millet" => "1100927"
}

for key, value in leaderboards
    uri = URI("https://adventofcode.com/2023/leaderboard/private/view/%s.json" % value)
    res = HTTParty.get(uri, headers: {"Cookie" => "session=53616c7465645f5f4559c57b289f439bd800dbc34b4def4fdbb55c8934cf0e87d49ca7362bccf973cff7b7f4b5196a9324e79b2bc086b3e0763bef9cb5423dcf"})

    if res.code == 200
        leaderboard = JSON.parse(res.body)["members"].sort_by { |key,val| val["local_score"].to_i }.reverse.map { |key, val| {"name" => val["name"], "stars" => val["stars"]} }
        puts "================\n%s\n================" % key
        for member_name, member_id in members
            if leaderboard.find { |i| i["name"] == member_name} == nil
                next
            end
            index = leaderboard.map { |l| l["name"] }.index(member_name)
            stars = leaderboard.find { |i| i["name"] == member_name}["stars"]
            if index != nil
                puts "%d. %s - %d/%d stars" % [index + 1, member_name, stars, Time.new.day * 2]
            end
        end
    else
        puts "error"
    end
end