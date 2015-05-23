clc;
clear;

% ���ֲ���Χ
dx=5; % X��������
dy=5; % Y��������
nx=81; % X��������
ny=81; % Y��������
xmin=-200; % X�������
ymin=-200; % Y�������
x=xmin:dx:(xmin+(nx-1)*dx); % X����Χ
y=ymin:dy:(ymin+(ny-1)*dy); % Y����Χ
[X,Y]=meshgrid(x,y); % ת��Ϊ����

u=4*pi*10^(-7);  %�ŵ���
i=pi/3;  %��Ч�Ż����is
a=0; %����ŷ�λ��
T=50000;%�شų�T=50000nT

% ����1����
R1=10; % ����뾶 m
D1=30; % �������� m
v1=4*pi*R1^3;
k=0.2; %�Ż���
M1=k*T/u;  %�Ż�ǿ�� A/m
m1=M1*v1;   %�ž�

% ����1 ���۴��쳣
%(x-50),(y-0)
Za1=(u*m1*((2*D1.^2-(X-50).^2-Y.^2)*sin(i)-3*D1*(X-50).*cos(i)*cos(a)-3*D1*Y.*cos(i)*sin(a)))./(4*pi*((X-50).^2+Y.^2+D1.^2).^(5/2));
Hax1=(u*m1*((2*(X-50).^2-Y.^2-D1.^2)*cos(i)*cos(a)-3*D1*(X-50).*sin(i)+3*(X-50).*Y.*cos(i)*sin(a)))./(4*pi*((X-50).^2+Y.^2+D1.^2).^(5/2));
Hay1=(u*m1*((2*Y.^2-(X-50).^2-D1.^2)*cos(i)*cos(a)-3*D1*Y.*sin(i)+3*(X-50).*Y.*cos(i)*cos(a)))./(4*pi*((X-50).^2+Y.^2+D1.^2).^(5/2));
deltT1=u*m1*((2*D1.^2-(X-50).^2-Y.^2)*sin(i)*sin(i)+(2*(X-50).^2-Y.^2-D1.^2)*(cos(i)*cos(a))^2+(2*Y.^2-(X-50).^2-D1.^2)*(cos(i)*sin(a))^2-3*(X-50).*D1*sin(2*i)*cos(a)+3*(X-50).*Y.*cos(i)^2*sin(2*a)-3*Y.*D1*sin(2*i)*sin(a))./(4*pi*((X-50).^2+Y.^2+D1.^2).^(5/2));

% ����2����
R2=100; % ����뾶 m
v2=4*pi*R2^3;
k=0.2; %�Ż���
M2=k*T/u;  %�Ż�ǿ�� A/m
m2=M2*v2;   %�ž�
D2=100; % �������� m

% ����2 ���۴��쳣
%(x-0_,(y-0)
Za2=(u*m2*((2*D2.^2-X.^2-Y.^2)*sin(i)-3*D2*X.*cos(i)*cos(a)-3*D2*Y.*cos(i)*sin(a)))./(4*pi*(X.^2+Y.^2+D2.^2).^(5/2));
Hax2=(u*m2*((2*X.^2-Y.^2-D2.^2)*cos(i)*cos(a)-3*D2*X.*sin(i)+3*X.*Y.*cos(i)*sin(a)))./(4*pi*(X.^2+Y.^2+D2.^2).^(5/2));
Hay2=(u*m2*((2*Y.^2-X.^2-D2.^2)*cos(i)*cos(a)-3*D2*Y.*sin(i)+3*X.*Y.*cos(i)*cos(a)))./(4*pi*(X.^2+Y.^2+D2.^2).^(5/2));
deltT2=u*m2*((2*D2.^2-X.^2-Y.^2)*sin(i)*sin(i)+(2*X.^2-Y.^2-D2.^2)*(cos(i)*cos(a))^2+(2*Y.^2-X.^2-D2.^2)*(cos(i)*sin(a))^2-3*X.*D2*sin(2*i)*cos(a)+3*X.*Y.*cos(i)^2*sin(2*a)-3*Y.*D2*sin(2*i)*sin(a))./(4*pi*(X.^2+Y.^2+D2.^2).^(5/2));

%�����쳣
Za=Za1+Za2;
Hax=Hax1+Hax2;
Hay=Hay1+Hay2;
deltT=deltT1+deltT2;

figure(1),pcolor(X,Y,Za),shading interp,xlabel('x(m)'),ylabel('y(m)'),title('�������� Za�쳣');
figure(2),pcolor(X,Y,Hax),shading interp,xlabel('x(m)'),ylabel('y(m)'),title('�������� Hax�쳣');


%���grd�ļ�
nx=max(size(x));
ny=max(size(y));
xmin=x(1);
xmax=x(nx);
ymin=y(1);
ymax=y(ny);
zmin=min(min(Za));
zmax=max(max(Za));
%Za
fp=fopen('Za.grd','w');
fprintf(fp,'DSAA\n');
fprintf(fp,'%d\t%d\n',nx,ny);
fprintf(fp,'%g\t%g\n',xmin,xmax);
fprintf(fp,'%g\t%g\n',ymin,ymax);
fprintf(fp,'%g\t%g\n',zmin,zmax);
for i=1:ny
    for j=1:nx
        fprintf(fp,'%g\t',Za(i,j));
        if mod(j,10)==0
            fprintf(fp,'\n');
        end
    end
    fprintf(fp,'\n');
end
fclose(fp);

zmin=min(Hax);
zmax=max(Hax);
fp=fopen('Hax.grd','w');
fprintf(fp,'DSAA\n');
fprintf(fp,'%d\t%d\n',nx,ny);
fprintf(fp,'%g\t%g\n',xmin,xmax);
fprintf(fp,'%g\t%g\n',ymin,ymax);
fprintf(fp,'%g\t%g\n',zmin,zmax);
for i=1:ny
    for j=1:nx
        fprintf(fp,'%g\t',Hax(i,j));
        if mod(j,10)==0
            fprintf(fp,'\n');
        end
    end
    fprintf(fp,'\n');
end
fclose(fp);

%Hay
zmin=min(Hay);
zmax=max(Hay);
fp=fopen('Hay.grd','w');
fprintf(fp,'DSAA\n');
fprintf(fp,'%d\t%d\n',nx,ny);
fprintf(fp,'%g\t%g\n',xmin,xmax);
fprintf(fp,'%g\t%g\n',ymin,ymax);
fprintf(fp,'%g\t%g\n',zmin,zmax);
for i=1:ny
    for j=1:nx
        fprintf(fp,'%g\t',Hay(i,j));
        if mod(j,10)==0
            fprintf(fp,'\n');
        end
    end
    fprintf(fp,'\n');
end
fclose(fp);

%deltT
zmin=min(deltT);
zmax=max(deltT);
fp=fopen('deltT.grd','w');
fprintf(fp,'DSAA\n');
fprintf(fp,'%d\t%d\n',nx,ny);
fprintf(fp,'%g\t%g\n',xmin,xmax);
fprintf(fp,'%g\t%g\n',ymin,ymax);
fprintf(fp,'%g\t%g\n',zmin,zmax);
for i=1:ny
    for j=1:nx
        fprintf(fp,'%g\t',deltT(i,j));
        if mod(j,10)==0
            fprintf(fp,'\n');
        end
    end
    fprintf(fp,'\n');
end
fclose(fp);