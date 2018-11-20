import HTTPotion
import Poison
require IEx

defmodule ListentothisReddit.Getter do

    def parse_list(list) do
        Enum.map(list,fn x -> %{
            :music_info => %{
                :title => x["data"]["title"], 
                :permalink => x["data"]["permalink"], 
                :secure_media => x["data"]["secure_media"]
                }
            } 
        end)
    end
# API to access reddit pages
    def reddit_fetcher(section) do
        data = HTTPotion.get("https://www.reddit.com/r/listentothis/#{section}.json?limit=1&after=t3_9wu4hg").body
            |>Poison.Parser.parse!(%{})
        %{
            :navigation_code => data["data"]["after"], 
            :playlist => parse_list(data["data"]["children"]) 
        }
    end

    def reddit_fetcher(section,:before,before_code) do
        HTTPotion.get("https://www.reddit.com/r/listentothis/#{section}.json?limit=1&before=#{before_code}").body
        |>Poison.Parser.parse!(%{})
    end

    def reddit_fetcher(section,:after,after_code) do
        HTTPotion.get("https://www.reddit.com/r/listentothis/#{section}.json?limit=1&after=#{after_code}").body
        |>Poison.Parser.parse!(%{})
    end
end