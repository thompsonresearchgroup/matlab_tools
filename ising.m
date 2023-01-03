function ising()

%     2D Ising model
%% Initial Parameters 
NIter = 10000;
CCnt = 1.0;
Temp = 1.5;
Boltz = 1.0;
NDimX = 14;
NDimY = 14;
IExSp = 0;

%% Initial Lattice
ISpin = rand(NDimX,NDimY);
for I=1:NDimX; 
  for J=1:NDimY;
    if (ISpin(I,J)>0.5) 
      ISpin(I,J) = 1;
    else 
      ISpin(I,J) = -1;
    end
  end
end

IExSp = sum(sum(ISpin));

% equilibration
while (IExSp~=0)
  Irx = floor(rand(1)*NDimX) + 1;
  Jry = floor(rand(1)*NDimY) + 1;
  if(ISpin(Irx,Jry)==sign(IExSp))
      ISpin(Irx,Jry) = -ISpin(Irx,Jry);
  end
  IExSp = sum(sum(ISpin));
end

colormap(cool);
map = imagesc(ISpin)


%% Main Loop
for ICount=1:NIter;
  Irx = floor(rand(1)*NDimX) + 1;
  Jry = floor(rand(1)*NDimY) + 1;

  IP1 = Irx - 1;
  IP2 = Irx + 1;
  JP1 = Jry - 1;
  JP2 = Jry + 1;
    if(IP1==0)
      IP1 = NDimX;
    end
    if(JP1==0)
      JP1 = NDimY;
    end
    if(IP2>NDimX)
      IP2 = 1;
    end
    if(JP2>NDimY)
      JP2 = 1;
    end

  NSpins = ISpin(IP1,Jry)+ISpin(IP2,Jry)+ISpin(Irx,JP1)+ISpin(Irx,JP2);
  DelH = 2.0*CCnt*ISpin(Irx,Jry)*NSpins;
  
  if(DelH<0)
    ISpin(Irx,Jry) = -ISpin(Irx,Jry);
  else
    Prob = exp(-DelH/(Boltz*Temp));
    if(Prob>rand(1))
      ISpin(Irx,Jry) = -ISpin(Irx,Jry);  
    end
  end
  
  IExSp(ICount) = sum(sum(ISpin));
  pause(0.1)
  imagesc(ISpin)
  
end

figure(2);
plot(IExSp)

end

