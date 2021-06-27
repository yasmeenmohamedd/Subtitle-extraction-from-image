I = imread('Subtitle1.png');
igray=rgb2gray(I);
[~,threshold] = edge(igray,'sobel');
Factor = 0.5;
BWs = edge(igray,'sobel',threshold * Factor);
figure,imshow(BWs);
ss = strel('rectangle',[5 10]);
BW2 = imdilate(BWs,ss);
figure,imshow(BW2);
BWdfill = imfill(BW2,'holes');
figure,imshow(BWdfill);
[objects,num]=bwlabel(BWdfill);
subtitlelabel=10;
[H, W, ~]=size(I);
for h=1:H
    for w=1:W
        if(objects(h, w)~=subtitlelabel)
            BWdfill(h, w)=0;
        end
    end
end
figure,imshow(BWdfill);
for h=1:H
    for w=1:W
        if(BWdfill(h, w)==0)
            I(h, w, :)=0;
        end
    end
end
figure,imshow(I);
allobjects = regionprops(objects,'BoundingBox');
for i =1:num
   obj=allobjects(10);
   object_X = obj.BoundingBox(1);
   object_Y = obj.BoundingBox(2);
   object_W = obj.BoundingBox(3);
   object_H = obj.BoundingBox(4);
   cropped_image=imcrop(I,[object_X,object_Y,object_W-1,object_H-1]);
   figure,imshow(cropped_image);
   break;
end