allFiles = dir('eye_data/right');
left_file_list = { allFiles.name };
n = size(left_file_list);
accuracy = 0;
for i=67:n(2)
    %disp('next');
    read = left_file_list(1,i);
    read = strcat('eye_data/right/',read);
    %[filename, pathname] = uigetfile('*.*', 'Select left eye image file');
    %read_loc=strcat(pathname,filename);
    eye_img = imread(strjoin(read));
    eye_img = imresize(eye_img,.95);
    [x_iris,y_iris,r_iris,r_pupil] = localise_lbp(eye_img);

    [ring,parr] = normaliseiris_lbp(eye_img,x_iris,y_iris,r_iris,r_pupil,100,300);

    parr=adapthisteq(parr);
    [temp1 th tv]=gen_templateVVV(parr);
    imwrite(temp1,'abc.jpg');
    temp1 =  imread('abc.jpg');
    allFiles = dir('saved_templates/right_eye');
    left_file_list = { allFiles.name };
    n1 = size(left_file_list);
    hd_min=999999;
    ans1=0;
    for k=3:n1(2)
       read = left_file_list(k);
       read = strcat('saved_templates/right_eye/',read);
       temp_comp =  imread(strjoin(read));
       hd = hammingdist(temp1,temp_comp);
       if hd<hd_min
           hd_min = hd;
           ans1=k;
       end
    end   
    %disp(hd_min);
    %disp(i);
    disp(ans1-2);
    if ans1==i
        accuracy=accuracy+1;
        read = left_file_list(ans1);
        read = strcat('saved_templates/right_eye/',read);
        temp_comp =  imread(strjoin(read));
        read = strcat('correct/right/',left_file_list(ans1));
        imwrite(temp_comp,strjoin(read));
    end
    %disp(accuracy)
end    
        
