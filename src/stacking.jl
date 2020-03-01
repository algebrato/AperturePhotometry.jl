using FFTW
export stack_images, align_images, align_channel!, align_images_crop
export align_channel_crop!

@doc raw"""
    align_images(ref::Array, obj::Array, size::Tuple)

This function align two images, using the cross-correlation methods. It works for x-y translations but it fails if the images suffer of field-rotation.
"""
function align_images(ref::Array, obj::Array, size::Tuple)
    ref_fft = fftshift(fft(ref))
    obj_fft = fftshift(fft(obj))
    cx_ft = ref_fft .* conj.(obj_fft)
    cx = abs.(fftshift(ifft(cx_ft)))

    cx_c = Tuple.(indexin(maximum(cx), cx))
    im_c = Int.(round.(size./2))

    shift = im_c .- cx_c

    obj_shifted = zeros(size[1], size[2])

    if (shift[1] > 0) & (shift[2] > 0)

        dx = shift[1]
        dy = shift[2]

        obj_shifted[1:end-dx, 1:end-dy] .= obj[dx+1:end, dy+1:end]
        obj_shifted[end-dx:end, end-dy:end] .= 0.0

    end

    if (shift[1] < 0) & (shift[2] < 0)

        dx = abs(shift[1])
        dy = abs(shift[2])

        obj_shifted[dx+1:end, dy+1:end] = obj[1:end-dx, 1:end-dy]
        obj_shifted[1:dx, 1:dy] .= 0.0

    end

    if (shift[1] > 0) & (shift[2] < 0)

        dx = abs(shift[1])
        dy = abs(shift[2])

        obj_shifted[1:end-dx, dy+1:end] = obj[dx+1:end, 1:end-dy]
        obj_shifted[end-dx:end, 1:dy] .= 0.0
    end

    if (shift[1] < 0) & (shift[2] > 0)

        dx = abs(shift[1])
        dy = abs(shift[2])

        obj_shifted[dx+1:end, 1:end-dy] = obj[1:end-dx, dy+1:end]
        obj_shifted[1:dx, end-dy:end] .= 0.0
    end

    return obj_shifted
end

function align_channel!(channel::Array{Array{UInt16,2},1})

    ref = channel[1]

    for i in 2:length(channel)
            obj_aligned = align_images(ref, channel[i], size(ref))
            channel[i] = obj_aligned
    end

end

function align_channel_crop!(channel::Array{Array{UInt16,2},1}, x::Tuple, y::Tuple)

    ref = channel[1]
    for i in 2:length(channel)
        obj_aligned = align_images_crop(ref, channel[i], size(ref), x, y)
        channel[i] = obj_aligned
    end
end

function align_images_crop(ref::Array, obj::Array, size::Tuple, x::Tuple, y::Tuple)
    partial_r = ref[y[1]:y[2], x[1]:x[2]]
    partial_o = obj[y[1]:y[2], x[1]:x[2]]

    ref_fft = fftshift(fft(partial_r))
    obj_fft = fftshift(fft(partial_o))
    cx_ft = ref_fft .* conj.(obj_fft)
    cx = abs.(fftshift(ifft(cx_ft)))

    cx_c = Tuple.(indexin(maximum(cx), cx))
    partial_size = (y[2]-y[1], x[2]-x[1])
    im_c = Int.(round.(partial_size./2))

    shift = im_c .- cx_c

    obj_shifted = zeros(size[1], size[2])

    if (shift[1] > 0) & (shift[2] > 0)
        println("shift-1 ... ")
        dx = shift[1]
        dy = shift[2]

        obj_shifted[1:end-dx, 1:end-dy] .= obj[dx+1:end, dy+1:end]
        obj_shifted[end-dx:end, end-dy:end] .= 0.0

    end

    if (shift[1] < 0) & (shift[2] < 0)
        println("shift-2 ... ")
        dx = abs(shift[1])
        dy = abs(shift[2])

        obj_shifted[dx+1:end, dy+1:end] = obj[1:end-dx, 1:end-dy]
        obj_shifted[1:dx, 1:dy] .= 0.0

    end

    if (shift[1] > 0) & (shift[2] < 0)
        println("shift-3 ... ")
        dx = abs(shift[1])
        dy = abs(shift[2])

        obj_shifted[1:end-dx, dy+1:end] = obj[dx+1:end, 1:end-dy]
        obj_shifted[end-dx:end, 1:dy] .= 0.0
    end

    if (shift[1] < 0) & (shift[2] > 0)
        println("shift-2 ... ")
        dx = abs(shift[1])
        dy = abs(shift[2])

        obj_shifted[dx+1:end, 1:end-dy] = obj[1:end-dx, dy+1:end]
        obj_shifted[1:dx, end-dy:end] .= 0.0
    end

    return obj_shifted

end

@doc raw"""
    stack_images(img_aligned::Array)

Image staking
"""
function stack_images(img_aligned::Array)
    k = 0
    sum_img = zeros(size(img_aligned[1])[1], size(img_aligned[1])[2])
    for i in img_aligned[1:end]
        sum_img = sum_img .+ i
        k = k + 1
    end

    return sum_img ./ k

end
