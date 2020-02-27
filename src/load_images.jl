export load_images

using FITSIO

function load_images(path::String)

    file_list = readdir(path)
    img_stack = Array{Array{UInt16, 2}, 1}(undef, 0)
    times = Array{Float64, 1}(undef, 0)

    for i in file_list
        fit = FITS(path*i)
        img = read(fit[1])
        time = read_header(fit[1])["JD"]

        img_stack = append!(img_stack, [img])
        times = append!(times, time)
    end

    return img_stack, times

end
