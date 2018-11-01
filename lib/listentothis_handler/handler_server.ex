import HTTPotion
import Poison

defmodule ListentothisHandler.HandlerServer do
    use GenServer
    
    @default_page 0
    @default_section "new"


    #Implementation of User API
    
    def setup_initial_fetch do
        IO.puts __MODULE__

        HTTPotion.get("https://www.reddit.com/api/v1/authorize?client_id=#{@webappid}&response_type=code&state=RANDOM_STRING&redirect_uri=http://localhost:4000&duration=permanent&scope=identity")
        |> IO.puts

        GenServer.start_link(__MODULE__,
                            %{
                                current_page: @default_page, 
                                current_section: @default_section, 
                                secret: @secret
                            },
                            name: __MODULE__)
    end

    def fetch_more do
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