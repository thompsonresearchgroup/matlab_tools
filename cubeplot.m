function [cubemat,x,y,z] = cubeplot(file,xyz)

disp("reading cube file")
[cubemat,orig,Xstep,Ystep,Zstep,Atom,AtMass,AtX,AtY,AtZ,N,NX,NY,NZ] = cuberead(file);
disp("finished reading cube file")

conv = 0.529177249;
minx = orig(1)*conv;
miny = orig(2)*conv;
minz = orig(3)*conv;
xstep = Xstep(1)*conv;
ystep = Ystep(2)*conv;
zstep = Zstep(3)*conv;
maxx = (orig(1)+(Xstep(1)*(NX-1)))*conv;
maxy = (orig(2)+(Ystep(2)*(NY-1)))*conv;
maxz = (orig(3)+(Zstep(3)*(NZ-1)))*conv;
[x,y,z] = meshgrid(minx:xstep:maxx,miny:ystep:maxy,minz:zstep:maxz);
disp("loaded mesh grid")

xyzplot(xyz,0.8,1);

disp("plotted molecule from xyz")
hold on

p = patch(isosurface(x,y,z,cubemat,0.0005));
set(p,'FaceColor','r','EdgeColor','none','FaceAlpha',0.6);
disp("doing isosurfaces 1")
q = patch(isosurface(x,y,z,cubemat,-0.0005));
set(q,'FaceColor', 'b','EdgeColor','none','FaceAlpha',0.6);
disp("doing isosurfaces 2")
%alpha(0.5);

%Pt1, EE-ME
% [xs,ys] = meshgrid(minx:xstep:maxx,miny:ystep:maxy);
% zs =  (-9929327877812608*xs + 4225611574380694*ys - 14950173373775548)/5822633625511935;
% hcont = contourslice(x,y,z,cubemat,xs,ys,zs,linspace(-0.002,0.002,20));
% set(hcont,'LineWidth',0.5,'AmbientStrength', 1);
% caxis([-0.002 0.002]);

%Pt1, field
% [xs,ys] = meshgrid(minx:xstep:maxx,miny:ystep:maxy);
% zs =  (-267013664904630*xs + 16223320129828160*ys + 9656677066415828)/-1925051770015543;
% hcont = contourslice(x,y,z,cubemat,xs,ys,zs,linspace(-0.5,0.5,40));
% set(hcont,'LineWidth',0.5,'AmbientStrength', 1);
% caxis([-0.5 0.5]);

%CO field
%hcont = contourslice(x,y,z,cubemat,0,[],[],linspace(-0.002,0.002,20));
%set(hcont,'LineWidth',0.5,'AmbientStrength', 1);
%caxis([-0.002 0.002]);

hold off

delete(findall(gcf,'Type','light'));

axis off;
set(gcf,'color','w');
view([90 0]);
%view([56 24])
delete(findall(gcf,'Type','light'));
camlight right;
lighting gouraud;
