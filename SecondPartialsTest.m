clc;
clear all;
close all;
%计算二元函数的极值点 并进行判断
syms x y  %定义二元变量 x y
z = 6*x^2+6*y^2-8*x*y-16*x+4*y;%定义二元变量函数
f1 = simplify(diff(z,x));%求z对x的一阶偏导diff函数
f2 = simplify(diff(z,y));%求z对y的一阶偏导simplify是简化形式
%分别令f1 = 0 f2 = 0
% [x1,y1] = solve(12*x-8*y-16==0,12*y-8*x+4==0,x,y); %求二元函数的驻点（x1,y1)
[x1,y1] = solve(f1==0,f2==0,x,y); %求二元函数的驻点（x1,y1)
x1 = double(x1); %将sym个数转化为double数值格式
y1 = double(y1);%将sym个数转化为double数值格式
n = length(x1);%求长度
%输出驻点个数
fprintf('二元函数z=f(x,y)的驻点个数为n =%d\r\n',n);
%输出驻点坐标
for i = 1:n
    fprintf('二元函数z=f(x,y)的第%d个驻点为（x,y)=(%f,%f)\r\n',i,x1(i),y1(i));
end
%幅值A,B,C为空矩阵
A = [];
B = [];
C = [];
for i = 1:n
    %sub函数用来替换求解函数的具体某点的值和double函数将sym个数转化为double数值格式
        temp = double(subs(diff(z,x,2),[x y],[x1(i) y1(i)])); %计算A
        temp1 = double(subs(diff(f1,y,1),[x y],[x1(i) y1(i)]));%计算B
        temp2 = double(subs(diff(z,y,2),[x y],[x1(i) y1(i)]));%计算C
        A = [A;temp];%存储A的计算结果    
        B = [B;temp1];%存储B的计算结果    
        C = [C;temp2];%存储C的计算结果
end
%根据AC-B^2结果判断 若（x,y)计算值大于0，则存在极值点，反之不存在若A>0，则为极小值点，A<0,则为极大值点
R = A.*C-B.^2;
%判断
for i = 1:n
    if R(i)>0
        if A(i)>0
            %用subs函数计算极值点处的函数值，然后用double函数将sym格式化成数值格式
            ymax = double(subs(z,[x y],[x1(i) y1(i)]));
            fprintf('二元函数z=f(x,y)的第%d个驻点（x,y)=(%f,%f)为极小值点，极小值为：%f\r\n',i,x1(i),y1(i),ymax);
        else
            ymin = double(subs(z,[x y],[x1(i) y1(i)]));
            fprintf('二元函数z=f(x,y)的第%d个驻点（x,y)=(%f,%f)为极大值点，极大值为：%f\r\n',i,x1(i),y1(i),ymin);
        end
    else
        fprintf('二元函数z=f(x,y)的第%d个驻点（x,y)=(%f,%f)不是极值点\r\n',i,x1(i),y1(i));
    end
end