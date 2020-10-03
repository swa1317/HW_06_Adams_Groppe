function HW06_part3a_Euclidean_vs_CityBlock()
    
    dst_wts = [ 1/40 1/20 1/10 1/5 1/2 1 ];
    
    im_rotated     = imread('HW_06_MacBeth_Rotated.jpg');
    im_regular     = imread('HW_06_MacBeth_Regular.jpg');
    
    im          = imresize( im_rotated, 0.25 );
    
    dims        = size( im );
    fltr        = fspecial( 'gauss', [15 15], 1.5 );
    im          = imfilter( im, fltr, 'same', 'repl' );
    
    [xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) );
    
    reds        = im(:,:,1);
    grns        = im(:,:,2);
    blus        = im(:,:,3);

    for wt = dst_wts
        for K = 40:60
            attributes  = [ xs(:)*wt, ys(:)*wt, double(reds(:)), double(grns(:)), double(blus(:)) ];

            tic;
            cluster_id_CB  = kmeans( attributes, K, 'Dist', 'Cityblock', 'Replicate', 3, 'MaxIter', 250 );
            cluster_id_SE  = kmeans( attributes, K, 'Dist', 'sqeuclidean', 'Replicate', 3, 'MaxIter', 250 );
            toc

            im_cityblock      = reshape( cluster_id_CB, dims(1), dims(2) );
            im_euclidean      = reshape( cluster_id_SE, dims(1), dims(2) );

            figure;
            close;
            imagesc( [im_cityblock, im_euclidean] );
            colormap( jet );
            title( sprintf('(CityBlock)       k = %d,  distance wt = %8.5f       (Euclidean)', K, wt), 'FontSize', 14 );
            colorbar
            drawnow;
        end
    end

end