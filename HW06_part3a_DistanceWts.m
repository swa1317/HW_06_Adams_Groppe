function HW06_part3a_DistanceWts()
%% IMAGE PREP %%
    K = 64; % number of clusters
    
    dst_wts = [ 1/40 1/20 1/10 1/5 1/2 1 ]; % different distance weights to try
    
    im_orig     = imread('Corel_Image_198023.jpg');
    % scaling and blurring the image
    im          = imresize( im_orig, 0.5 );
    dims        = size( im );
    fltr        = fspecial( 'gauss', [15 15], 1.5 );
    im          = imfilter( im, fltr, 'same', 'repl' );
    %% beginning cartoonization process
    [xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) );
    % separating the color channels
    reds        = im(:,:,1);
    grns        = im(:,:,2);
    blus        = im(:,:,3);

    for wt = dst_wts
%% Clustering and shaping the image
        attributes  = [ xs(:)*wt, ys(:)*wt, double(reds(:)), double(grns(:)), double(blus(:)) ];

        tic;
        cluster_id  = kmeans( attributes, K, 'Dist', 'Cityblock', 'Replicate', 3, 'MaxIter', 250 );
        toc

        im_new      = reshape( cluster_id, dims(1), dims(2) );
%% displaying the figure with the cartoon
        figure;
        imagesc( im_new );
        colormap( jet );
        title( sprintf('k = %d,  distance wt = %8.5f ', K, wt), 'FontSize', 24 );
        colorbar
        drawnow;
    end
end