require_relative '../lib/noggin'

describe Noggin::Network do 

  describe 'simple node network'

  subject { Noggin::Network.new( max_training_laps: 1, learning_rate: 0.01 ) }

  it 'feeds backwords correctly' do
    subject.train([
      { input: [7, 7], output: 0 },
      { input: [88, 88], output: 1 }
    ])
    subject.pretty_print
  end

end
