  f = 'C:\Computational Photography\Images_CP';
  d = ls(f);
  d(1,:)=[];
  d(1,:)=[];

 mkdir('C:\Computational Photography\result')
 for i=1:size(d)
  im = imread(fullfile(f,d(i,:)));
  [n,m]=size(im);  
  id=fix(n/3);
  Bl=im(1:id,:);
  Gr=im(id+1:2*id,:);
  Re=im(2*id+1:n,:);
  [rows, columns] = size(Gr);
    B = imresize(Bl,[rows, columns]);
    G = imresize(Gr,[rows, columns]);
    R = imresize(Re,[rows, columns]);
%     B = imresize(Bl,[3741, 3238]);
%     G = imresize(Gr,[3741, 3238]);
%     R = imresize(Re,[3741,3238]);
%imshow(out);
    [optimizer, metric] = imregconfig("multimodal");
      
      blueGreenBandRegistered = imregister(B, G, 'Similarity', optimizer, metric);
      
      redGreenBandRegistered = imregister(R, G, 'Similarity', optimizer, metric);
      
      finalCombinedImage = cat(3, redGreenBandRegistered, G, blueGreenBandRegistered);
      imwrite(finalCombinedImage,fullfile('C:\Images_CP\result',strcat(num2str(i),'.jpg')));
 end
