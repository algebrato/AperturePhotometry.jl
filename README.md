# AperturePhotometry

**`Documentation`** |
------------------- |
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://algebrato.github.io/AperturePhotometry.jl/stable)|

This julia module wants to met the needs of a typical amatorial astronomer, that is involved in the differential photometry  of objects like variable stars, asteroids, photometri surface of galaxies and so on.

On the web there is a lot of software that perfom images calibration and relatively differential photmetry, but more often than not, they are:

- Close-source software
- They work only on windows
- You have to use the sotware "as is", and you cannot hack any part of it.

With a `Julia` module, all the users are really invited to hack it! Add your fun feature with a PR! 

Now, the module is very simple. He can calibrate with dark-frame and flat-field a images series and he can stack them to do imaging, or they can be aligned in order to perform differential photmetry of an object given two fixed reference stars.

The module was thought to be used for differend colors channel. If you have a CCD with a wheel-filter,  you can get two (or more) differential light curve in different colors. In this way you can load all the channel, calibrate them separately and perform the color B-V or B-I or V-R light curve.

All with few line of julia code.

Now, I'm working to port the code also on other platform like Windows and MacOS. Well, meanwhile, if you have Linux, you can start to enjoy your fun!

# Built status
Now, `AperturePhotomery` is available for Linux and `Julia => 1.0`. The build status is presented here below
**`Platform`**| **`Build Status`**| **`Coverage`**|
**Linux Debian-Like**| [![Build Status](https://travis-ci.com/algebrato/AperturePhotometry.jl.svg?token=vxqEG2bCpZk4Jk4XmmFJ&branch=master)](https://travis-ci.com/algebrato/AperturePhotometry.jl)| 
[![Codecov](https://codecov.io/gh/algebrato/AperturePhotometry.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/algebrato/AperturePhotometry.jl)|
