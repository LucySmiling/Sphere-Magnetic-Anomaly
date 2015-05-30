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
A=0; %����ŷ�λ��
T=50000;%�شų�T=50000nT

% Բ���������
R1=10; % ����뾶 m
D1=30; % �������� m
S1=pi*R1^2;
v1=4*pi*R1^3;
k=0.2; %�Ż���
M1=k*T/u;  %�Ż�ǿ�� A/m
m1=M1*v1;   %�ž�

% Բ���� ���۴��쳣
Za=(u*m1*((D1.^2-(X-50).^2)*sin(i)-2*D1*(X-50).*cos(i)))./(2*pi*((X-50).^2+D1.^2).^2);
Ha=-u*m1*((D1.^2-(X-50).^2)*cos(i)+2*D1*(X-50).*sin(i))./(2*pi*((X-50).^2+D1.^2).^2);
deltT=u*m1*sin(i)*((D1^2-X.^2)*cos(2*i-pi/2)-2*D1*X.*cos(2*i-pi/2))./(2*pi*(X.^2+D1^2).^2*sin(i));

figure(1),pcolor(X,Y,Za),shading interp,xlabel('x(m)'),ylabel('y(m)'),title('�������� Za�쳣');
figure(2),pcolor(X,Y,Ha),shading interp,xlabel('x(m)'),ylabel('y(m)'),title('�������� Ha��');
figure(3),pcolor(X,Y,deltT),shading interp,xlabel('x(m)'),ylabel('y(m)'),title('�������� delta T��');


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

zmin=min(Ha);
zmax=max(Ha);
fp=fopen('Ha.grd','w');
fprintf(fp,'DSAA\n');
fprintf(fp,'%d\t%d\n',nx,ny);
fprintf(fp,'%g\t%g\n',xmin,xmax);
fprintf(fp,'%g\t%g\n',ymin,ymax);
fprintf(fp,'%g\t%g\n',zmin,zmax);
for i=1:ny
    for j=1:nx
        fprintf(fp,'%g\t',Ha(i,j));
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