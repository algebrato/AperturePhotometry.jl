using AperturePhotometry
using Plots
using Images

channel_path = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/I_channel/"
path_dark = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/dark/"
path_flat_I = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/flat_I/"
path_df_I = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/dark_flat_I/"

channel_path = "/home/algebrato/Immagini_Asteroidi/Binary_Star/20130906/"


x = (1, 200)
y = (200, 400)
# Load Images
I_channel, times = load_images(channel_path)

# Dark Calibration
# dark_calibration(I_channel, path_dark)

# Flat Calibration
# flat_calibration(I_channel, path_df_I, path_flat_I)

# Align the images

ref = I_channel[1]

for i in 2:length(I_channel)
    obj_aligned = align_images_crop(ref, I_channel[i], size(ref), x, y)
    I_channel[i] = obj_aligned
end


gradient = ColorGradient([:black, :white])
heatmap(stack_images(I_channel[1:210]) , c=gradient, clims=(5500,6900))

ref = I_channel[1]
ref[ref .< 1200 ] .= 0

maxes = findlocalmaxima(ref[200:600,70:200])

nmax = length(maxes)

arr = Array{Float64, 1}(undef, 0)
for img in I_channel
        for p in maxes
                max = Tuple(p)
                x = max[1]
                y = max[2]
                xmin = x-10
                xmax = x+10
                ymin = y-10
                ymax = y+10

                if xmax > 765
                        xmax = 765
                end
                if ymax > 510
                        ymax = 510
                end
                if xmin <= 0
                        xmin = 1
                end
                if ymin <= 0
                        ymin =1
                end
                flux = sum(img[xmin:xmax, ymin:ymax])/400.0
                global arr = append!(arr, flux)
        end
end

arr_resh = reshape(arr, nmax, 131)

using Statistics
rms = Array{Float64, 1}(undef, 0)
avg = Array{Float64, 1}(undef, 0)

m_ref = 25 .- 2.5*log10.(arr_resh[5,:] )
m_ref[m_ref .== Inf] .= 0
for i in 1:nmax
        global m_ref
        global avg
        m_obj = 25 .- 2.5*log10.(arr_resh[i,:] )
        m_obj[m_obj .== Inf] .= 0
        av = mean(m_obj)
        st = std(m_obj .- m_ref)
        global rms = append!(rms, st)
        avg = append!(avg, av)
end

plot(avg, rms, seriestype=:scatter)

for i in 1:(nmax-1)
        plot(times, (25 .- 2.5*log10.(arr_resh[i,:])) .- (25 .- 2.5*log10.(arr_resh[i+1,:] )) , seriestype=:scatter, label="", ylims=(-0.1, 0.1))
        png(string(i)*".png")
end
