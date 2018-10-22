require 'rspec'
require './lib/bowling'

describe 'bowling' do
  let(:result) { Bowling.score(frames) }

  describe 'scoring one frame' do
    context 'when no pins are struck' do
      let(:frames) { [[ 0, 0 ]] }

      it 'scores 0' do
        expect(result).to be_zero
      end
    end

    context 'when one pin is struck on the first roll only' do
      let(:frames) { [[ 1, 0 ]] }

      it 'scores 1' do
        expect(result).to eq 1
      end
    end

    context 'where one pin is struck with each roll' do
      let(:frames) { [[ 1, 1 ]] }

      it "scores 2" do
        expect(result).to eq 2
      end
    end

    context 'where ten pins are struck with the first roll' do
      let(:frames) { [[ 10, 0 ]] }

      it "scores 10" do
        expect(result).to eq 10
      end
    end
  end

  describe 'scoring two frames' do
    let(:frames) { [first_frame, second_frame]}

    context "where no pins are struck in the two frames" do
      let(:first_frame) { [0, 0] }
      let(:second_frame) { [0, 0] }

      it "scores 0" do
        expect(result).to eq 0
      end
    end

    context "where one pin is struck with the third roll only" do
      let(:first_frame) { [0, 0] }
      let(:second_frame) { [1, 0] }

      it "scores 1" do
        expect(result).to eq 1
      end
    end

    context 'with a spare' do
      let(:first_frame) { [5,5] }

      context 'followed by striking one pin' do
        let(:second_frame) { [1, 0] }

        it "scores 12" do
          expect(result).to eq 12
        end
      end
    end

    context "with a strike" do
      let(:first_frame) { [10, 0]}

      context "followed by striking one pin" do
        let(:second_frame) { [1, 0] }

        it "scores 12" do
          expect(result).to eq 12
        end
      end

      context "followed by striking one pin each with the next two balls" do
        let(:second_frame) { [1, 1] }

        it "scores 14" do
          expect(result).to eq 14
        end
      end
    end
  end

  describe 'scoring three frames' do
    let(:frames) { [first_frame, second_frame, third_frame]}

    context "where a pins is struck in the third frame" do
      let(:first_frame) { [0, 0] }
      let(:second_frame) { [0, 0] }
      let(:third_frame) { [1, 0] }

      it "scores 1" do
        expect(result).to eq 1
      end
    end

    context 'with no spare, but 10 pins hit by the third frame' do
      let(:first_frame) { [1, 1] }
      let(:second_frame) { [1, 7] }
      let(:third_frame) { [1, 0] }

      it "scores 11" do
        expect(result).to eq 11
      end
    end

    context 'with a spare' do
      let(:first_frame) { [0, 0] }
      let(:second_frame) { [5, 5] }

      context 'followed by striking one pin' do
        let(:third_frame) { [1, 0] }

        it "scores 12" do
          expect(result).to eq 12
        end
      end
    end

    context 'with a strike in first frame, then strike in second' do
      let(:first_frame) { [10, 0] }
      let(:second_frame) { [10, 0] }

      context '1 pin struck in the third' do
        let(:third_frame) { [1, 0] }

        it 'score 33' do
          expect(result).to eq 33
        end
      end
    end
  end

  describe 'scoring only in the tenth frame' do
    context 'the first roll strikes one pin' do
      let(:empty_frame) { [0, 0] }
      let(:frames) { Array.new(9, empty_frame) << [1, 0, 0] }

      it "scores 1" do
        expect(result).to eq 1
      end
    end

    xcontext 'each of the rolls strikes one pin' do
      let(:empty_frame) { [0, 0] }
      let(:frames) { Array.new(9, empty_frame) << [1, 1, 1] }

      it 'scores 3' do
        expect(result).to eq 3
      end
    end

    xcontext 'ten with the first two balls, then one more pin' do
      let(:empty_frame) { [0, 0] }
      let(:frames) { Array.new(9, empty_frame) << [9, 1, 1] }

      it 'scores 12' do
        expect(result).to eq 12
      end
    end

    xcontext 'ten with the first ball, one with the second' do
      let(:empty_frame) { [0, 0] }
      let(:frames) { Array.new(9, empty_frame) << [10, 1, 0] }

      it 'scores 12' do
        expect(result).to eq 12
      end
    end
  end
end
