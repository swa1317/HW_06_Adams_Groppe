function HW06_part4_portrait()
    K = 80;
    
    wt = 1/2;
    
    im_org      = imread('Portraits/Samuel_Portrait.jpg');
    
    im          = imresize( im_org, 0.10 );
    
    dims        = size( im );
    fltr        = fspecial( 'gauss', [15 15], 1.5 );
    im          = imfilter( im, fltr, 'same', 'repl' );
    
    [xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) );
    
    reds        = im(:,:,1);
    grns        = im(:,:,2);
    blus        = im(:,:,3);
    
    attributes  = [ xs(:)*wt, ys(:)*wt, double(reds(:)), double(grns(:)), double(blus(:)) ];

    tic;
    cluster_id  = kmeans( attributes, K, 'Dist', 'sqeuclidean', 'Replicate', 3, 'MaxIter', 250 );
    toc

    im_new      = uint8(reshape( cluster_id, dims(1), dims(2) ));
        
    im_edge = edge(im_new, 'canny');
    
    for x = 1:dims(1)  %loop through edge image and set cartoon pixel to black if an edge
        for y = 1:dims(2)
            if (im_edge(x, y) == 1)
                im_new(x, y) = 0;
            end
        end
    end

    figure;
    close;
    imagesc( im_new );
    colormap( jet );
    title( sprintf('k = %d,  distance wt = %8.5f ', K, wt), 'FontSize', 24 );
    colorbar
    drawnow;

end