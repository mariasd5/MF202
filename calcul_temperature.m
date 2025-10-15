function T1= calcul_temperature(T0, Refs,N1,M1, M2, N2,tau,k,dl,h_H2,h_gaz,T_h,T_air,T_gaz,epsa)
% Prend les températures au temps t et renvoient celles au temps t+1
    T1 = T0;  % Définition du tableau de sortie

    for m=1:M2 % On parcourt le domaine sans les bords et on calcule T1
        for n=1:N2 
            if est_coin(n,m,N1,N2,M1,M2)==1 %detection de coin à éviter
                % ne rien faire
            elseif Refs(n,m)==0 % itérieur
                T1(n,m)=T0(n,m)+4*tau*(T0(n+1,m)+T0(n,m+1)+T0(n-1,m)+T0(n,m-1)-4*T0(n,m));

            elseif Refs(n,m)==1 % bord haut rayonnant
                T1(n,m)=T0(n,m)+tau*(2*T0(n,m+1)+T0(n+1,m)+T0(n-1,m)-4*T0(n,m))+(dl*tau*epsa/k)*(T_air^4 - T0(n,m)^4);

            elseif Refs(n,m)==2 % bord long convectif H2
                T1(n,m)=T0(n,m)+tau*(2*T0(n,m+1)+T0(n-1,m)+T0(n,m-1)-4*T0(n,m))+(dl*tau*epsa/k)*(T_h^4 - T0(n,m)^4)+(tau*h_H2/k)*(T_h-T0(n,m));

            elseif Refs(n,m)==3 % bord court convectif H2
                T1(n,m)=T0(n,m) + tau*(2*T0(n,m+1)+T0(n-1,m)+T0(n+1,m)-4*T0(n,m)) + (dl*tau*epsa/k)*(T_h^4-T0(n,m)^4) + (tau*h_H2/k)*(T_h-T0(n,m));

            elseif Refs(n,m)==4 % bord symétrique i.e. adiabatique
                T1(n,m)=T0(n,m) + tau*(2*T0(n-1,m)+T0(n,m+1)+T0(n,m-1)-4*T0(n,m));

            elseif Refs(n,m)==5 %  bord chaud
                T1(n,m)=T0(n,m) + tau*(2*T0(n,m-1)+T0(n+1,m)+T0(n-1,m)-4*T0(n,m)) + (dl*tau*epsa/k)*(T_gaz^4-T0(n,m)^4) + (tau*h_gaz/k)*(T_gaz-T0(n,m));
            
            elseif Refs(n,m)==6 % long bord symétrique
                T1(n,m) = T0(n,m) + tau*(2*T0(n+1,m)+T0(n,m+1)+T0(n,m-1)-4*T0(n,m));
            end            
        end
    end
end