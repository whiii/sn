xml.chart(
  :caption => 'Registered users by days',
  :xAxisName => 'Date',
  :yAxisName => 'Users registered',
  :showValues => '0',
  :rotateLabels => '1'
) do  
  @stats.each_pair do |day, count|
    xml.set( :label => day, :value => count )
  end
end 