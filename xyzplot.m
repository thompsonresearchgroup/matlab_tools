function [] = xyzplot(file,scale,cscale)

%file is a .xyz file of the molecule
%scale sets the diameter of the atom spheres
% cscale sets the diameter of the connecting cylinders

fid = fopen(file);
xyz = textscan(fid,' %s %f %f %f', 'delimiter',' ','MultipleDelimsAsOne',1,'HeaderLines', 2);
fclose(fid);

AtNam = char(xyz{1});
AtX = xyz{2};
AtY = xyz{3};
AtZ = xyz{4};
NAtoms = length(AtNam);

hold on
for i=1:NAtoms
    switch (AtNam(i))
        case  'H', color = [0.80 0.80 0.80]; r = 0.25*scale;
        case  'C', color = [0.55 0.55 0.55]; r = 0.4*scale;
        case  'N', color = [0.01 0.01 0.90]; r = 0.4*scale;
        case  'O', color = [1.00 0.00 0.00]; r = 0.4*scale;
        case  'F', color = [0.70 1.00 1.00]; r = 0.4*scale;
        case  'S', color = [1.00 0.78 0.16]; r = 0.5*scale; 
        case  'Pd', color = [0.00 0.41 0.52]; r = 0.7*scale;
        otherwise, color = [0.00 1.00 0.00]; r = 0.4*scale;
    end
    [x,y,z] = sphere(100);
    hsurf = surf(r*x+AtX(i),r*y+AtY(i),r*z+AtZ(i));
    set(hsurf,'EdgeColor','none','FaceColor',color);
end

for i=1:NAtoms
    for j=i+1:NAtoms
        dist = sqrt((AtX(i)-AtX(j))^2 + (AtY(i)-AtY(j))^2 + (AtZ(i)-AtZ(j))^2);
        if (dist < 1.6)
            [x,y,z] = cylinder2P(0.06*cscale,100,50,[AtX(i) AtY(i) AtZ(i)],[AtX(j) AtY(j) AtZ(j)]);
            hsurf = surf(x, y, z);
            set(hsurf,'EdgeColor','none','FaceColor',[0.5 0.5 0.5]);
        end
    end
end
hold off
daspect([1 1 1]);
camlight('left');
lighting gouraud;
view(3);
