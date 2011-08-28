module FusionchartsHelper
  def fusionchart (id, chart, url, width, height)
    render 'shared/fusionchart', :chart_id => id, :chart_name => chart, 
      :xml_url => url, :width => width, :height => height
  end
end