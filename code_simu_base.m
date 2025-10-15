% ------------------------- %
% Définition des paramètres %
% ------------------------- %
close();

% Distance en mètres
dl=1e-4;

l= 1e-3;
a= 1e-3;

L= 16e-3;
b= 2e-3;

% ------------------------- %
%   Dimensions associées    %
% ------------------------- %

N1 = floor(a/dl);
N2 = floor((a+l)/dl);
M1 = floor(L/dl);
M2 = floor((b+L)/dl);

% ------------------------- %
%  Génération des matrices  %
% ------------------------- %

% matrice des références des sommets Refs
% Refs= NaN si pas de grille, Refs= 0 si intérieur et bords de 1 à 6 dans
% le sens antihoraire

Refs=zeros(N2,M2);

Refs(N1:N2,1:M1)=NaN;
Refs(1:N1,1)=1;
Refs(N1,1:M1)=2;
Refs(N1:N2,M1)=3;
Refs(N2,M1:M2)=4;
Refs(1:N2,M2)=5;
Refs(1,1:M2)=6;

%-------------------------------------------- %
%             Paramètres Physiques            %
% ------------------------------------------- %

% Temps
dt=0.4e-5; % pas de tps
t=0.06; % simu
I= floor(t/dt);% Caractéristiques des materiaux

% Métal
k_m=401; % conductivité thermique
rho_m=8960; % Masse volumique
cp_m=390; % Capacité thermique
alpha_m=k_m/(rho_m*cp_m); % Diffusivité thermique
eps_m = 0.003*5.67e-8; % émissivité du cuivre poli x constante de Stefan

% Gaz Chaud
rho_gaz=0.1;
cp_gaz=2800;
k_gaz=0.24;
mu_gaz=72e-6;% Viscosité dynamique
T_gaz=3273; % Température de l'air en entrée de circuit
v_gaz=4.10^3; % Vitesse de l'air dans la tuyère

Pr_a=cp_gaz*mu_gaz/k_gaz; % Nombre de Prandtl
Re_a=b*v_gaz*rho_gaz/mu_gaz; % Nombre de Reynolds moyen avec S=pi*b^2

h_gaz=0.332*k_gaz/b*Pr_a^(1/3)*sqrt(Re_a); % Coefficient de convection
% Nu_a=h_a*b/k_a; % Nombre de Nusselt de l'hydrogène

% Hydrogène
rho_h=69.9;
cp_h=10800;
k_h=0.113;
mu_h=11.83e-6;
T_h=80; % Température de l'hydrogène liquide
D_h=0.04; % Débit massique

Pr_h=cp_h*mu_h/k_h; % Nombre de Prandtl
Re_h=L*D_h/(mu_h*pi*b^2); % Nombre de Reynolds moyen avec S=pi*b^2

h_H2=0.332*k_h/L*Pr_h^(1/3)*sqrt(Re_h); % Coefficient de convection
Nu_h=h_H2*L/k_h; % Nombre de Nusselt de l'hydrogène


tau=alpha_m*dt/(dl*dl); % Nombre de Fourier

% Air Exté

T_air = 300; % température ambiante 



%-------------------------------------------- %
%                Initialisations              %
% ------------------------------------------- %


% Matrice contenant les températures en fonction des coordonnées (n,m)

T0=300*ones(N2,M2);
T0(N1+1:N2,1:M1-1)=NaN;

% Création vidéo
writerObj = VideoWriter('VideoSimulation.avi');
writerObj.FrameRate = 10;
load('color_gradient_v2.mat', 'color_gradient_v2');  % Charge la variable
colormap(color_gradient_v2);  % Applique la colormap
% Overture de la vidéo
open(writerObj);

%-------------------------------------------- %
%    Itération des équations élémentaires     %
% ------------------------------------------- %

for i=1:I 
    T1=calcul_temperature(T0, Refs,N1,M1, M2, N2,tau,k_m,dl,h_H2,h_gaz,T_h,T_air,T_gaz,eps_m);
    T1= modifie_coin(T1,T0,N1,N2,M1,M2,tau,dl,eps_m,k_m,T_gaz,h_gaz,h_H2,T_h);
    T0=T1;
    if mod(i,10)==0
        alpha_data = ~isnan(T1);  % 1 pour les valeurs valides, 0 pour NaN
        imagesc(T1, 'AlphaData', alpha_data);
        colorbar;
        title(sprintf('Temps : %f',dt*i));
        axis equal;
        caxis([0,3000]); % Fixe l'échelle de couleur entre 0 et 10
        F = getframe(gcf) ;
        writeVideo(writerObj, F);
    end
end

% Fermeture de la vidéo

close(writerObj); 
