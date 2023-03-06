%% Entrega 4 Reto
%Adolfo Gonzalez
%Esteban Sierra
%Sofia Schneider
%Charles Gonzalez
%Yahel Vidal

%% Entrada valroes y velocidades

disp("De 9.3991-15.7101 m/s o mayor se derrape el carro")
v=input('Ingresa Velocidad de curva: ');

%% Funcion y grafica
%Puntos en la grafica
x1=10    ;y1=290; %inicial
x2=280   ;y2=120; %final
x3=90    ;y3=75; 
x4=213   ;y4=250;

%valores para sacar coeficientes
valoresy=[y1; y2; y3; y4];
valoresx=[x1.^3,  x1.^2, x1, 1;
          x2.^3,  x2.^2, x2, 1;
          x3.^3,  x3.^2, x3, 1;
          x4.^3,  x4.^2, x4, 1];

%coeficientes de la funcion cubica
abcd=valoresx\valoresy;

%creacion de la funcion vectorizada con rangos e intervalos
vx=linspace(1,300,300);
vy=abcd(1)*vx.^3 + abcd(2)*vx.^2 + abcd(3)*vx + abcd(4);
avy=@(x) abcd(1)*x.^3 + abcd(2)*x.^2 + abcd(3)*x + abcd(4); %funcion anonima

%grafica de la funcion
hold on
axis([0,350,0,350])

plot(vx,avy(vx),'Color',[0.7 0.7 0.7],'LineWidth',10)
textoVelocidad="Velocidad en Curva: "+num2str(v);
text(75,275,textoVelocidad)


%% Radio y long
%derivadas de la funcion
dvy=@(x) 3*abcd(1)*x.^2 + 2*abcd(2)*x + abcd(3); %funcion anonima
ddvy=@(x) 6*abcd(1)*x+2*abcd(2); %funcion anonima

%funcion radio de curvatura
radioCurva=@(x)((1+dvy(x).^2).^(3/2))./abs(ddvy(x)); %funcion para radio de la curva

%longitud de la curva
longCurva=integral(dvy,300,0);
strLong="Longitud de Curva: "+num2str(longCurva);
text(75,325,strLong,"FontSize",15,"FontName","times") %mostrar long en grafica

%radio de curvatura
minFun=find(avy(vx)==min(vy(50:125))); %regresa index del min
maxFun=find(avy(vx)==max(vy(200:250))); %regresa index del max

radio1=radioCurva(minFun); %radio punto min
radio2=radioCurva(maxFun); %radio punto max

strRad1=num2str(radio1);
text(70,130,strRad1)
strRad2=num2str(radio2);
text(200,200,strRad2)


%% Zona de derrape
%vectores con valores de x con radio menor a 50
vxradio1=[]; 
vxradio2=[];

%for loop para verficar que valores tienen un radio menor a 50 y asginarlos
%a su vector respectivo de cada curva
for i=vx
    radio=radioCurva(i);
    if radio<50
        if i<150
            vxradio1=[vxradio1 i];
        else
            vxradio2=[vxradio2 i];
        end
    end
end

%graficar las zonas de derrape en ambas curvas
plot(vxradio1,avy(vxradio1),"Color",'yellow','LineWidth',9)
plot(vxradio2,avy(vxradio2),"Color",'yellow','LineWidth',9)


%% Recta tangente y perpendicular
vxTang=@(x) x:x+50;
vxPend=@(x) x-50:x;

rectaTang=@(x) avy(x)+dvy(x)*(vxTang(x)-x);
rectaPend=@(x) avy(x)+(-1./dvy(x))*(vxPend(x)-x);


%plot(vxTang(min(vxradio1)),rectaTang(min(vxradio1)),'Color',[1,0.5,0.5],'LineWidth',5)
%plot(vxPend(min(vxradio1)),rectaPend(min(vxradio1)),"Color",[0.5,0.5,1],'LineWidth',5)

%plot(vxTang(min(vxradio2)),rectaTang(min(vxradio2)),'Color',[1,0.5,0.5],'LineWidth',5)
%plot(vxPend(min(vxradio2)),rectaPend(min(vxradio2)),"Color",[0.5,0.5,1],'LineWidth',5)

%% Gradas

shape1=nsidedpoly(100,'Center',[min(vxradio1),vy(min(vxradio1))],'Radius',20);
%plot(shape1) 
grada1=polyshape([52,52+80,52+80,52],[70,70,70-10,70-10]);
plot(rotate(grada1,-48,[52,70]))

shape2=nsidedpoly(100,'Center',[min(vxradio2),vy(min(vxradio2))],'Radius',20);
%plot(shape2) 
grada2=polyshape([193,193+80,193+80,193],[261,261,261+10,261+10]);
plot(rotate(grada2,39,[193,261]))

%Se formo un circulo con radio 20 para ver el punto inicial del rectangulo

%% Rapidez maxima

g=9.8;
friccCinetica=0.6;
friccEstatica=0.8;

vxvelmax1=radioCurva(vxradio1);
vxvelmax2=radioCurva(vxradio2);

for i=1:length(vxvelmax1)
    vmax=sqrt(g*friccEstatica*vxvelmax1(i));
    vxvelmax1(i)=vmax;
end

for i=1:length(vxvelmax2)
    vmax=sqrt(g*friccEstatica*vxvelmax2(i));
    vxvelmax2(i)=vmax;
end

%% Energia perdida
masa=750;
energiaPerdida=@(v) 0.5*masa*v^2;
distanciaRecorrida=@(v) v^2/(2*friccCinetica*g);

carro=animatedline;
clearpoints(carro);
breakk=0;
indexcurva=1;
for posx=vx
    indexcurva=posx-(min(vxradio1))+1;
    if ismember(posx,vxradio1)==1 && v>vxvelmax1(indexcurva)
        breakk=1; break
    else
        addpoints(carro,vx(posx),vy(posx))
        drawnow
    end
end
if breakk==1
    for i=1:length(vxradio1)
        vxTangDerrape=vxTang(posx);
        vyTangDerrape=rectaTang(posx);
        addpoints(carro,vxTangDerrape(i),vyTangDerrape(i));
        drawnow
    end
    energiaTexto="Calor: "+num2str(energiaPerdida(v))+"J";
    distanciaTexto="dMax: "+num2str(distanciaRecorrida(v))+"m";
    text(75,250,energiaTexto)
    text(75,225,distanciaTexto)
end

