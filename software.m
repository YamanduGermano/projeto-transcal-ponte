clear
close
clc

%% Dados
E = 210e9;
A = 2e-4;

n_elementos = 3;
n_gdl = n_elementos*2;

relacoes_nos = [
    [1 2]
    [2 3]
    [3 1]
];

gdl_nos = [
    [1 2]
    [3 4]
    [5 6]
];

pos_nos = [
    [0   0  ]
    [0   0.4]
    [0.3 0.4]
];

gdl_fixos = [1 3 4];

forcas = [
    [3 150 -100]
]; % Em [nó fx fy]

%% Cálculo da matriz global
kg = zeros(n_gdl, n_gdl);

for i = 1:n_elementos
    x1 = pos_nos(relacoes_nos(i,1) , 1);
    y1 = pos_nos(relacoes_nos(i,1) , 2);

    x2 = pos_nos(relacoes_nos(i,2) , 1);
    y2 = pos_nos(relacoes_nos(i,2) , 2);
    L = sqrt((x2-x1)^2 + (y2-y1)^2);
    
    cost = (x2-x1)/L;
    sint = (y2-y1)/L;
    
    ki = create_ki(sint, cost);
    gdls_elemento = [gdl_nos(relacoes_nos(i,1),:) gdl_nos(relacoes_nos(i,2),:)];
    kg(gdls_elemento, gdls_elemento) = kg(gdls_elemento, gdls_elemento) + E*A/L*ki;
end

disp('Matriz de rigidez global:')
disp(kg)

%% Cálculo das forças com casos de contorno

F = zeros(n_gdl,1);

% Criar lista de forças
for i = 1:size(forcas,1)
    F(gdl_nos(forcas(i,1) , 1)) = F(gdl_nos(forcas(i,1) , 1)) + forcas(i,2);% força em x no nó i
    F(gdl_nos(forcas(i,1) , 2)) = F(gdl_nos(forcas(i,1) , 2)) + forcas(i,3); % força em y no nó i
end

disp('Forças do sistema:')
disp(F)

% Retirar as linhas e colunas dos casos de contorno.
kg_cont = kg(~ismember( 1:n_gdl, gdl_fixos), ~ismember( 1:n_gdl, gdl_fixos));
f_cont = F(~ismember( 1:n_gdl, gdl_fixos));

% Calcular os deslocamentos dos pontos
% Utilizando método iterativo de Gauss-Seidel para cálculo da inversa da
% matriz.
u_contorno = u_gs(kg_cont,f_cont);

% Juntar à lista global de deslocamentos
U = zeros(n_gdl,1);
U( ~ismember( 1:n_gdl, gdl_fixos)) = u_contorno;

% Calcular as forças de reação.
F = kg*U;

disp('Forças com reações calculadas:')
disp(F)

disp('Deslocamentos dos nós:')
disp(U)