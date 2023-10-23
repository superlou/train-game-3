# Collision Layers

1 - Not jumpable on the train
2 - Jumpable on the train
3 - Train car one-way edge (can jump out but not in)
4 - Player
5 - Items
6 - Train car bed

# Z-Index

-1 - Objects on the ground
 0 - Train car floors
 1 - Players and objects on the train

# Todo

[ ] Move the Train nodes to the Main scene.
	This is to make it easier to move the player to other regions like a Station, not just the train cars and the Ground node.
[x] Have a way to know if the player is on a train car or not.
	This should maybe move the player into the scene of the car that they are in. That would let the train turn while keeping the camera straight for the player in the current car.
	Just use directional collisions shapes?