clc;
clear all;
close all;
%�����Ԫ�����ļ�ֵ�� �������ж�
syms x y  %�����Ԫ���� x y
z = 6*x^2+6*y^2-8*x*y-16*x+4*y;%�����Ԫ��������
f1 = simplify(diff(z,x));%��z��x��һ��ƫ��diff����
f2 = simplify(diff(z,y));%��z��y��һ��ƫ��simplify�Ǽ���ʽ
%�ֱ���f1 = 0 f2 = 0
% [x1,y1] = solve(12*x-8*y-16==0,12*y-8*x+4==0,x,y); %���Ԫ������פ�㣨x1,y1)
[x1,y1] = solve(f1==0,f2==0,x,y); %���Ԫ������פ�㣨x1,y1)
x1 = double(x1); %��sym����ת��Ϊdouble��ֵ��ʽ
y1 = double(y1);%��sym����ת��Ϊdouble��ֵ��ʽ
n = length(x1);%�󳤶�
%���פ�����
fprintf('��Ԫ����z=f(x,y)��פ�����Ϊn =%d\r\n',n);
%���פ������
for i = 1:n
    fprintf('��Ԫ����z=f(x,y)�ĵ�%d��פ��Ϊ��x,y)=(%f,%f)\r\n',i,x1(i),y1(i));
end
%��ֵA,B,CΪ�վ���
A = [];
B = [];
C = [];
for i = 1:n
    %sub���������滻��⺯���ľ���ĳ���ֵ��double������sym����ת��Ϊdouble��ֵ��ʽ
        temp = double(subs(diff(z,x,2),[x y],[x1(i) y1(i)])); %����A
        temp1 = double(subs(diff(f1,y,1),[x y],[x1(i) y1(i)]));%����B
        temp2 = double(subs(diff(z,y,2),[x y],[x1(i) y1(i)]));%����C
        A = [A;temp];%�洢A�ļ�����    
        B = [B;temp1];%�洢B�ļ�����    
        C = [C;temp2];%�洢C�ļ�����
end
%����AC-B^2����ж� ����x,y)����ֵ����0������ڼ�ֵ�㣬��֮��������A>0����Ϊ��Сֵ�㣬A<0,��Ϊ����ֵ��
R = A.*C-B.^2;
%�ж�
for i = 1:n
    if R(i)>0
        if A(i)>0
            %��subs�������㼫ֵ�㴦�ĺ���ֵ��Ȼ����double������sym��ʽ������ֵ��ʽ
            ymax = double(subs(z,[x y],[x1(i) y1(i)]));
            fprintf('��Ԫ����z=f(x,y)�ĵ�%d��פ�㣨x,y)=(%f,%f)Ϊ��Сֵ�㣬��СֵΪ��%f\r\n',i,x1(i),y1(i),ymax);
        else
            ymin = double(subs(z,[x y],[x1(i) y1(i)]));
            fprintf('��Ԫ����z=f(x,y)�ĵ�%d��פ�㣨x,y)=(%f,%f)Ϊ����ֵ�㣬����ֵΪ��%f\r\n',i,x1(i),y1(i),ymin);
        end
    else
        fprintf('��Ԫ����z=f(x,y)�ĵ�%d��פ�㣨x,y)=(%f,%f)���Ǽ�ֵ��\r\n',i,x1(i),y1(i));
    end
end