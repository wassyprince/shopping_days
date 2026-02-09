module EventsHelper 
  ROKUYOU = %w[先勝 友引 先負 仏滅 大安 赤口].freeze 

  def rokuyou(date) 
    index = (date.month + date.day) % 6 
    text = ROKUYOU[index]

    styled = 
    if text == "大安" 
      "<span style='color:red;'>#{text}</span>"
    else 
      "<span style='color:black;'>#{text}</span>"
    end 
    
    styled.html_safe
  end 
end