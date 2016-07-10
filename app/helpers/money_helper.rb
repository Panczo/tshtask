module MoneyHelper
  def median(array)
    sorted = array.sort
    len = sorted.length
    ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0).round(4)
  end

  def average(array)
    total = array.inject(:+)
    len = array.length
    average = (total.to_f / len).round(4)
  end 
end
