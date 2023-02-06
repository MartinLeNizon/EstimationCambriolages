                %% Programme principal

% Nombre de cambrioleurs constant
% Réapparition dans le quartier cambriolé

clear, close all

tic

                %% Déclarations des variables

largeur=128; hauteur=128;

t0=0; tf=100; dt=1/24; nIter=(tf-t0)/dt; T=t0:dt:tf;

gamma=5;                % taux cambrioleurs 30
distApp = 10;           % distance max de réapparition des cambrioleurs
omega=0.0001;           % taux décroissance 0.3
A0=1/100;               % attractivité init
eta=0.5;                % dispersion (0<eta<1)
theta=30;               % influence précédents cambriolages

                %% Déclaration des fonctions & des matrices

p = @(x) 1-exp(-x*dt);                              % prob d'un cambriolage

A = zeros(hauteur, largeur, nIter+1);               % attractivité
A(:,:,1)=(rand(hauteur,largeur)./2 + 3/4)*1/30;

B = zeros(hauteur, largeur, nIter+1);
P(:,:,1) = p(A(:,:,1));                             % probabilités de cambriolages
E = zeros(hauteur, largeur, nIter+1);               % nombre de cambriolages
V = zeros(hauteur, largeur, nIter+1);               % nombre de cambrioleurs



                %% Pose des premiers cambrioleurs

for j=1 : hauteur
    for k=1 : largeur
        if rand()<gamma/(largeur*hauteur)
            V(j,k,1)=1;
        end
    end
end


                %% Boucle d'itération

for t=1 : nIter
    for j=1 : hauteur
        for k=1 : largeur
            % cas cambriolage
            if V(j,k,t)>0
                for q=1 : V(j,k,t)
                    if rand()<P(j,k,t)
                        E(j,k,t+1)=E(j,k,t+1)+1;

                        x=j+randi([-distApp distApp]);
                        while x>hauteur || x<1
                            x=j+randi([-distApp distApp]);
                        end
                        y=k+randi([-distApp,distApp]);
                        while y>largeur || y<1
                            y=k+randi([-distApp distApp]);
                        end
                        V(x,y,t+1)=V(x,y,t+1)+1;
                        
                    else
                        % faire se déplacer
                        r = rand();
                        if (1<j && j<hauteur && 1<k && k<largeur)
                            % somme des prob de cambriolages des voisins
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
                            sommeA = A(1,2,t)+A(2,1,t)+A(2,2,t);
                            if r<A(1,2,t)/sommeA
                                V(1,2,t+1)=V(1,2,t+1)+1;
                            elseif r<(A(1,2,t)+A(2,1,t))/sommeA
                                V(2,1,t+1)=V(2,1,t+1)+1;
                            else
                                V(2,2,t+1)=V(2,2,t+1)+1;
                            end
                        elseif (j==1 && 1<k && k<largeur)
                            sommeA = A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t)+A(2,k,t)+A(2,k+1,t);
                            if r<A(1,k-1,t)/sommeA
                                V(1,k-1,t+1)=V(1,k-1,t+1)+1;
                            elseif r<(A(1,k-1,t)+A(1,k+1,t))/sommeA
                                V(1,k+1,t+1)=V(1,k+1,t+1)+1;
                            elseif r<(A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t))/sommeA
                                V(2,k-1,t+1)=V(2,k-1,t+1)+1;
                            elseif r<(A(1,k-1,t)+A(1,k+1,t)+A(2,k-1,t)+A(2,k,t))/sommeA
                                V(2,k,t+1)=V(2,k,t+1)+1;
                            else
                                V(2,k+1,t+1)=V(2,k+1,t+1)+1;
                            end
                        elseif (j==1 && k==largeur)
                            sommeA = A(1,largeur-1,t)+A(2,largeur-1,t)+A(2,largeur,t);
                            if r<A(1,largeur-1,t)/sommeA
                                V(1,largeur-1,t+1)=V(1,largeur-1,t+1)+1;
                            elseif r<(A(1,largeur-1,t)+A(2,largeur-1,t))/sommeA
                                V(2,largeur-1,t+1)=V(2,largeur-1,t+1)+1;
                            else
                                V(2,largeur,t+1)=V(2,largeur,t+1)+1;
                            end
                        elseif (1<j && j<hauteur && k==largeur)
                            sommeA = A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t)+A(j+1,largeur,t);
                            if r<A(j-1,largeur-1,t)/sommeA
                                V(j-1,largeur-1,t+1)=V(j-1,largeur-1,t+1)+1;
                            elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t))/sommeA
                                V(j-1,largeur,t+1)=V(j-1,largeur,t+1)+1;
                            elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t))/sommeA
                                V(j,largeur-1,t+1)=V(j,largeur-1,t+1)+1;
                            elseif r<(A(j-1,largeur-1,t)+A(j-1,largeur,t)+A(j,largeur-1,t)+A(j+1,largeur-1,t))/sommeA
                                V(j+1,largeur-1,t+1)=V(j+1,largeur-1,t+1)+1;
                            else
                                V(j+1,largeur,t+1)=V(j+1,largeur,t+1)+1;
                            end
                        elseif (j==hauteur && k==largeur)
                            sommeA = A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t)+A(hauteur,largeur-1,t);
                            if r<A(hauteur-1,largeur-1,t)/sommeA
                                V(hauteur-1,largeur-1,t+1)=V(hauteur-1,largeur-1,t+1)+1;
                            elseif r<(A(hauteur-1,largeur-1,t)+A(hauteur-1,largeur,t))/sommeA
                                V(hauteur-1,largeur,t+1)=V(hauteur-1,largeur,t+1)+1;
                            else
                                V(hauteur,largeur-1,t+1)=V(hauteur,largeur-1,t+1)+1;
                            end
                        elseif (j==hauteur && 1<k && k<largeur)
                            sommeA = A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t)+A(hauteur,k+1,t);
                            if r<A(hauteur-1,k-1,t)/sommeA
                                V(hauteur-1,k-1,t+1)=V(hauteur-1,k-1,t+1)+1;
                            elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t))/sommeA
                                V(hauteur-1,k,t+1)=V(hauteur-1,k,t+1)+1;
                            elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t))/sommeA
                                V(hauteur-1,k+1,t+1)=V(hauteur-1,k+1,t+1)+1;
                            elseif r<(A(hauteur-1,k-1,t)+A(hauteur-1,k,t)+A(hauteur-1,k+1,t)+A(hauteur,k-1,t))/sommeA
                                V(hauteur,k-1,t+1)=V(hauteur,k-1,t+1)+1;
                            else
                                V(hauteur,k+1,t+1)=V(hauteur,k+1,t+1)+1;
                            end
                        elseif (j==hauteur && k==1)
                            sommeA = A(hauteur-1,1,t)+A(hauteur-1,2,t)+A(hauteur,2,t);
                            if r<A(hauteur-1,1,t)/sommeA
                                V(hauteur-1,1,t+1)=V(hauteur-1,1,t+1)+1;
                            elseif r<(A(hauteur-1,1,t)+A(hauteur-1,2,t))/sommeA
                                V(hauteur-1,2,t+1)=V(hauteur-1,2,t+1)+1;
                            else
                                V(hauteur,2,t+1)=V(hauteur,2,t+1)+1;
                            end
                        elseif (1<j && j<hauteur && k==1)
                            sommeA = A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t)+A(j+1,2,t);
                            if r<A(j-1,1,t)/sommeA
                                V(j-1,1,t+1)=V(j-1,1,t+1)+1;
                            elseif r<(A(j-1,1,t)+A(j-1,2,t))/sommeA
                                V(j-1,2,t+1)=V(j-1,2,t+1)+1;
                            elseif r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t))/sommeA
                                V(j,2,t+1)=V(j,2,t+1)+1;
                            elseif r<(A(j-1,1,t)+A(j-1,2,t)+A(j,2,t)+A(j+1,1,t))/sommeA
                                V(j+1,1,t+1)=V(j+1,1,t+1)+1;
                            else
                                V(j+1,2,t+1)=V(j+1,2,t+1)+1;
                            end
                        end
                    end % fin boucle pas de cambriolage (déplacement)
                end
            end

            % Evolution B
            
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
        end
    end
    A(:,:,t+1)=A(:,:,1)+B(:,:,t+1);
    P(:,:,t+1)=p(A(:,:,t+1));
end

toc

% affichage_analyse(hauteur, largeur, nIter, dt, T, E, V, A);
affichage_simple(hauteur, largeur, nIter, dt, T, E, V, A, P);