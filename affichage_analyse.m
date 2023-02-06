function affichage_analyse(hauteur, largeur, nIter, dt, T, E, V, A);
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

Amean = mean(sum(sum(A,1),1));
Abin = zeros(hauteur, largeur, nIter+1);

for t=1:nIter+1
    Abin(:,:,t) = imbinarize(floor(A(:,:,t)/(mean(A(:,:,t),'all')*2)));
end
Abin = ~imclose(~Abin,strel('disk',5));

labeled = zeros(hauteur, largeur, nIter+1);
Hotspots = zeros(30,nIter+1);
for t=1 : nIter+1
    labeled(:,:,t) = bwlabel(Abin(:,:,t),4);
    HotspotsInter= regionprops(labeled(:,:,t),'Area');
    for j=1 : length(HotspotsInter)
        Hotspots(j,t)=[HotspotsInter(j).Area];
    end
end

SpotsSize=sum(Hotspots,1);


                %% Affichage

fig1=figure();
fig1.WindowState='maximized';
colormap("jet")

subplot(2,5,1)
i1 = plot(Vx(:,1), Vy(:,1),'b.');
set(gca,'xtick',[])
set(gca,'ytick',[])
axis image
axis([0 largeur 0 hauteur])
title('Cambrioleurs')

subplot(2,5,2)
i2 = plot(Ex(:,1), Ey(:,1),'b.');
axis image
axis([0 largeur 0 hauteur])
set(gca,'xtick',[])
set(gca,'ytick',[])
title('Cambriolages')

subplot(2,5,3)
i3 = imagesc(sum(A,3)./nIter);
axis image
axis off
c3=colorbar('South');
c3.Color=[1 1 1];
title('Attractivité moyennée sur le temps')

subplot(2,5,4)
i4 = imagesc(A(:,:,1));
axis image
axis off
caxis([min(min(min(A))) (max(max(max(A)))/100)])
c4=colorbar('South');
c4.Color=[1 1 1];
title('Attractivité')

subplot(2,5,5)
i5 = imshow(Abin(:,:,1));
axis image
axis off
title("Points chauds d'attractivité")

subplot(2,5,6)
plot(T,NbVsmooth(1,:));
axis tight
title('Nombre de cambrioleurs')
xlabel('Temps (en jours)')
ylabel('Nombre de cambrioleurs')

subplot(2,5,7)
plot(T,NbEsmooth(1,:));
axis tight
title('Nombre de cambriolages')
xlabel('Temps (en jours)')
ylabel('Nombre de cambriolages')

subplot(2,5,8)
plot(T,Amean(1,:))
axis tight
title('Attractivité moyenne')
xlabel('Temps (en jours)')
ylabel('Attractivité moyenne')

subplot(2,5,9)
i9 = histogram(Hotspots(:,1),'BinEdges', 1:(max(max(Hotspots))-100)/5:max(max(Hotspots)));
ylim([0 10])
title('Quantité de points chauds par taille')
xlabel('Taille des points chauds')
ylabel('Nombre de points chauds')

subplot(2,5,10)
plot(T,SpotsSize)
axis tight
title('Aire totale des points chauds')
xlabel('Temps (en jours)')
ylabel('Aire en unité²')

drawnow

sgt = sgtitle('Jour n°1');

% pause(5)

% Mise à jour de l'affichage pour chaque temps
for t=2:nIter

    if(mod(t*dt,1)==0)
        sgtitle(strcat('Jour n°',num2str(floor(t*dt))));
    end

    set(i1, 'XData', Vx(:,t), 'YData', Vy(:,t))

    set(i2, 'XData', Ex(:,t), 'YData', Ey(:,t))

    set(i4, 'CData', A(:,:,t))

    set(i5, 'CData', Abin(:,:,t))

    set(i9, 'Data', Hotspots(:,t))

    drawnow
end

end