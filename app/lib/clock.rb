class Clock < Time
  def self.utc
    @utc_time || Time.now.utc.to_s
  end

  def self.utc=(utc_time)
    @utc_time = utc_time
  end
end
