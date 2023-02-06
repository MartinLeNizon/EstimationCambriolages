function G = detection_hotspot(largeur,hauteur,M,tauxdetection)
clear ind

%binarisation de la matrice
B = zeros(hauteur,largeur);
for i = 1:hauteur
    for j = 1:largeur
        if ( M(i,j) > tauxdetection)
            B(i,j) = 1;
        end
    end
end

%détection de groupe 
G = zeros(hauteur,largeur);
ind = 1;

for i = 1:hauteur
    for j = 1:largeur
        
        %boucle de voisinnage
        if( (B(i,j) == 1) && (G(i,j) == 0) )                                                     %si le site est chaud et non indexé
            G(i,j) = ind;
            count = 1;
            
            while(count~=0)                                                                      %convertit les voisins chauds non annexés tant qu'il en reste 
                X = find(G==ind);
                count = 0;
                for t = 1:size(X)
                    if(X(t)~=1)
                        if (B(X(t)-1) == 1) && (G(X(t)-1) == 0)
                            count = count+1;
                            G(X(t)-1)=ind;
                        end
                    end
                    if (X(t)~=largeur*hauteur)
                        if (B(X(t)+1) == 1) && (G(X(t)+1) == 0)
                            count = count+1;
                            G(X(t)+1) = ind;
                        end
                    end
                    if(X(t)>hauteur)   
                        if (B(X(t)-hauteur) == 1) && (G(X(t)-hauteur) == 0)
                            count = count+1;
                            G(X(t)-hauteur) = ind;
                        end
                    end
                    if(X(t)<largeur*hauteur-hauteur)
                        if (B(X(t)+hauteur) == 1) && (G(X(t)+hauteur) == 0)
                            count = count+1;
                            G(X(t)+hauteur) = ind;
                        end
                    end
                end
            end
            ind = ind+1;
        end
    end
end


%tentative de taille minimum à avoir pour un hotspot
tailleminimum = 25;
for i = 1:ind                       %pour chaque indexation
    X = find(G==i);                 %on regarde les indices linéaires de tous ceux indexés
    if (size(X,1)<tailleminimum)    %si il n'y en a pas assez
        for j = 1:size(X,1)         %on les supprime
            G(X(j)) = 0;
        end
        
    end
end 



%nota bene
%le sens de parcours unidimensionnel implique une considération différente des voisins qui serait presque 
%équivalente à des conditions limites périodiques


end