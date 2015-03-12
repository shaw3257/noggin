# Noggin
Ruby Neural Network implementation using backpropagation and gradient descent for training


``` Ruby
network = Noggin::Network.new

network.train([
  { input: [0, 0], output: 0 },
  { input: [0, 1], output: 1 },
  { input: [1, 0], output: 1 },
  { input: [1, 1], output: 0 }
])

network.run [0, 0]  # 0.0163
network.run [0, 1]  # 0.9573
network.run [1, 0]  # 0.9702
network.run [1, 1]  # 0.0142

```

## Installation
``` gem install the_noggin ```

## Options
``` Ruby
Noggin::Network.new( 
    max_training_laps: 100000, # How many propgation of errors to do when training
    learning_rate: 0.1, # How fast the network learns
    momentum: 0.2, # How much of previous weight deltas should be applied to next delta  
    hidden_layer_size: 1 , # Number of hidden layers
    hidden_layer_node_size: 2, # Number of nodes each hidden layer has
)
```
