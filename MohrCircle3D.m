%This code computes the 3D Stress State and Plots the Mohrs Circle.
                        %%Input Stress State%%
sigmax = input('sigma_{x} [MPa] = ');
sigmay = input('sigma_{y} [Mpa] = ');
sigmaz = input('sigma_{z} [Mpa] = ');
tauxy = input('tau_{xy} [Mpa] = ');
tauyz = input('tau_{yz} [Mpa] = ');
tauzx = input('tau_{zx} [Mpa] = ');

%%%%%%%%%%%%%%%%%%%%%%%%%%Calculations%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Defining the coefficients based on form
% a*x^3+b*x^2+c*x+d=0
a = 1;
b = -(sigmax+sigmay+sigmaz);
c = (sigmax*sigmay+sigmax*sigmaz+sigmay*sigmaz-(tauxy)^2-(tauyz)^2-(tauzx)^2);
d = -(sigmax*sigmay*sigmaz+2*tauxy*tauyz*tauzx-sigmax*tauyz^2-sigmay*tauzx^2-sigmaz*tauxy^2);

% Finding the roots of the cubic polynomial created bt the stresses
F = [a b c d];
A = roots(F);
%Arranges matrix rows in a decending order
sigmas = sortrows(A,-1);

%Principle Normal Stresses
sigma1 = sigmas(1,1)
sigma2 = sigmas(2,1)
sigma3 = sigmas(3,1)

%Principle Shear Stresses
tau12 = (sigma1-sigma2)/2;
tau23 = (sigma2-sigma3)/2;
tau13 = (sigma1-sigma3)/2;

%Condition for maximum shear stress
if (sigma1 > sigma2)&& (sigma2 > sigma3);
taumax = tau13
end

%%%%%%%%%%%Circle of sigma1 and sigma 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x center of circle
x1 =(sigma1+(sigma2))/2;         
%y center of circle
y1 = 0;        
R12 = tau12;
N = 100;        

% create equal length arrays defining a circle in polar coordinates
theta12 = linspace(0,2*pi,N);
r12 = R12 * ones(1,N);

% convert polar coordinates to Cartesian coordinates
[x12, y12] = pol2cart(theta12, r12);

% offset the circle so its center lies at (x0, y0)
x12 = x12 + x1;         
y12 = y12 + y1;
%%%%%%%%%%%%%%%%Circle sigma2 and sigma3%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x2 = (sigma2+(sigma3))/2;         % x center of circle
y2 = 0;         %            y center of circle
R23 = tau23 ;
N = 100;        % number of points used to define circle

% create equal length arrays defining a circle in polar coordinates
theta23 = linspace(0,2*pi,N);
r23 = R23 * ones(1,N);

% convert polar coordinates to Cartesian coordinates
[x23, y23] = pol2cart(theta23, r23);

% offset the circle so its center lies at (x0, y0)
x23 = x23 + x2;         
y23 = y23 + y2;

%%%%%%%%%%%%%%%%%%%%Circle sigma1 and sigma3%%%%%%%%%%%%%%%%%%%%%%%%

x3 = (sigma1+(sigma3))/2;         % x center of circle
y3 = 0;         %            y center of circle
R13 = tau13;
N = 100;        % number of points used to define circle

% create equal length arrays defining a circle in polar coordinates
theta13 = linspace(0,2*pi,N);
r13 = R13 * ones(1,N);

% convert polar coordinates to Cartesian coordinates
[x13, y13] = pol2cart(theta13, r13);

% offset the circle so its center lies at (x0, y0)
x13 = x13 + x3;         
y13 = y13 + y3;

%%%%%%%%%Plot of Vertical lines to principle shear stresses%%%%%%%%%%%
%tau12
x5 = x1;
y5 = 0:tau12;

%tau23
x6 = x2;
y6 = 0:tau23;

%tau13
x7 = x3;
y7 = 0:tau13;
%%%%%%%%%%%%%%%%%%%Plotting of the Three Circles%%%%%%%%%%%%%%%%%%%%%%%%
plot(x12,y12,'b-',x23,y23,'r-',x13,y13,'k-',x5,y5,'k.',x6,y6,'k.',x7,y7,'k.')
title('Mohrs 3D Circle')
xlabel('\sigma \rightarrow [MPa]')        
ylabel('\tau^{cw} \rightarrow [MPa]')
grid on
axis equal

%%%%%%%%%%%%%%%%%Labeling%%%%%%%%%%%%%%%%%%%%
xa = sigma1;
ya = 0;
txt1 = '\leftarrow \sigma_{1}';
text(xa,ya,txt1)

xb = sigma2;
yb = 0;
txt2 = '\leftarrow \sigma_{2}';
text(xb,yb,txt2)

xc = sigma3;
yc = 0;
txtc = '\leftarrow \sigma_{3}';
text(xc,yc,txtc)

xd = x1;
yd = tau12;
txtd = '\tau_{12}';
text(xd,yd,txtd)

xe = x2;
ye = tau23;
txte = '\tau_{23}';
text(xe,ye,txte)

xf = x3;
yf = tau13;
txtf = '\tau_{13}';
text(xf,yf,txtf)