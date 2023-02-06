function affichage_simple(hauteur, largeur, nIter, dt, T, E, V, A, P)
                %% Calculs et lissages courbes


NbE = zeros(nIter+1);
NbE = floor(sum(sum(E)));
g = gausswin(20);
g = g/sum(g);
NbEsmooth = conv(NbE(1,:), g, 'same');

NbV = zeros(nIter+1);
NbV = floor(sum(sum(V)));
NbVsmooth = conv(NbV(1,:), g, 'same');

Ex = zeros(max(NbE), nIter+1);
Ey = zeros(max(NbE), nIter+1);

finder = find(Ex==0);
for j=finder
    Ex(j)=NaN;
end
finder = find(Ey==0);
for j=finder
    Ey(j)=NaN;
end

for t=1:nIter+1
    compteur=1;
    for j=1 : hauteur
        for k=1 : largeur
            if E(j,k,t)~=0
                Ex(compteur,t)=k;
                Ey(compteur,t)=j;
                compteur = compteur+1;
            end
        end
    end
end

Vx = zeros(max(NbV), nIter+1);
Vy = zeros(max(NbV), nIter+1);

finder = find(Vx==0);
for j=finder
    Vx(j)=NaN;
end
finder = find(Vy==0);
for j=finder
    Vy(j)=NaN;
end

for t=1:nIter+1
    compteur=1;
    for j=1 : hauteur
        for k=1 : largeur
            if V(j,k,t)~=0
                Vx(compteur,t)=k;
                Vy(compteur,t)=j;
                compteur = compteur+1;
            end
        end
    end
end


                %% Affichage

fig1=figure();
fig1.WindowState='maximized';
colormap("jet")

subplot(2,3,1)
i1 = imagesc(A(:,:,1));
axis image
axis off
caxis([min(min(min(A))) max(max(max(A)))/100])
c1=colorbar('South');
c1.Color=[1 1 1];
title('Attractivité')

subplot(2,3,2)
i2 = plot(Vx(:,1), Vy(:,1),'b.');
set(gca,'xtick',[])
set(gca,'ytick',[])
axis image
axis([0 largeur 0 hauteur])
title('Cambrioleurs')

subplot(2,3,3)
plot(T,NbVsmooth(1,:));
axis tight
title('Nombre de cambrioleurs')
xlabel('Temps (en jours)')
ylabel('Nombre de cambrioleurs')

subplot(2,3,4)
i4 = imagesc(P(:,:,1));
axis image
axis off
caxis([min(min(min(P))) max(max(max(P)))/10])
c4=colorbar('South');
c4.Color=[1 1 1];
title('Probabilité')

subplot(2,3,5)
i5 = plot(Ex(:,1), Ey(:,1),'b.');
axis image
axis([0 largeur 0 hauteur])
set(gca,'xtick',[])
set(gca,'ytick',[])
title('Cambriolages')

subplot(2,3,6)
plot(T,NbEsmooth(1,:));
axis tight
title('Nombre de cambriolages')
xlabel('Temps (en jours)')
ylabel('Nombre de cambriolages')

drawnow

sgtitle('Jour n°1');

pause(5)

% Mise à jour de l'affichage pour chaque temps
for t=2:nIter
    
    if(mod(t*dt,1)==0)
        sgtitle(strcat('Jour n°',num2str(floor(t*dt))));
    end

    set(i1, 'CData', A(:,:,t))

    set(i2, 'XData', Vx(:,t), 'YData', Vy(:,t))

    set(i4, 'CData', P(:,:,t))

    set(i5, 'XData', Ex(:,t), 'YData', Ey(:,t))

    drawnow
end

end