function HW06_part3a_DistanceWts()

    K = 64;
    
    dst_wts = [ 1/40 1/20 1/10 1/5 1/2 1 ];
    
    im_orig     = imread('Corel_Image_198023.jpg');
    
    im          = imresize( im_orig, 0.5 );
    
    dims        = size( im );
    fltr        = fspecial( 'gauss', [15 15], 1.5 );
    im          = imfilter( im, fltr, 'same', 'repl' );
    
    [xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) );
    
    reds        = im(:,:,1);
    grns        = im(:,:,2);
    blus        = im(:,:,3);

    for wt = dst_wts
        
        attributes  = [ xs(:)*wt, ys(:)*wt, double(reds(:)), double(grns(:)), double(blus(:)) ];

        tic;
        cluster_id  = kmeans( attributes, K, 'Dist', 'Cityblock', 'Replicate', 3, 'MaxIter', 250 );
        toc

        im_new      = reshape( cluster_id, dims(1), dims(2) );

        figure;
        imagesc( im_new );
        colormap( jet );
        title( sprintf('k = %d,  distance wt = %8.5f ', K, wt), 'FontSize', 24 );
        colorbar
        drawnow;
    end
end