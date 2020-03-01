export load_images, plot_image

using FITSIO
using AstroLib
using Plots

@doc raw"""
    load_images(path::String)

Load images from the `path` directory and its time-stamp. There are two different types
of time-stamp loading, the first one, if "JD" is header entry, so it is taken by that, else (for example, the well-known software CCDSoft, provided by SBIG company) it converts a date-obs into JD. If you are looking for light curve TOM, you have to apply the heliocentric correction.

The heliocentric correction of the date-obs has not been implemented yet.
"""
function load_images(path::String)

    file_list = readdir(path)
    img_stack = Array{Array{UInt16, 2}, 1}(undef, 0)
    times = Array{Float64, 1}(undef, 0)

    for i in file_list
        fit = FITS(path*i)
        img = read(fit[1])

        try
            time_obs = read_header(fit[1])["JD"]
            times = append!(times, time_obs)
        catch e
            jd = read_header(fit[1])["DATE-OBS"]
            time_obs = jdcnv(jd)
            times = append!(times, time_obs)
        end

        img_stack = append!(img_stack, [img])

    end

    return img_stack, times

end

@doc raw"""
    plot_image(img::Array{UInt16,2}, color_lims::Tuple)

A function to easily plot images. It is based on Plots.
"""
function plot_image(img::Array{UInt16,2}, color_lims::Tuple)
    gradient=ColorGradient([:black, :white])
    heatmap(transpose(img), c=gradient, clims=color_lims)
end
