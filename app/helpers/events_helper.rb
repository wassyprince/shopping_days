module EventsHelper 
  ROKUYOU = %w[先勝 友引 先負 仏滅 大安 赤口].freeze 
  def rokuyou(date) 
    return "" if date.nil? 
    
    date = date.to_date 
    
    base = Date.new(1900, 1, 1) # 六曜の基準日（大安） 
    
    diff = (date - base).to_i 
    text = ROKUYOU[diff % 6] 

    color = text == "大安" ? "red" : "black" 
    "<span style='color:#{color};'>#{text}</span>".html_safe 
  end
end