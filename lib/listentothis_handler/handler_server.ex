import ListentothisReddit.Getter
require IEx
#This module will handle pagination of all data incomming from the listentothis subreddit, it will also cache 20 posts at a time for optimal access

defmodule ListentothisHandler.HandlerServer do
    use GenServer
    
    @default_page 0
    @new_section "new"
    @top_section "top"
    @default_section @new_section

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
        GenServer.call __MODULE__, :more 
    end

    def stop_server do
        GenServer.cast __MODULE__, :kill_server
    end
    
    # Implementation of Server Callbacks
    
    def init(initmap) do
        updatedmap = Map.merge initmap, %{parsed_data: reddit_fetcher(@default_section)["data"]}
        IEx.pry
        {:ok,updatedmap}
    end

    def handle_call(:more, _from, state) do
        {:reply, state, state}
    end

    def handle_cast(:kill_server, state) do
        {:stop, :normal, :state}
    end


    #Auxiliary snippets that can be of interest, need to create a gist for this
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