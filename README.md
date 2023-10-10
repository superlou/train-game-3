# Collision Layers

1 - Not jumpable on the train
2 - Jumpable on the train
3 - Train car one-way edge (can jump out but not in)
4 - Player
5 - Items

# Z-Index

-1 - Objects on the ground
 0 - Train car floors
 1 - Players and objects on the train

# Todo

[ ] Have a robust way to know if the player is on a train car or not.
	This should maybe move the player into the scene of the car that they are in. That would let the train turn while keeping the camera straight for the player in the current car.
	Just use directional collisions shapes?
