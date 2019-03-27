[filename, pathname] = uigetfile('*.*', 'Select eye image file for identification');
read_loc=strcat(pathname,filename);
eye_img = imread(read_loc);
%eye_img = imresize(eye_img,.7);

[x_iris,y_iris,r_iris,r_pupil] = localise_lbp(eye_img);

[ring,parr] = normaliseiris_lbp(eye_img,x_iris,y_iris,r_iris,r_pupil,100,300);

parr=adapthisteq(parr);
[temp1 th tv]=gen_templateVVV(parr);
imwrite(temp1,'abc.jpg');
temp1 =  imread('abc.jpg');

allFiles = dir('saved_templates');
left_file_list = { allFiles.name };
n = size(left_file_list);
hd_left = zeros(1,n(2));
for i=3:n(2)
   read = left_file_list(i);
   read = strcat('saved_templates/',read);
   temp_comp =  imread(strjoin(read));
   hd_left(i) = hammingdist(temp1,temp_comp);
end    


for i = 3:n(2)
    if(hd_left(i)<.2)
        disp('eye belong to person');
        disp(i-2);
    end
end    
