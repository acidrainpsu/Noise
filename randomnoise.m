function  out=randomnoise(f,ND)
%add random value impulse noise for colour image
%f is input colour image
%ND is Noise density

    f=double(f);
    [row, col, ~] = size(f);
    [r, g, b]=rgb(f);
    out_r=r;
    out_g=g;
    out_b=b;
    
    Narr = rand(size(out_r)); %initial probability 

    N = Narr; %prob
    N(N>=ND)=0; %noise free 
    N1 = N;
    N1 = N1(N1>0); %index of noise
    Imn=min(N1(:));
    Imx=max(N1(:));
    N=(((N-Imn).*(255-0))./(Imx-Imn)); %noise value 
    
    
    probR = 0.3*ND;
    probG = probR+0.3*ND;
    probB = probG+ 0.3*ND;  
    proball = probB + 0.1*ND;
    
    NR = Narr > 0 & Narr <= probR;
    NG = Narr > probR & Narr <= probG;
    NB = Narr > probG & Narr <= probB;
    NRGB = Narr > probB & Narr <= proball;
    
    out_r(NR) = N(NR);
    out_g(NG) = N(NG);
    out_g(NB) = N(NB);
    
    out_r(NRGB) = N(NRGB);
    out_g(NRGB) = N(NRGB);
    out_b(NRGB) = N(NRGB);
     
    out=cat(3,out_r,out_g,out_b);
    out=uint8(out);
end
