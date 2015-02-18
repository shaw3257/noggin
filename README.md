# noggin
Ruby Neural Network implementation using backpropagation and gradient descent for training


``` Ruby
network = Noggin::Network.new

network.train([
  { input: [0, 0], output: 0 },
  { input: [0, 1], output: 1 },
  { input: [1, 0], output: 1 },
  { input: [1, 1], output: 0 }
])

network.run [0, 0]  # .9745
network.run [0, 1]
network.run [1, 0]
network.run [1, 1]

```
