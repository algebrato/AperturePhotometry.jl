using AperturePhotometry
using Plots
using Images

channel_path = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/B_channel/"
path_dark = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/dark/"
path_flat_I = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/flat_B/"
path_df_I = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/dark_flat_I/"

# Load Images
I_channel, times = load_images(channel_path)

# Dark Calibration
dark_calibration(I_channel, path_dark)

# Flat Calibration
flat_calibration(I_channel, path_df_I, path_flat_I)

# Align the images
align_channel!(I_channel)

# You may align the images using a crop section to increase the speed
# align_channel_crop!(I_channel, (1, 350), (200, 700))

# The variable star position
obj    = (276, 368)
# The positions of the reference stars
ref1   = (247, 168)
ref2   = (448, 108)

# inner and outer radius for the aperture photometry
radius = (11, 15)

flux_ob, flux_ref1, flux_ref2 = aperture_photometry(I_channel, obj, ref1, ref2, radius)

mag_ob = 25 .- 2.5 .* log10.(flux_ob)
mag_ref1 = 25 .- 2.5 .* log10.(flux_ref1)
mag_ref2 = 25 .- 2.5 .* log10.(flux_ref2)

plot(times, mag_ob .- mag_ref2, seriestype=:scatter, label="ob-r1", yflip=true)
plot!(times, (mag_ref2 .- mag_ref1) .+ 1.05, seriestype=:scatter, label="r2-r1", yflip=true)

plot_image(I_channel[100], (700,1200))
