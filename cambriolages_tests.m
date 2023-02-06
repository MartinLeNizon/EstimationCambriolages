                %% Tests différents gammas et conditions limites périodiques

clear all, close all

% nombres aléatoires différents à l'ouverture de Matlab
[h m s] = hms(datetime('now'));
rng(h*m*s*1e4)

condLimPeriod=0;

parc=0;

                %% Gamma
% 1 : nombre initial de cambrioleurs, puis réapparait aléatoirement sur la carte quand cambriolage
% 2 : nombre initial de cambrioleurs, puis réapparait aléatoirement dans un carré de proximité quand cambriolage
% 3 : Gamma prob apparition cambrioleur chaque case chaque instant
typeGamma=2;
gamma=0.002;

if typeGamma == 2
    distApp = 20;           % Distance max de réapparition des cambrioleurs
end

tic

% Déclarations des variables
largeur=128; hauteur=128;

t0=0; tf=200; dt=1; nIter=(tf-t0)/dt; T=t0:dt:tf;

omega=0.05;         % taux décroissance
A0=1/100;            % attractivité init
eta=0.5;            % dispersion (0<eta<1)
theta=30;          % influence précédents cambriolages

% Déclaration des fonctions
p = @(x) 1-exp(-x*dt);                  % prob d'un cambriolage

A = zeros(hauteur, largeur, nIter+1);              % attractivité
A(:,:,1)=(rand(hauteur,largeur)./2 + 3/4)*A0;

B = zeros(hauteur, largeur, nIter+1);
P(:,:,1) = p(A(:,:,1));                           % probabilités de cambriolages
E = zeros(hauteur, largeur, nIter+1);                   % nombre de cambriolages
V = zeros(hauteur, largeur, nIter+1);                 % nombre de cambrioleurs


% Pose des premiers cambrioleurs
if typeGamma == 1 || typeGamma == 2
    for j=1 : hauteur
        for k=1 : largeur
            if rand()<gamma
                V(j,k,1)=1;
            end
        end
    end
end


% boucle d'itération à chaque tps
for t=1 : nIter
    if parc==1
        A(floor(hauteur/2)-20, floor(largeur/2), t)=0;
        A(floor(hauteur/2)-19, floor(largeur/2)-2:floor(largeur/2)+1, t)=0;
        A(floor(hauteur/2)-18, floor(largeur/2)-3:floor(largeur/2)+2, t)=0;
        A(floor(hauteur/2)-17, floor(largeur/2)-4:floor(largeur/2)+4, t)=0;
        A(floor(hauteur/2)-16, floor(largeur/2)-3:floor(largeur/2)+6, t)=0;
        A(floor(hauteur/2)-15, floor(largeur/2)-5:floor(largeur/2)+5, t)=0;
        A(floor(hauteur/2)-14, floor(largeur/2)-7:floor(largeur/2)+8, t)=0;
        A(floor(hauteur/2)-13, floor(largeur/2)-7:floor(largeur/2)+7, t)=0;
        A(floor(hauteur/2)-12, floor(largeur/2)-9:floor(largeur/2)+9, t)=0;
        A(floor(hauteur/2)-11, floor(largeur/2)-8:floor(largeur/2)+10, t)=0;
        A(floor(hauteur/2)-10, floor(largeur/2)-10:floor(largeur/2)+10, t)=0;
        A(floor(hauteur/2)-9, floor(largeur/2)-11:floor(largeur/2)+9, t)=0;
        A(floor(hauteur/2)-8, floor(largeur/2)-12:floor(largeur/2)+10, t)=0;
        A(floor(hauteur/2)-7, floor(largeur/2)-11:floor(largeur/2)+12, t)=0;
        A(floor(hauteur/2)-6, floor(largeur/2)-12:floor(largeur/2)+13, t)=0;
        A(floor(hauteur/2)-5, floor(largeur/2)-14:floor(largeur/2)+13, t)=0;
        A(floor(hauteur/2)-4, floor(largeur/2)-16:floor(largeur/2)+15, t)=0;
        A(floor(hauteur/2)-3, floor(largeur/2)-17:floor(largeur/2)+16, t)=0;
        A(floor(hauteur/2)-2, floor(largeur/2)-18:floor(largeur/2)+18, t)=0;
        A(floor(hauteur/2)-1, floor(largeur/2)-20:floor(largeur/2)+18, t)=0;
        A(floor(hauteur/2), floor(largeur/2)-19:floor(largeur/2)+20, t)=0;
        A(floor(hauteur/2)+1, floor(largeur/2)-19:floor(largeur/2)+21, t)=0;
        A(floor(hauteur/2)+2, floor(largeur/2)-18:floor(largeur/2)+19, t)=0;
        A(floor(hauteur/2)+3, floor(largeur/2)-16:floor(largeur/2)+19, t)=0;
        A(floor(hauteur/2)+4, floor(largeur/2)-17:floor(largeur/2)+18, t)=0;
        A(floor(hauteur/2)+5, floor(largeur/2)-17:floor(largeur/2)+18, t)=0;
        A(floor(hauteur/2)+6, floor(largeur/2)-16:floor(largeur/2)+16, t)=0;
        A(floor(hauteur/2)+7, floor(largeur/2)-15:floor(largeur/2)+16, t)=0;
        A(floor(hauteur/2)+8, floor(largeur/2)-14:floor(largeur/2)+13, t)=0;
        A(floor(hauteur/2)+9, floor(largeur/2)-11:floor(largeur/2)+12, t)=0;
        A(floor(hauteur/2)+10, floor(largeur/2)-10:floor(largeur/2)+11, t)=0;
        A(floor(hauteur/2)+11, floor(largeur/2)-8:floor(largeur/2)+9, t)=0;
        A(floor(hauteur/2)+12, floor(largeur/2)-8:floor(largeur/2)+10, t)=0;
        A(floor(hauteur/2)+13, floor(largeur/2)-7:floor(largeur/2)+8, t)=0;
        A(floor(hauteur/2)+14, floor(largeur/2)-6:floor(largeur/2)+8, t)=0;
        A(floor(hauteur/2)+15, floor(largeur/2)-6:floor(largeur/2)+6, t)=0;
        A(floor(hauteur/2)+16, floor(largeur/2)-5:floor(largeur/2)+5, t)=0;
        A(floor(hauteur/2)+17, floor(largeur/2)-4:floor(largeur/2)+4, t)=0;
        A(floor(hauteur/2)+18, floor(largeur/2)-3:floor(largeur/2)+3, t)=0;
        A(floor(hauteur/2)+19, floor(largeur/2)-2:floor(largeur/2)+2, t)=0;
        A(floor(hauteur/2)+20, floor(largeur/2)-1:floor(largeur/2)+1, t)=0;
    
        P(floor(hauteur/2)-20, floor(largeur/2), t)=0;
        P(floor(hauteur/2)-19, floor(largeur/2)-2:floor(largeur/2)+1, t)=0;
        P(floor(hauteur/2)-18, floor(largeur/2)-3:floor(largeur/2)+2, t)=0;
        P(floor(hauteur/2)-17, floor(largeur/2)-4:floor(largeur/2)+4, t)=0;
        P(floor(hauteur/2)-16, floor(largeur/2)-3:floor(largeur/2)+6, t)=0;
        P(floor(hauteur/2)-15, floor(largeur/2)-5:floor(largeur/2)+5, t)=0;
        P(floor(hauteur/2)-14, floor(largeur/2)-7:floor(largeur/2)+8, t)=0;
        P(floor(hauteur/2)-13, floor(largeur/2)-7:floor(largeur/2)+7, t)=0;
        P(floor(hauteur/2)-12, floor(largeur/2)-9:floor(largeur/2)+9, t)=0;
        P(floor(hauteur/2)-11, floor(largeur/2)-8:floor(largeur/2)+10, t)=0;
        P(floor(hauteur/2)-10, floor(largeur/2)-10:floor(largeur/2)+10, t)=0;
        P(floor(hauteur/2)-9, floor(largeur/2)-11:floor(largeur/2)+9, t)=0;
        P(floor(hauteur/2)-8, floor(largeur/2)-12:floor(largeur/2)+10, t)=0;
        P(floor(hauteur/2)-7, floor(largeur/2)-11:floor(largeur/2)+12, t)=0;
        P(floor(hauteur/2)-6, floor(largeur/2)-12:floor(largeur/2)+13, t)=0;
        P(floor(hauteur/2)-5, floor(largeur/2)-14:floor(largeur/2)+13, t)=0;
        P(floor(hauteur/2)-4, floor(largeur/2)-16:floor(largeur/2)+15, t)=0;
        P(floor(hauteur/2)-3, floor(largeur/2)-17:floor(largeur/2)+16, t)=0;
        P(floor(hauteur/2)-2, floor(largeur/2)-18:floor(largeur/2)+18, t)=0;
        P(floor(hauteur/2)-1, floor(largeur/2)-20:floor(largeur/2)+18, t)=0;
        P(floor(hauteur/2), floor(largeur/2)-19:floor(largeur/2)+20, t)=0;
        P(floor(hauteur/2)+1, floor(largeur/2)-19:floor(largeur/2)+21, t)=0;
        P(floor(hauteur/2)+2, floor(largeur/2)-18:floor(largeur/2)+19, t)=0;
        P(floor(hauteur/2)+3, floor(largeur/2)-16:floor(largeur/2)+19, t)=0;
        P(floor(hauteur/2)+4, floor(largeur/2)-17:floor(largeur/2)+18, t)=0;
        P(floor(hauteur/2)+5, floor(largeur/2)-17:floor(largeur/2)+18, t)=0;
        P(floor(hauteur/2)+6, floor(largeur/2)-16:floor(largeur/2)+16, t)=0;
        P(floor(hauteur/2)+7, floor(largeur/2)-15:floor(largeur/2)+16, t)=0;
        P(floor(hauteur/2)+8, floor(largeur/2)-14:floor(largeur/2)+13, t)=0;
        P(floor(hauteur/2)+9, floor(largeur/2)-11:floor(largeur/2)+12, t)=0;
        P(floor(hauteur/2)+10, floor(largeur/2)-10:floor(largeur/2)+11, t)=0;
        P(floor(hauteur/2)+11, floor(largeur/2)-8:floor(largeur/2)+9, t)=0;
        P(floor(hauteur/2)+12, floor(largeur/2)-8:floor(largeur/2)+10, t)=0;
        P(floor(hauteur/2)+13, floor(largeur/2)-7:floor(largeur/2)+8, t)=0;
        P(floor(hauteur/2)+14, floor(largeur/2)-6:floor(largeur/2)+8, t)=0;
        P(floor(hauteur/2)+15, floor(largeur/2)-6:floor(largeur/2)+6, t)=0;
        P(floor(hauteur/2)+16, floor(largeur/2)-5:floor(largeur/2)+5, t)=0;
        P(floor(hauteur/2)+17, floor(largeur/2)-4:floor(largeur/2)+4, t)=0;
        P(floor(hauteur/2)+18, floor(largeur/2)-3:floor(largeur/2)+3, t)=0;
        P(floor(hauteur/2)+19, floor(largeur/2)-2:floor(largeur/2)+2, t)=0;
        P(floor(hauteur/2)+20, floor(largeur/2)-1:floor(largeur/2)+1, t)=0;
    end

    for j=1 : hauteur
        for k=1 : largeur
            if typeGamma == 3 && rand()<gamma
                V(j,k,t+1) = V(j,k,t+1) + 1;
            end

            % cas cambriolage
            if V(j,k,t)>0
                for q=1 : V(j,k,t)
                    if rand()<P(j,k,t)
                        E(j,k,t+1)=E(j,k,t+1)+1;

                        if typeGamma == 1
                            x=randi([1 hauteur]);
                            y=randi([1 largeur]);
                            V(x,y,t+1)=V(x,y,t+1)+1;
                        elseif typeGamma == 2
                            x=j+randi([-distApp distApp]);
                            while x>hauteur || x<1
                                x=j+randi([-distApp distApp]);
                            end
                            y=k+randi([-distApp,distApp]);
                            while y>largeur || y<1
                                y=k+randi([-distApp distApp]);
                            end
                            V(x,y,t+1)=V(x,y,t+1)+1;
                        end
                        
                    else
                        % faire se déplacer
                        r = rand();
                        if (1<j && j<hauteur && 1<k && k<largeur)
                            sommeA = A(j-1,k-1,t)+A(j-1,k,t)+A(j-1,k+1,t)+A(j,k-1,t)+A(j,k+1,t)+A(j+1,k-1,t)+A(j+1,k,t)+A(j+1,k+1,t);
                            if r<A(j-1,k-1,t)/sommeA
                                V(j-1,k-1,t+1)=V(j-1,k-1,t+1)+1;
                            elseif r<(A(j-1,k-1,t)+A(j-1,k,t))/sommeA
                                V(j-1,k,t+1)=V(j-1,k,t+1)+1;
                            elseif r<(A(j-1,k-1,t)+A(j-1,k,t)+A(j-1,k+1,t))/sommeA
                                V(j-1,k+1,t+1)=V(j-1,k+1,t+1)+1;
                            elseif r<(A(j-1,k-1,t)+A(j-1,k,t)+A(j-1,k+1,t)+A(j,k-1,t))/sommeA
                                V(j,k-1,t+1)=V(j,k-1,t+1)+1;
                            elseif r<(A(j-1,k-1,t)+A(j-1,k,t)+A(j-1,k+1,t)+A(j,k-1,t)+A(j,k+1,t))/sommeA
                                V(j,k+1,t+1)=V(j,k+1,t+1)+1;
                            elseif r<(A(j-1,k-1,t)+A(j-1,k,t)+A(j-1,k+1,t)+A(j,k-1,t)+A(j,k+1,t)+A(j+1,k-1,t))/sommeA
                                V(j+1,k-1,t+1)=V(j+1,k-1,t+1)+1;
                            elseif r<(A(j-1,k-1,t)+A(j-1,k,t)+A(j-1,k+1,t)+A(j,k-1,t)+A(j,k+1,t)+A(j+1,k-1,t)+A(j+1,k,t))/sommeA
                                V(j+1,k,t+1)=V(j+1,k,t+1)+1;
                            else
                                V(j+1,k+1,t+1)=V(j+1,k+1,t+1)+1;
                            end
                        elseif (j==1 && k==1)
                            % somme des prob de cambriolages des voisins
                            sommeA = A(1,2,t)+A(2,1,t)+A(2,2,t)+condLimPeriod*(A(1,largeur,t)+A(2,largeur,t)+A(hauteur,1,t)+A(hauteur,2,t)+A(hauteur,largeur,t));
                            if r<A(1,2,t)/sommeA
                                V(1,2,t+1)=V(1,2,t+1)+1;
                            elseif r<(A(1,2,t)+A(2,1,t))/sommeA
                                V(2,1,t+1)=V(2,1,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(1,2,t)+A(2,1,t)+A(2,2,t)+A(1,largeur,t))/sommeA
                                    V(1,largeur,t+1)=V(1,largeur,t+1)+1;
                                elseif r<(A(1,2,t)+A(2,1,t)+A(2,2,t)+A(1,largeur,t)+A(2,largeur,t))/sommeA
                                    V(2,largeur,t+1)=V(2,largeur,t+1)+1;
                                elseif r<(A(1,2,t)+A(2,1,t)+A(2,2,t)+A(1,largeur,t)+A(2,largeur,t)+A(hauteur,1,t))/sommeA
                                    V(hauteur,1,t+1)=V(hauteur,1,t+1)+1;
                                elseif r<(A(1,2,t)+A(2,1,t)+A(2,2,t)+A(1,largeur,t)+A(2,largeur,t)+A(hauteur,1,t)+A(hauteur,2,t))/sommeA
                                    V(hauteur,2,t+1)=V(hauteur,2,t+1)+1;
                                else
                                    V(hauteur,largeur,t+1)=V(hauteur,largeur,t+1)+1;
                                end
                            else
                                V(2,2,t+1)=V(2,2,t+1)+1;
                            end
                        elseif (j==1 && 1<k && k<largeur)
                            sommeA = A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t)+A(2,k,t)+A(2,k+1,t)+condLimPeriod*(A(hauteur,k-1,t)+A(hauteur,k,t)+A(hauteur,k+1,t));
                            if r<A(1,k-1,t)/sommeA
                                V(1,k-1,t+1)=V(1,k-1,t+1)+1;
                            elseif r<(A(1,k-1,t)+A(1,k+1,t))/sommeA
                                V(1,k+1,t+1)=V(1,k+1,t+1)+1;
                            elseif r<(A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t))/sommeA
                                V(2,k-1,t+1)=V(2,k-1,t+1)+1;
                            elseif r<(A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t)+A(2,k,t))/sommeA
                                V(2,k,t+1)=V(2,k,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t)+A(2,k,t)+A(2,k+1,t)+A(hauteur,k-1,t))/sommeA
                                    V(hauteur,k-1,t+1)=V(hauteur,k-1,t+1)+1;
                                elseif r<(A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t)+A(2,k,t)+A(2,k+1,t)+A(hauteur,k-1,t)+A(hauteur,k,t))/sommeA
                                    V(hauteur,k,t+1)=V(hauteur,k,t+1)+1;
                                else
                                    V(hauteur,k+1,t+1)=V(hauteur,k+1,t+1)+1;
                                end
                            else
                                V(2,k+1,t+1)=V(2,k+1,t+1)+1;
                            end
                        elseif (j==1 && k==largeur)
                            % somme des prob de cambriolages des voisins
                            sommeA = A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t)+condLimPeriod*(A(1,1,t)+A(2,1,t)+A(1,largeur,t)+A(hauteur,largeur-1,t)+A(hauteur,largeur,t));
                            if r<A(1,largeur-1,t)/sommeA
                                V(1,largeur-1,t+1)=V(1,largeur-1,t+1)+1;
                            elseif r<(A(1,largeur-1,t)+A(2,largeur-1,t))/sommeA
                                V(2,largeur-1,t+1)=V(2,largeur-1,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t))/sommeA
                                    V(2,largeur,t+1)=V(2,largeur,t+1)+1;
                                elseif r<(A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t)+A(1,1,t))/sommeA
                                    V(1,1,t+1)=V(1,1,t+1)+1;
                                elseif r<(A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t)+A(1,1,t)+A(2,1,t))/sommeA
                                    V(2,1,t+1)=V(2,1,t+1)+1;
                                elseif r<(A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t)+A(1,1,t)+A(2,1,t)+A(1,largeur,t))/sommeA
                                    V(1,largeur,t+1)=V(1,largeur,t+1)+1;
                                elseif r<(A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t)+A(1,1,t)+A(2,1,t)+A(1,largeur,t)+A(hauteur,largeur-1,t))/sommeA
                                    V(hauteur,largeur-1,t+1)=A(hauteur,largeur-1,t)+1;
                                else
                                    V(hauteur,largeur,t+1)=V(hauteur,largeur,t+1)+1;
                                end
                            else
                                V(2,largeur,t+1)=V(2,largeur,t+1)+1;
                            end
                        elseif (1<j && j<hauteur && k==largeur)
                            sommeA = A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t)+A(j+1,largeur,t)+condLimPeriod*(A(j-1,1,t)+A(j,1,t)+A(j+1,1,t));
                            if r<A(j-1,largeur-1,t)/sommeA
                                V(j-1,largeur-1,t+1)=V(j-1,largeur-1,t+1)+1;
                            elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t))/sommeA
                                V(j-1,largeur,t+1)=V(j-1,largeur,t+1)+1;
                            elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t))/sommeA
                                V(j,largeur-1,t+1)=V(j,largeur-1,t+1)+1;
                            elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t))/sommeA
                                V(j+1,largeur-1,t+1)=V(j+1,largeur-1,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t)+A(j+1,largeur,t))/sommeA
                                    V(j+1,largeur,t+1)=V(j+1,largeur,t+1)+1;
                                elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t)+A(j+1,largeur,t)+A(j-1,1,t))/sommeA
                                    V(j-1,1,t+1)=V(j-1,1,t+1)+1;
                                elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t)+A(j+1,largeur,t)+A(j-1,1,t)+A(j,1,t))/sommeA
                                    V(j,1,t+1)=V(j,1,t+1)+1;
                                else
                                    V(j+1,1,t+1)=V(j+1,1,t+1)+1;
                                end
                            else
                                V(j+1,largeur,t+1)=V(j+1,largeur,t+1)+1;
                            end
                        elseif (j==hauteur && k==largeur)
                            % somme des prob de cambriolages des voisins
                            sommeA = A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t)+condLimPeriod*(A(hauteur-1,1,t)+A(hauteur,1,t)+A(1,1,t)+A(1,largeur-1,t)+A(1,largeur,t));
                            if r<A(hauteur-1,largeur-1,t)/sommeA
                                V(hauteur-1,largeur-1,t+1)=V(hauteur-1,largeur-1,t+1)+1;
                            elseif r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t))/sommeA
                                V(hauteur-1,largeur,t+1)=V(hauteur-1,largeur,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t))/sommeA
                                    V(hauteur,largeur-1,t+1)=V(hauteur,largeur-1,t+1)+1;
                                elseif r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t)+A(hauteur-1,1,t))/sommeA
                                    V(hauteur-1,1,t+1)=V(hauteur-1,1,t+1)+1;
                                elseif r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t)+A(hauteur-1,1,t)+A(hauteur,1,t))/sommeA
                                    V(hauteur,1,t+1)=V(hauteur,1,t+1)+1;
                                elseif r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t)+A(hauteur-1,1,t)+A(hauteur,1,t)+A(1,1,t))/sommeA
                                    V(1,1,t+1)=V(1,1,t+1)+1;
                                elseif r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t)+A(hauteur-1,1,t)+A(hauteur,1,t)+A(1,1,t)+A(1,largeur-1,t))/sommeA
                                    V(1,largeur-1,t+1)=V(1,largeur-1,t+1)+1;
                                else
                                    V(1,largeur,t+1)=V(1,largeur,t+1)+1;
                                end
                            else
                                V(hauteur,largeur-1,t+1)=V(hauteur,largeur-1,t+1)+1;
                            end
                        elseif (j==hauteur && 1<k && k<largeur)
                            sommeA = A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t)+A(hauteur,k+1,t)+condLimPeriod*(A(1,k-1,t)+A(1,k,t)+A(1,k+1,t));
                            if r<A(hauteur-1,k-1,t)/sommeA
                                V(hauteur-1,k-1,t+1)=V(hauteur-1,k-1,t+1)+1;
                            elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t))/sommeA
                                V(hauteur-1,k,t+1)=V(hauteur-1,k,t+1)+1;
                            elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t))/sommeA
                                V(hauteur-1,k+1,t+1)=V(hauteur-1,k+1,t+1)+1;
                            elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t))/sommeA
                                V(hauteur,k-1,t+1)=V(hauteur,k-1,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t)+A(hauteur,k+1,t))/sommeA
                                    V(hauteur,k+1,t+1)=V(hauteur,k+1,t+1)+1;
                                elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t)+A(hauteur,k+1,t)+A(1,k-1,t))/sommeA
                                    V(1,k-1,t+1)=V(1,k-1,t+1)+1;
                                elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t)+A(hauteur,k+1,t)+A(1,k-1,t)+A(1,k,t))/sommeA
                                    V(1,k,t+1)=V(1,k,t+1)+1;
                                else
                                    V(1,k+1,t+1)=V(1,k+1,t+1)+1;
                                end
                            else
                                V(hauteur,k+1,t+1)=V(hauteur,k+1,t+1)+1;
                            end
                        elseif (j==hauteur && k==1)
                            % somme des prob de cambriolages des voisins
                            sommeA = A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t)+condLimPeriod*(A(1,1,t)+A(1,2,t)+A(1,largeur,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur,t));
                            if r<A(hauteur-1,1,t)/sommeA
                                V(hauteur-1,1,t+1)=V(hauteur-1,1,t+1)+1;
                            elseif r<(A(hauteur-1,1,t)+A(hauteur-1,2,t))/sommeA
                                V(hauteur-1,2,t+1)=V(hauteur-1,2,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t))/sommeA
                                    V(hauteur,2,t+1)=V(hauteur,2,t+1)+1;
                                elseif r<(A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t)+A(1,1,t))/sommeA
                                    V(1,1,t+1)=V(1,1,t+1)+1;
                                elseif r<(A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t)+A(1,1,t)+A(1,2,t))/sommeA
                                    V(1,2,t+1)=V(1,2,t+1)+1;
                                elseif r<(A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t)+A(1,1,t)+A(1,2,t)+A(1,largeur,t))/sommeA
                                    V(1,largeur,t+1)=V(1,largeur,t+1)+1;
                                elseif r<(A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t)+A(1,1,t)+A(1,2,t)+A(1,largeur,t)+A(hauteur-1,largeur,t))/sommeA
                                    V(hauteur-1,largeur,t+1)=V(hauteur-1,largeur,t+1)+1;
                                else
                                    V(hauteur,largeur,t+1)=V(hauteur,largeur,t+1)+1;
                                end
                            else
                                V(hauteur,2,t+1)=V(hauteur,2,t+1)+1;
                            end
                        elseif (1<j && j<hauteur && k==1)
                            sommeA = A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t)+A(j+1,2,t)+condLimPeriod*(A(j-1,largeur,t)+A(j,largeur,t)+A(j+1,largeur,t));
                            if r<A(j-1,1,t)/sommeA
                                V(j-1,1,t+1)=V(j-1,1,t+1)+1;
                            elseif r<(A(j-1,1,t)+A(j-1,2,t))/sommeA
                                V(j-1,2,t+1)=V(j-1,2,t+1)+1;
                            elseif r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t))/sommeA
                                V(j,2,t+1)=V(j,2,t+1)+1;
                            elseif r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t))/sommeA
                                V(j+1,1,t+1)=V(j+1,1,t+1)+1;
                            elseif condLimPeriod == 1
                                if r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t)+A(j+1,2,t))/sommeA
                                    V(j+1,2,t+1)=V(j+1,2,t+1)+1;
                                elseif r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t)+A(j+1,2,t)+A(j-1,largeur,t))/sommeA
                                    V(j-1,largeur,t+1)=V(j-1,largeur,t+1)+1;
                                elseif r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t)+A(j+1,2,t)+A(j-1,largeur,t)+A(j,largeur,t))/sommeA
                                    V(j,largeur,t+1)=V(j,largeur,t+1)+1;
                                else
                                    V(j+1,largeur,t+1)=V(j+1,largeur,t+1)+1;
                                end
                            else
                                V(j+1,2,t+1)=V(j+1,2,t+1)+1;
                            end
                        end
                    end % fin boucle pas de cambriolage (déplacement)
                end
            end

            % Evolution B
            if condLimPeriod == 0
                if (1<j && j<hauteur && 1<k && k<largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k-1,t)+B(j-1,k,t)+B(j-1,k+1,t)+B(j,k-1,t)+B(j,k+1,t)+B(j+1,k-1,t)+B(j+1,k,t)+B(j+1,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==1 && k==1)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/3*(B(j,k+1,t)+B(j+1,k,t)+B(j+1,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==1 && 1<k && k<largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/5*(B(j,k-1,t)+B(j,k+1,t)+B(j+1,k-1,t)+B(j+1,k,t)+B(j+1,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==1 && k==largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/3*(B(j,k-1,t)+B(j+1,k-1,t)+B(j+1,k,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (1<j && j<hauteur && k==largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/5*(B(j-1,k-1,t)+B(j-1,k,t)+B(j,k-1,t)+B(j+1,k-1,t)+B(j+1,k,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==hauteur && k==largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/3*(B(j-1,k-1,t)+B(j-1,k,t)+B(j,k-1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==hauteur && 1<k && k<largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/5*(B(j-1,k-1,t)+B(j-1,k,t)+B(j-1,k+1,t)+B(j,k-1,t)+B(j,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==hauteur && k==1)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/3*(B(j-1,k,t)+B(j-1,k+1,t)+B(j,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (1<j && j<hauteur && k==1)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/5*(B(j-1,k,t)+B(j-1,k+1,t)+B(j,k+1,t)+B(j+1,k,t)+B(j+1,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                end
            else
                if (1<j && j<hauteur && 1<k && k<largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k-1,t)+B(j-1,k,t)+B(j-1,k+1,t)+B(j,k-1,t)+B(j,k+1,t)+B(j+1,k-1,t)+B(j+1,k,t)+B(j+1,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==1 && k==1)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j,k+1,t)+B(j+1,k,t)+B(j+1,k+1,t)+B(1,largeur,t)+B(2,largeur,t)+B(hauteur,1,t)+B(hauteur,2,t)+B(hauteur,largeur,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==1 && 1<k && k<largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j,k-1,t)+B(j,k+1,t)+B(j+1,k-1,t)+B(j+1,k,t)+B(j+1,k+1,t)+B(hauteur,k-1,t)+B(hauteur,k,t)+B(hauteur,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==1 && k==largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j,k-1,t)+B(j+1,k-1,t)+B(j+1,k,t)+B(1,1,t)+B(2,1,t)+B(1,largeur,t)+B(hauteur,largeur-1,t)+B(hauteur,largeur,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (1<j && j<hauteur && k==largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k-1,t)+B(j-1,k,t)+B(j,k-1,t)+B(j+1,k-1,t)+B(j+1,k,t)+B(j-1,1,t)+B(j,1,t)+B(j+1,1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==hauteur && k==largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k-1,t)+B(j-1,k,t)+B(j,k-1,t)+B(hauteur-1,1,t)+B(hauteur,1,t)+B(1,1,t)+B(1,largeur-1,t)+B(1,largeur,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==hauteur && 1<k && k<largeur)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k-1,t)+B(j-1,k,t)+B(j-1,k+1,t)+B(j,k-1,t)+B(j,k+1,t)+B(1,k-1,t)+B(1,k,t)+B(1,k+1,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (j==hauteur && k==1)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k,t)+B(j-1,k+1,t)+B(j,k+1,t)+B(1,1,t)+B(1,2,t)+B(1,largeur,t)+B(hauteur-1,largeur,t)+B(hauteur,largeur,t)) )*(1-omega*dt) + theta*E(j,k,t);
                elseif (1<j && j<hauteur && k==1)
                    B(j,k,t+1)=( (1-eta)*B(j,k,t) + eta/8*(B(j-1,k,t)+B(j-1,k+1,t)+B(j,k+1,t)+B(j+1,k,t)+B(j+1,k+1,t)+B(j-1,largeur,t)+B(j,largeur,t)+B(j+1,largeur,t)) )*(1-omega*dt) + theta*E(j,k,t);
                end
            end
        end
    end
    A(:,:,t+1)=A(:,:,1)+B(:,:,t+1);
    P(:,:,t+1)=p(A(:,:,t+1));
end

toc

% affichage_analyse(hauteur, largeur, nIter, dt, T, E, V, A);
affichage_simple(hauteur, largeur, nIter, dt, T, E, V, A, P);
