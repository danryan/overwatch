class Time
  def round(sec=1)
    down = self - (self.to_i % sec)
    up = down + sec

    difference_down = self - down
    difference_up = up - self

    if (difference_down < difference_up)
      return down
    else
      return up
    end
  end
end

class DateTime
  def round(sec=1)
    down = self - (self.to_i % sec)
    up = down + sec

    difference_down = self - down
    difference_up = up - self

    if (difference_down < difference_up)
      return down
    else
      return up
    end
  end
end
