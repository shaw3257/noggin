require_relative '../lib/noggin'

describe Noggin::Network do 

  subject { Noggin::Network.new( max_training_laps: 1, learning_rate: 0.1, hidden_layer_size: 1, hidden_layer_node_size: 1 ) }

  let(:input_node) { subject.layers[0].first }
  let(:hidden_node) { subject.layers[1].first }
  let(:output_node) { subject.layers[2].first }
    
  before do
    allow_any_instance_of(Noggin::Node::Edge).to receive(:weight).and_return(0.66)
    subject.train [{ input: [1], output: 0 }]
  end

  it 'sets up the network graph according to settings' do
    expect(input_node.dests.first.dest).to eq hidden_node
    expect(hidden_node.dests.first.dest).to eq output_node
  end

  it 'sets hidden layer size' do
    expect(subject.layers.size).to eq(3)
  end

  it 'sets hidden layer node size' do
    expect(subject.layers[1].size).to eq(1)
  end

  it 'backpropagates error' do
    expect(input_node.dests.first.derivative).to be_within(0.00001).of(0.02147)
    expect(hidden_node.dests.first.derivative).to be_within(0.00001).of(0.095468)
  end

end


describe :xor do

  subject { Noggin::Network.new( max_training_laps: 10000, learning_rate: 0.1, hidden_layer_size: 1, hidden_layer_node_size: 2, log: true ) }


  before do
    subject.train([
      { input: [0, 0], output: 0 },
      { input: [0, 1], output: 1 },
      { input: [1, 0], output: 1 },
      { input: [1, 1], output: 0 }
    ])
  end

  it 'learns xor' do
   
  end

end