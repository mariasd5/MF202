function T1 = modifie_coin(T1,T0,N1,N2,M1,M2,tau,dl,epsa,k,T_gaz,h_gaz,h_h,T_h)
    % Calcule la valeur de la température sur un coin du maillage
    Ref_coins=[1,1;1,M2;N2,M2;N2,M1;N1,1];


    for i=1:5
        n=Ref_coins(i,1);
        m=Ref_coins(i,2);
        if n==1
            T1(n,m)=T0(n,m)+tau*(T0(n+1,m)-T0(n,m));
        end
        if n>1
            T1(n,m)=T0(n,m)+tau*(T0(n-1,m)-T0(n,m));
        end
        if m<M2
            T1(n,m)=T0(n,m)+tau*(T0(n,m+1)-T0(n,m));
        end
        if m==M2 % convection gaz chaud non négligeable ici
            T1(n,m)=T0(n,m)+tau*(T0(n,m-1)-T0(n,m))+ (dl*tau*epsa/k)*(T_gaz^4-T0(n,m)^4) + (tau*h_gaz/k)*(T_gaz-T0(n,m));
        end
        if i==4 % convection H2 non négligeable ici
            T1(n,m)=T0(n,m)+ (tau*h_h/k)*(T_h-T0(n,m));
        end
    end
end