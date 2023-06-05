clc; 
a=[1,2,3,4,5]; 
b=[1,2,3,4]; 
%test commutative property
% c=a*b d=b*a
c=linearconv(a,b); 
d=linearconv(b,a); 
disp('LHS of commutative property'); 
disp(c); 
disp('RHS of commutative property'); 
disp(d); 
disp('COMMUTATIVE PROPERTY VERIFIED.'); 
disp(' ')

%test associative property
a=[1,2,3,4,5]; 
b=[1,2,3]; 
c=[2,3]; 
%find (a*b)*c where d=a*b
d=linearconv(a,b); 
e=linearconv(d,c); 
%find a*(b*c) where f=b*c
f=linearconv(b,c); 
g=linearconv(a,f); 

disp('LHS of associative property'); 
disp(e); 
disp('RHS of associative property'); 
disp(g); 
disp('ASSOCIATIVE PROPERTY VERIFIED.');
disp(' ')

%test distributive property
a=[1,2,3]; 
x1=[2,3,4,5]; 
x2=[8,9]; 
com_length=max([length(a),length(x1),length(x2)]); 
a=[a zeros(1,com_length-length(a))]; 
x1=[x1 zeros(1,com_length-length(x1))]; 
x2=[x2 zeros(1,com_length-length(x2))]; 
lhs=linearconv(a,x1)+linearconv(a,x2); 
rhs=linearconv(a,x1+x2); 
disp('LHS of distributive property'); 
disp(lhs); 
disp('RHS of distributive property'); 
disp(rhs);
disp('DISTRIBUTIVE PROPERTY VERIFIED.');
