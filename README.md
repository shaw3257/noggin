# Noggin
A Neural Network written in Ruby with an objected oriented implementation. Training is done using http://en.wikipedia.org/wiki/Backpropagation and http://en.wikipedia.org/wiki/Gradient_descent.

The simple API was inspired from https://github.com/harthur/brain


``` Ruby
network = Noggin::Network.new

network.train([
  { input: [0, 0], expected: 0 },
  { input: [0, 1], expected: 1 },
  { input: [1, 0], expected: 1 },
  { input: [1, 1], expected: 0 }
])

network.run [0, 0]  # 0.0163
network.run [0, 1]  # 0.9873
network.run [1, 0]  # 0.9702
network.run [1, 1]  # 0.0142

```

## Installation
``` gem install the_noggin ```

## Options
``` Ruby
Noggin::Network.new( 
    training_laps: 100000, # How many propgation of errors to do when training
    learning_rate: 0.1, # How fast the network learns
    momentum: 0.2, # How much of previous weight deltas should be applied to next delta  
    hidden_layer_size: 1 , # Number of hidden layers
    hidden_layer_node_size: 2, # Number of nodes each hidden layer has
)
```
