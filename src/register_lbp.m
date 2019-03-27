[filename, pathname] = uigetfile('*.*', 'Select eye image file for registration');
read_loc=strcat(pathname,filename);
eye_img = imread(read_loc);
%eye_img = rgb2gray(eye_img);

[x_iris,y_iris,r_iris,r_pupil] = localise_lbp(eye_img);

[ring,parr] = normaliseiris_lbp(eye_img,x_iris,y_iris,r_iris,r_pupil,100,300);
%imshow(ring);
%imshow(parr);


parr=adapthisteq(parr);
imshow(parr);
[temp th tv]=gen_templateVVV(parr);
imshow(temp);
save_loc=strcat('saved_templates/',filename);
imwrite(temp,save_loc);

