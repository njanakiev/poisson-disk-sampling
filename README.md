# poisson-disk-sampling
This is an implementation of the algorithm from the paper [Fast Poisson Disk Sampling in Arbitrary Dimensions](https://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf) realized with [Processing](https://processing.org/). [Poisson Disk Sampling](https://en.wikipedia.org/wiki/Supersampling#Poisson_disc) is the generation of a random distribution of points where no two points are too close, meaning that the points are at least a fixed distance apart. This form of distribution is also called [Blue Noise](https://en.wikipedia.org/wiki/Colors_of_noise#Blue_noise) which is useful in computer graphics, particularly for rendering or triangulations.

The animation of the 3D implementation shows the active points during the algorithm

![Poisson Disk Sampling Animation 3D](PoissonDiskSampling/animation_3D.gif)

The animation of the 2D implementation shows both the active points and the final points during the algorithm

![Poisson Disk Sampling Animation 2D](PoissonDiskSampling/animation_2D.gif)

