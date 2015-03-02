# Noggin
Ruby Neural Network implementation using backpropagation and gradient descent for training


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
    log: true # print out network state for each input during last iteration.
)
```

## Print Network

``` Ruby
network.pretty_print
```
```
 ------                                           ------                                          --------------      
|      | -EDGE--(w: 0.438443, d: 0.01759)        |      | -EDGE--(w: 0.515923, d: 0.09704)       | ed: 0.668486       
|      | -EDGE--(w: 0.746539, d: 0.013825)        ------                                         | d: 0.148145        
 ------                                           ------                                         | e: 0.223437        
 ------                                          |      | -EDGE--(w: 0.485781, d: 0.11099)       | o: 0.668486        
|      | -EDGE--(w: 0.199745, d: 0.01759)         ------                                          --------------      
|      | -EDGE--(w: 0.345684, d: 0.013825)       
 ------                                          
   
```
