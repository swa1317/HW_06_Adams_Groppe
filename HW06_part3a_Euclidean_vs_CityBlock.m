function HW06_part3a_Euclidean_vs_CityBlock()
    %the weights we are trying out
    dst_wts = [ 1/40 1/20 1/10 1/5 1/2 1 ];
    
    im_rotated     = imread('HW_06_MacBeth_Rotated.jpg');
    im_regular     = imread('HW_06_MacBeth_Regular.jpg');
    
    im          = imresize( im_rotated, 0.25 );
    %setting up the gaussian image filter
    dims        = size( im );
    fltr        = fspecial( 'gauss', [15 15], 1.5 );
    im          = imfilter( im, fltr, 'same', 'repl' );
    [xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) );
    %separating out the color channels
    reds        = im(:,:,1);
    grns        = im(:,:,2);
    blus        = im(:,:,3);
    %for each weight, we try out a bunch of different K values and test out
    %2 distance metrics
    for wt = dst_wts
        for K = 40:60
            %defining the individual attributes (row, column, red, green,
            %blue)
            attributes  = [ xs(:)*wt, ys(:)*wt, double(reds(:)), double(grns(:)), double(blus(:)) ];
            %identifying clustering using 2 different distance metrics
            tic;
            cluster_id_CB  = kmeans( attributes, K, 'Dist', 'Cityblock', 'Replicate', 3, 'MaxIter', 250 );
            cluster_id_SE  = kmeans( attributes, K, 'Dist', 'sqeuclidean', 'Replicate', 3, 'MaxIter', 250 );
            toc
            %reshaping the images based on the distance metric and the
            %kmeans results
            im_cityblock      = reshape( cluster_id_CB, dims(1), dims(2) );
            im_euclidean      = reshape( cluster_id_SE, dims(1), dims(2) );
            %setting up and showing the images in a figure
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