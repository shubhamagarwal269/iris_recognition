function [x_iris,y_iris,r_iris,r_pupil] = localise_lbp(eye_img_m)

eye_img1=eye_img_m;
imwrite(eye_img1,'gray_image.jpg')
cmp1=imcomplement(eye_img1);
fill1= imfill(cmp1);
cmp2=imcomplement(fill1);
imwrite(cmp2,'light_removed.jpg')
eye_img1=cmp2;
ig=imgaussfilt(eye_img1,4);
imwrite(eye_img1,'gaussian.jpg')
bw = edge(ig,'Canny');
imwrite(bw,'canny.jpg')
%imshow(eye_img1);
[centers, radii] = imfindcircles(bw,[30 70],'ObjectPolarity','bright','Sensitivity',0.9);
[rows,cols]=size(eye_img1);
dist=sqrt((centers(1,1)-(cols/2))^2+(centers(1,2)-(rows/2))^2);
index=1;
i=0;
for i = 1:size(centers)
    d=sqrt((centers(i,1)-(cols/2))^2+(centers(i,2)-(rows/2))^2);
    if(d<dist)
        dist=d;
        index=i;
    end
end
I = eye_img_m;
imageSize = size(I);
ci = [centers(index,2),centers(index,1),radii(index)*1.7];     % center and radius of circle ([c_row, c_col, r])
ci2 = [centers(index,2),centers(index,1),radii(index)];
[xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
mask = uint8((xx.^2 + yy.^2)<ci(3)^2);
croppedImage = uint8(zeros(size(I)));
croppedImage(:,:,1) = I(:,:,1).*mask;
[xx1,yy1] = ndgrid((1:imageSize(1))-ci2(1),(1:imageSize(2))-ci2(2));
mask2 = uint8((xx1.^2 + yy1.^2)<ci2(3)^2);
croppedImage1 = uint8(zeros(size(I)));
croppedImage1(:,:,1) = I(:,:,1).*mask2;
%imshow(croppedImage-croppedImage1);
save_loc=strcat('i.jpg');
imwrite(croppedImage-croppedImage1,save_loc)
iris_image = croppedImage-croppedImage1;
r_pupil = radii(index);
x_iris = centers(index,2);
y_iris = centers(index,1);
r_iris = radii(index)*1.7;
