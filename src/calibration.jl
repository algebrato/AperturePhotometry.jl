import AperturePhotometry
# Prova
export dark_calibration, flat_calibration

@doc raw"""
    dark_calibration(channel::Array, path::String)

Remove the dark-current frame.
"""
function dark_calibration(channel::Array, path::String)

    dark_arr, time = load_images(path)
    dark = stack_images(dark_arr)
    dark = UInt16.(round.(dark))

    for i in 1:length(channel)
        channel[i] = UInt16.(round.(channel[i] .- dark))
    end

    return channel

end

@doc raw"""
    flat_calibration(channel::Array, path_df::String, path_flat::String)

Remove the flat's anisotrpies using a flat-referance.
"""
function flat_calibration(channel::Array, path_df::String, path_flat::String)

    flat_arr , _ = load_images(path_flat)

    dark_calibration(flat_arr, path_df)
    flat = stack_images(flat_arr)
    flat = 1 ./ flat
    flat = flat ./ maximum(flat)

    for i in 1:length(channel)
        channel[i] = UInt16.(round.(channel[i] .* flat))
    end

    return channel

end
