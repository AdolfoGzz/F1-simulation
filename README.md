# F1-simulation
Simulates a car through a small track following the laws of physics.

Creates a cubic function from 4 points in the graph. 2 predetermined points, and 2 selected in order to meet a minimum curve longitude, and a maximum radius of curvature.

Marked yellow or danger zones are the cruves with a cruve radius of less than 50 in which the car might slide if the max velocity is exceeded.

A perpendicular line is formed from the beginning of each danger zone in order to graph the bleachers 20 units away from the track in parallel of the star of the danger zone.

Using the friccion coefficients of a static and the radius of the curvature, a maxiumum speed was determined for each curve, which varies from 11.6247 - 19.4301. If the car exceeds the maximum speed at the given point, it slides following the tangent line.

After the sliding occurs, the distance of the slide and joules of energy wasted are calculated.
