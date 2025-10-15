function coin = est_coin(n,m,N1,N2,M1,M2)
    % Détermine si le point (n,m) de T est un coin
    Ref_coins=[1,1;1,M2;N2,M2;N2,M1;N1,1];
    coin=ismember([n,m],Ref_coins,'rows');
end