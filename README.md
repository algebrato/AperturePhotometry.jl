# AperturePhotometry

**`Documentation`** |
------------------- |
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://algebrato.github.io/AperturePhotometry.jl/stable)|

This Julia module wants to meet the needs of amatorial astronomerw that are involved in the photometry of objects like variable stars, asteroids, surface-photometry of galaxies, and so on.

On the web, there is a lot of software that perform images calibration and relatively differential photometry, but more often than not, they are:

- Close-source software
- They work only on windows
- You have to use the software "as is" and you cannot hack any part of it.

With a `Julia` module, all the users are invited to hack it! Add your fun feature with a PR! 

Now, the module is elementary, and it can calibrate an image series with dark-frame and flat-field. It can also stack the images to do imaging, or they can be aligned in order to perform differential photometry of an object given two fixed reference stars.

The module was thought to be used for different colors channel. If you have a CCD with a wheel-filter,  you can get two (or more) differential light curves in different colors. In this way, you can load all the channels, calibrate them separately and perform the color B-V or B-I or V-R light curve.

All of this can be done with a few lines of Julia.

Now, I'm working on porting the code also on other platforms like Windows and macOS. Well, meanwhile, if you have Linux, you can start to enjoy your fun!

# Built status
Now, `AperturePhotomery` is available for Linux and `Julia => 1.0`. The built status is presented here below

**`Platform`**| **`Built Status`**| **`Coverage`**|
------------------- |------------------- |------------------- |
**Linux Debian-Like**| [![Build Status](https://travis-ci.com/algebrato/AperturePhotometry.jl.svg?token=vxqEG2bCpZk4Jk4XmmFJ&branch=master)](https://travis-ci.com/algebrato/AperturePhotometry.jl)| [![Codecov](https://codecov.io/gh/algebrato/AperturePhotometry.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/algebrato/AperturePhotometry.jl)|
