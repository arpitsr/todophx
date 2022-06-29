defmodule TodophxWeb.Live.Utils.Css do
  def get_strike_css(state) do
    if state == true do
      "line-through"
    else
      ""
    end
  end
end
