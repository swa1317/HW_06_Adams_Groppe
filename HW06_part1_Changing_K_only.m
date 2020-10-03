function HW06_part1_Changing_K_only(im_in)
    
    image_rgb = imread(im_in);
    
    for K = 5:5:255
        indexed_image = rgb2ind(image_rgb, K, 'nodither');
        imshow(indexed_image), title(['K = ', num2str(K)]);
        pause(1);
    end
end