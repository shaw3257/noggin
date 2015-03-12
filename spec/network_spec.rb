require_relative '../lib/noggin'

describe :calculations do

  MOCK_WEIGHT = 0.66

  subject { Noggin::Network.new hidden_layer_node_size: 2, training_laps: 1 }

  let(:input_neuron_one) { subject.layers[0].neurons[0] }

  let(:input_neuron_two) { subject.layers[0].neurons[1] }

  let(:hidden_bias) { subject.layers[1].bias }

  let(:hidden_neuron_one) { subject.layers[1].neurons[0] }

  let(:hidden_neuron_two) { subject.layers[1].neurons[1] }

  let(:output_bias) { subject.layers[2].bias }

  let(:output_neuron) { subject.layers[2].neurons[0] }

  let(:input_neuron_one_edge_one) { input_neuron_one.dests[0] }

  let(:input_neuron_one_edge_two) { input_neuron_one.dests[1] }

  let(:input_neuron_two_edge_one) { input_neuron_two.dests[0] }

  let(:input_neuron_two_edge_two) { input_neuron_two.dests[1] }

  let(:hidden_neuron_one_edge_one) { hidden_neuron_one.dests[0] }

  let(:hidden_neuron_two_edge_one) { hidden_neuron_two.dests[0] }

  let(:hidden_bias_edge_one) { hidden_bias.dests[0] }

  let(:hidden_bias_edge_two) { hidden_bias.dests[1] }

  let(:output_bias_edge_one) { output_bias.dests[0] }


  before do

    allow_any_instance_of(Noggin::Edge).to receive(:weight).and_return(MOCK_WEIGHT)

    subject.train( [{ input: [1,0], expected: 0.2 }] )

  end

  describe 'forward' do

    it 'forwards data correctly' do

      expect(input_neuron_one.forward_output).to eq(1)
      expect(input_neuron_two.forward_output).to eq(0)

      expect(input_neuron_one_edge_one.forward_input).to eq(1)
      expect(input_neuron_one_edge_two.forward_input).to eq(1)
      expect(input_neuron_two_edge_one.forward_input).to eq(0)
      expect(input_neuron_two_edge_two.forward_input).to eq(0)

      expect(input_neuron_one_edge_one.forward_output).to eq(0.66)
      expect(input_neuron_one_edge_two.forward_output).to eq(0.66)
      expect(input_neuron_two_edge_one.forward_output).to eq(0)
      expect(input_neuron_two_edge_two.forward_output).to eq(0)

      expect(hidden_neuron_one.forward_input).to be_within(0.001).of(1.3200)
      expect(hidden_neuron_two.forward_input).to be_within(0.001).of(1.3200)

      expect(hidden_neuron_one.forward_output).to be_within(0.001).of(0.7892)
      expect(hidden_neuron_two.forward_output).to be_within(0.001).of(0.7892)

      expect(hidden_neuron_one_edge_one.forward_input).to be_within(0.001).of(0.7892)
      expect(hidden_neuron_two_edge_one.forward_input).to be_within(0.001).of(0.7892)

      expect(hidden_neuron_one_edge_one.forward_output).to be_within(0.0001).of(0.5208)
      expect(hidden_neuron_two_edge_one.forward_output).to be_within(0.0001).of(0.5208)

      expect(output_neuron.forward_input).to be_within(0.001).of(1.7017)
      expect(output_neuron.forward_output).to be_within(0.001).of(0.8458)
      expect(output_neuron.forward_error_output).to be_within(0.001).of(0.2085)

    end

    it 'backwards data correctly' do

      expect(output_neuron.backward_error_output).to be_within(0.001).of(0.6458)
      expect(output_neuron.backward_input).to be_within(0.001).of(0.6458)
      expect(output_neuron.backward_output).to be_within(0.001).of(0.0842)

      expect(output_bias_edge_one.backward_input).to be_within(0.001).of(0.0842)
      expect(output_bias_edge_one.derivative).to be_within(0.001).of(0.0842)

      expect(hidden_neuron_one_edge_one.backward_input).to be_within(0.001).of(0.0842)
      expect(hidden_neuron_two_edge_one.backward_input).to be_within(0.001).of(0.0842)

      expect(hidden_neuron_one_edge_one.backward_output).to be_within(0.001).of(0.0556)
      expect(hidden_neuron_two_edge_one.backward_output).to be_within(0.001).of(0.0556)

      expect(hidden_neuron_one_edge_one.derivative).to be_within(0.001).of(0.0664)
      expect(hidden_neuron_two_edge_one.derivative).to be_within(0.001).of(0.0664)

      expect(hidden_neuron_one.backward_input).to be_within(0.0001).of(0.0556)
      expect(hidden_neuron_two.backward_input).to be_within(0.0001).of(0.0556)

      expect(hidden_neuron_one.backward_output).to be_within(0.001).of(0.0092)
      expect(hidden_neuron_two.backward_output).to be_within(0.001).of(0.0092)

      expect(hidden_bias_edge_one.backward_input).to be_within(0.001).of(0.0092)
      expect(hidden_bias_edge_one.derivative).to be_within(0.001).of(0.0092)
      expect(hidden_bias_edge_two.backward_input).to be_within(0.001).of(0.0092)
      expect(hidden_bias_edge_two.derivative).to be_within(0.001).of(0.0092)

      expect(input_neuron_one_edge_one.backward_input).to be_within(0.001).of(0.0092)
      expect(input_neuron_one_edge_two.backward_input).to be_within(0.001).of(0.0092)
      expect(input_neuron_two_edge_one.backward_input).to be_within(0.001).of(0.0092)
      expect(input_neuron_two_edge_two.backward_input).to be_within(0.001).of(0.0092)

      expect(input_neuron_one_edge_one.backward_output).to be_within(0.001).of(0.0061)
      expect(input_neuron_one_edge_two.backward_output).to be_within(0.0001).of(0.0061)
      expect(input_neuron_two_edge_one.backward_output).to be_within(0.0001).of(0.0061)
      expect(input_neuron_two_edge_two.backward_output).to be_within(0.0001).of(0.0061)

      expect(input_neuron_one_edge_one.derivative).to be_within(0.001).of(0.0093)
      expect(input_neuron_one_edge_two.derivative).to be_within(0.001).of(0.0093)
      expect(input_neuron_two_edge_one.derivative).to be_within(0.01).of(0.0)
      expect(input_neuron_two_edge_two.derivative).to be_within(0.01).of(0.0)

    end

  end

end

describe :xor do

  subject { Noggin::Network.new training_laps: 20000}

  before do
    print subject.train([
      { input: [0, 0], expected: 0 },
      { input: [0, 1], expected: 1 },
      { input: [1, 0], expected: 1 },
      { input: [1, 1], expected: 0 }
    ])
  end

  it 'learns' do
    expect(subject.run([0,1])).to be_within(0.05).of(1.0)
    expect(subject.run([1,1])).to be_within(0.05).of(0.0)
    expect(subject.run([0,0])).to be_within(0.05).of(0.0)
    expect(subject.run([1,0])).to be_within(0.05).of(1.0)
  end

end