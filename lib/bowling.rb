class Bowling
  def self.score(frames)
    total = 0
    @multiplier = 1

    frames.each do |frame|
      total += score_first_ball(frame[0])
      total += score_second_ball(frame[1])

      set_next_frame_bonuses(frame)
    end

    total
  end

  def self.set_next_frame_bonuses(frame)
    strike = frame[0] == 10
    spare = frame[0] + frame[1] == 10

    if strike
      if @previous_frame_strike
        @multiplier += 2
      else
        @multiplier += 1
      end
    elsif spare
      @multiplier += 1
    end

    @previous_frame_strike = frame[0] == 10
  end

  def self.score_first_ball(ball)
    result = ball * @multiplier

    if @multiplier > 1
      @multiplier -= 1
    end

    result
  end

  def self.score_second_ball(ball)
    multiplier = @previous_frame_strike ? 2 : 1
    ball * multiplier
  end

  # def self.score_third_ball(ball)
  #   @previous_frame_spare ? ball * 2 : ball
  # end
end

# for splitting the frames later
# nine_frames, tenth_frame = frames.each_slice(9).to_a
