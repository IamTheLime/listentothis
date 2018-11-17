import HTTPotion
import Poison

#This module will handle pagination and parsing off all data incomming from the listentothis subreddit

defmodule ListentothisHandler.HandlerServer do
    use GenServer
    
    @default_page 0
    @default_section "new"


    #Implementation of User API
    def initial_fetcher(section) do
        HTTPotion.get("https://www.reddit.com/r/listentothis/#{section}.json?limit=1&after=t3_9wu4hg").body
        |>Poison.Parser.parse!(%{})
    end

    def initial_fetcher(section,:before,before_code) do
        HTTPotion.get("https://www.reddit.com/r/listentothis/#{section}.json?limit=1&before=#{before_code}").body
        |>Poison.Parser.parse!(%{})
    end

    
    def initial_fetcher(section,:after,after_code) do
        HTTPotion.get("https://www.reddit.com/r/listentothis/#{section}.json?limit=1&after=#{after_code}").body
        |>Poison.Parser.parse!(%{})
    end

    def setup_initial_fetch do
        IO.puts __MODULE__

        GenServer.start_link(__MODULE__,
                            %{
                                current_page: @default_page, 
                                current_section: @default_section
                            },
                            name: __MODULE__)
    end

    def fetch_more do
        # HTTPotion.get("https://www.reddit.com/r/listentothis/new.json?limit=5&after=t3_9tc8aj")
        GenServer.call __MODULE__, :more 
    end

    # Implementation of Server Callbacks
    
    def init(initmap) do
        
        {:ok,initmap}
    end

    def handle_call(:more, _from, state) do
        {:reply, state, state}
    end


    # def handle_cast(:reload, _state) do
    #     { :noreply, 
    #         %{                
    #         }
    #     }
    # end


    # def handle_info(:work, _state) do
    #     schedule_work()
    #     IO.puts "I havbe completed the reloading work"
    #     { :noreply, 
    #         %{ 
    #             @today => Meteo.cityDetailsIdentifier(@today) , 
    #             @tomorrow => Meteo.cityDetailsIdentifier(@tomorrow) ,
    #             @aftertomorrow => Meteo.cityDetailsIdentifier(@aftertomorrow)
    #         }
    #     }
    # end

    # defp schedule_work() do
    #     Process.send_after(self(), :work, 60 * 1000) 
    # end

end