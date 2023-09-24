function len_to=len_count
a=6000;
b=5000;
x=[2200 2900];
y=[3600 3300];
z=b*sqrt(1-(x.*x+y.*y)/(a*a));
vA=[x(1) y(1) z(1)];
vB=[x(2) y(2) z(2)];
vBA=vA-vB;
pcs=0.01;
x1=x(1);y1=y(1);z1=z(1);
loc=[x(1),y(1),z(1)];
i=2;len_to=0;
for t=pcs:pcs:1
    x1=x(1)-vBA(1)*t;
    y1=y(1)-vBA(2)*t;
    z1=z(1)-vBA(3)*t;
    syms m f;
    f=(x1*m)^2/a^2+(y1*m)^2/a^2+(z1*m)^2/b^2-1;
    m0=max(double(solve(f,m)));
    x2=x1*m0;y2=y1*m0;z2=z1*m0;
    loc=[loc;x2,y2,z2];
    len=sqrt((loc(i,1)-loc(i-1,1))^2+(loc(i,2)-loc(i-1,2))^2+(loc(i,3)-loc(i-1,3))^2);
    i=i+1;
    len_to=len_to+len;
end
[theta,alpha]=meshgrid(linspace(0,pi/2,1000), linspace(0,2*pi,1000));
z=b*sin(theta);
x=a*cos(theta).*cos(alpha);
y=a*cos(theta).*sin(alpha);
mesh(x,y,z);
hold on;
plot3(vA(1),vA(2),vA(3),'r.','markersize',24);
plot3(vB(1),vB(2),vB(3),'r.','markersize',24);
hold on;
for i=1:100
    plot3([loc(i,1),loc(i+1,1)],[loc(i,2),loc(i+1,2)],[loc(i,3),loc(i+1,3)]);
    hold on;
end