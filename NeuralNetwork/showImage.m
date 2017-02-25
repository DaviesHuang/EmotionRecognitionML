function [ ] = showImage( set_no, image_no, data )

%load('data4students.mat');

%im = datasetInputs{set_no};
im1 = data(image_no,:);
im2 = reshape(im1,30,30);
colormap gray
imagesc(im2')


end

