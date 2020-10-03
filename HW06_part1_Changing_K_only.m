function HW06_part1_Changing_K_only(im_in)

    for K = 5:5:255
        indexed_image = rgb2ind(im_in, K, 'nodither');
        imshow(indexed_image);
    end
end