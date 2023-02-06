function [disp] = dispersion(Vp,j,k,largeur)
 disp = Vp;
 if j>7 && j<largeur-7 && k>7 && k<largeur-7  % Au centre
    for i = j-7 : j+7
         for l = k-7 : k+7
            if disp (i,l) == 1
               disp (i,l) = 0;
            end
        end
    end
 end
 
 
 if j<7 && k<7                              % Aux bords      
     for i = 1 : j+7                
         for l = 1 : k+7
            if disp (i,l) == 1
               disp (i,l) = 0;
            end
        end
     end
elseif j<7 && k>largeur-7
     for i = 1 : j+7
         for l = k-7 : largeur
            if disp (i,l) == 1
               disp (i,l) = 0;
            end
        end
     end
 elseif j>largeur-7 &&  k<7
     for i = j-7 : largeur
         for l = 1 : k+7
            if disp (i,l) == 1
               disp (i,l) = 0;
            end
        end
     end
 elseif j>largeur-7 && k>largeur-7
     for i = j-7 : largeur
         for l = k-7 : largeur
            if disp (i,l) == 1
               disp (i,l) = 0;
            end
        end
     end
%  elseif j<7                              % Aux bords aussi    
%      for i = 1 : j+7                
%          for l = k-6 : k+7
%             if disp (i,l) == 1
%                disp (i,l) = 0;
%             end
%         end
%      end
% elseif k>largeur-7
%      for i = j-7 : j+7
%          for l = k-7 : largeur
%             if disp (i,l) == 1
%                disp (i,l) = 0;
%             end
%         end
%      end
%  elseif j>largeur-7
%      for i = j-7 : largeur
%          for l = k-7 : k+7
%             if disp (i,l) == 1
%                disp (i,l) = 0;
%             end
%         end
%      end
%  elseif k<7
%      for i = j-6 : j+7
%          for l = 1 : k+7
%             if disp (i,l) == 1
%                disp (i,l) = 0;
%             end
%         end
%      end
%  end
 

     
end