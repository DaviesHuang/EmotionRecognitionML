function [ ] = showImage( set_no, image_no )

load('data4students.mat');

im = datasetInputs{set_no};
im1 = im(image_no,:);
im2 = reshape(im1,30,30);
colormap gray
imagesc(im2')


end

