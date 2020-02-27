export aperture_photometry

function aperture_photometry(channel::Array,
                             obj::Tuple,
                             ref1::Tuple,
                             ref2::Tuple,
                             radius::Tuple
                            )

    f_obj  = Array{Float64, 1}(undef, 0)
    f_ref1 = Array{Float64, 1}(undef, 0)
    f_ref2 = Array{Float64, 1}(undef, 0)

    for i in 1:length(channel)

        flux_o_in = Float64(sum(channel[i][obj[1]-radius[1]:obj[1]+radius[1], obj[2]-radius[1]:obj[2]+radius[1]]))
        flux_o_out = Float64(sum(channel[i][obj[1]-radius[2]:obj[1]+radius[2], obj[2]-radius[2]:obj[2]+radius[2]]))

        bg_o = (flux_o_out - flux_o_in) / (radius[2]^2) # bg / pix
        flux_o = flux_o_in - (bg_o * (radius[1]^2))

        flux_r1_in = Float64(sum(channel[i][ref1[1]-radius[1]:ref1[1]+radius[1], ref1[2]-radius[1]:ref1[2]+radius[1]]))
        flux_r1_out = Float64(sum(channel[i][ref1[1]-radius[2]:ref1[1]+radius[2], ref1[2]-radius[2]:ref1[2]+radius[2]]))

        bg_r1 = (flux_r1_out - flux_r1_in) / (radius[2]^2)
        flux_r1 = flux_r1_in - (bg_r1 * (radius[1]^2))


        flux_r2_in = Float64(sum(channel[i][ref2[1]-radius[1]:ref2[1]+radius[1], ref2[2]-radius[1]:ref2[2]+radius[1]]))
        flux_r2_out = Float64(sum(channel[i][ref2[1]-radius[2]:ref2[1]+radius[2], ref2[2]-radius[2]:ref2[2]+radius[2]]))

        bg_r2 = (flux_r2_out - flux_r2_in) / (radius[2]^2)
        flux_r2 = flux_r2_in - (bg_r2 * (radius[1]^2))

        f_obj  = append!(f_obj, flux_o)
        f_ref1 = append!(f_ref1, flux_r1)
        f_ref2 = append!(f_ref2, flux_r2)
    end

    return f_obj, f_ref1, f_ref2

end
