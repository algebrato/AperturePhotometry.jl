using AperturePhotometry
using Plots

I_channel = load_images("/home/algebrato/Immagini_Asteroidi/Binary_Star/20100102/I_channel/")

ref = I_channel[1]
sum_img = zeros(size(ref)[1], size(ref)[2])
k = 1
for i in I_channel[2:end]
        obj_aligned = align_images(ref, i, size(ref))
        global sum_img = sum_img .+ obj_aligned
        global k = k + 1
end

gradient = ColorGradient([:black, :white])
heatmap(sum_img ./ k , c=gradient, clims=(1200,1900))
