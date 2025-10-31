function [ki] = create_ki(sint, cost)
% CREATE_KI Cria a matriz de rigidez 2x2 para cada elemento (conjunto de 2
% nós)
% Arguments:
%    seno(theta)
%    cos(theta)
    ki = [ [cost^2      cost*sint   -cost^2     -cost*sint]
           [cost*sint   sint^2      -cost*sint  -sint^2   ]
           [-cost^2     -cost*sint  cost^2      cost*sint ]
           [-cost*sint  -sint^2     cost*sint   sint^2    ]];
end