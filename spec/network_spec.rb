require_relative '../lib/noggin'

describe Noggin::Network do 

  describe 'simple node network'

  subject { Noggin::Network.new(max_training_laps: 10)}

  it 'feeds backwords correctly' do
    subject.train(  [
                        { input: [0, 0], output: 0 },
                        { input: [0, 1], output: 1 },
                        { input: [1, 0], output: 1 },
                        { input: [1, 1], output: 0 }
                    ])
  end

end
