allFiles = dir('eye_data/right');
left_file_list = { allFiles.name };
n = size(left_file_list);

for i=3:n(2)
    read = left_file_list(1,i);
    read = strcat('eye_data/right/',read);
    %[filename, pathname] = uigetfile('*.*', 'Select left eye image file');
    %read_loc=strcat(pathname,filename);
    eye_img = imread(strjoin(read));

    [x_iris,y_iris,r_iris,r_pupil] = localise_lbp(eye_img);

    [ring,parr] = normaliseiris_lbp(eye_img,x_iris,y_iris,r_iris,r_pupil,100,300);

    parr=adapthisteq(parr);
    %imshow(parr);
    [temp th tv]=gen_templateVVV(parr);
    %imshow(temp);
    save_loc=strcat('saved_templates/right_eye/',left_file_list(1,i));
    imwrite(temp,strjoin(save_loc));
end    
