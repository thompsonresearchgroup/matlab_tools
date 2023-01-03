function [cubemat,orig,Xstep,Ystep,Zstep,Atom,AtMass,AtX,AtY,AtZ,N,NX,NY,NZ] = cuberead(file)

% Extracts data from gaussian cube file
% cubemat: voxel data, cubemat(NX,NY,NZ)
% orig: origin of voxel data, orig(x,y,z)
% Nstep: cartesian vector step of voxel, Nstep(x,y,z)
% Atom: Atoms name vector based on proton mass, Atom(i)
% AtMass: Proton mass vector, AtMass(i)
% AtN: N Coordinate of ith atom, AtN(i)
% N: Number of Atoms, scalar
% NN: number of data points along each voxel basis vector, scalar

cube = importdata(file,' ',6);

for i=3:6;
    in = char(cube.textdata(i,:));
    out = regexp(in, ' *', 'split');
    NAtoms(i-2) = out(2);
    Xo(i-2) = out(3);
    Yo(i-2) = out(4);
    Zo(i-2) = out(5);
end

N = str2double(char(NAtoms(1)));
NX = str2double(char(NAtoms(2)));
NY = str2double(char(NAtoms(3)));
NZ = str2double(char(NAtoms(4)));

orig(1) = str2double(char(Xo(1)));
orig(2) = str2double(char(Yo(1)));
orig(3) = str2double(char(Zo(1)));

Xstep(1) = str2double(char(Xo(2)));
Xstep(2) = str2double(char(Yo(2)));
Xstep(3) = str2double(char(Zo(2)));

Ystep(1) = str2double(char(Xo(3)));
Ystep(2) = str2double(char(Yo(3)));
Ystep(3) = str2double(char(Zo(3)));

Zstep(1) = str2double(char(Xo(4)));
Zstep(2) = str2double(char(Yo(4)));
Zstep(3) = str2double(char(Zo(4)));

Atom = zeros(N);
AtMass = zeros(N);
AtX = zeros(N);
AtY = zeros(N);
AtZ = zeros(N);

if (N ~= 0)
    for i=1:N;
        Atom(i) = cube.data(i,1);
        AtMass(i) = cube.data(i,2);
        AtX(i) = cube.data(i,3);
        AtY(i) = cube.data(i,4);
        AtZ(i) = cube.data(i,5);
    end  
else
    Atom = 0;
    AtMass = 0;
    AtX = 0;
    AtY = 0;
    AtZ = 0;
end

cubedat = importdata(file,' ',6+N);
voxels = reshape(transpose(cubedat.data),[],1);
voxels(any(isnan(voxels),2),:)=[];

cubemat = zeros(NY,NX,NZ);

i=1;
for ix=1:NX;
      for iy=1:NY;
         for iz=1:NZ;
             cubemat(iy,ix,iz) = voxels(i);
             i=i+1;
         end
      end
end