% ����ˮƽԲ��������Za��Ha�Ļ���ת��

clc;
clear;

% ���ֲ���Χ
dx=5; % X�������� m
nx=101; % X��������
xmin=-250; % X������� m
x=xmin:dx:(xmin+(nx-1)*dx); % X����Χ m

% ����ˮƽԲ�������
i=pi/2;  %��Ч�Ż����is
R1=10; % ˮƽԲ����1�뾶 m
L1=30; % ˮƽԲ����1���򳤶� m
R2=30; % ˮƽԲ����2�뾶 m
L2=30; % ˮƽԲ����2���򳤶� m
v1=pi*R1^2;
v2=pi*R2^2;
u=4*pi*10^(-7);  %�ŵ���
M=0.7;   %�Ż�ǿ�� A/m
m1=M*v1;   %�ž�
m2=M*v2;   %�ž�
D1=20; % ˮƽԲ����1���� m
D2=50; % ˮƽԲ����2���� m

% ����1���۴��쳣
Za1=(u*m1*((D1.^2-(x-50).^2)*sin(i)-2*D1*(x-50).*cos(i)))./(2*pi*((x-50).^2+D1.^2).^2);
Ha1=-u*m1*((D1.^2-(x-50).^2)*cos(i)+2*D1*(x-50).*sin(i))./(2*pi*((x-50).^2+D1.^2).^2);
% ����2���۴��쳣
Za2=(u*m2*((D2.^2-(x+50).^2)*sin(i)-2*D2*(x+50).*cos(i)))./(2*pi*((x+50).^2+D2.^2).^2);
Ha2=-(u*m2*((D2.^2-(x+50).^2)*cos(i)-2*D2*(x+50).*sin(i)))./(2*pi*((x+50).^2+D2.^2).^2);

%����ˮƽԲ��������۴��쳣
Za=Za1+Za2;
Ha=Ha1+Ha2;

e=1:10;
a=[0.4286 0.1749 0.1103 0.0813 0.0645 0.0536 0.0458 0.04 0.0355 0.1759];

% Za ת�� Ha
% Ha ת�� Za
Ha_conversion=zeros(1,nx);
Za_conversion=zeros(1,nx);
for i=11:nx-10
    tmp_ha=0;
    tmp_za=0;
    if(i<=nx/2)
        for j=1:10
            tmp_ha=tmp_ha+a(j)*(Za(i-j)-Za(i+j));
            tmp_za=tmp_za+a(j)*(Ha(i-j)-Ha(i+j));
        end
    else
        for j=1:10
            tmp_ha=tmp_ha+a(j)*(Za(i+j)-Za(i-j));
            tmp_za=tmp_za+a(j)*(Ha(i+j)-Ha(i-j));
        end
    end
    Ha_conversion(i)=tmp_ha;
    Za_conversion(i)=-tmp_za;
end

figure(1),plot(x,Ha,'r',x,Ha_conversion,'b:'),xlabel('X (m)'),ylabel('���쳣(nT.)'),legend('Haԭʼ�쳣','Haת���쳣'),title('����ת���쳣Za->Ha');
figure(2),plot(x,Za,'r',x,Za_conversion,'b:'),xlabel('X (m)'),ylabel('���쳣(nT.)'),legend('Zaԭʼ�쳣','Zaת���쳣'),title('����ת���쳣 Ha->Za');

