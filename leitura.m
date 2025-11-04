function M = parseStringToNumeric(x)
    if isempty(x)
        M = [];
        return
    end

    % Se for cell com várias entradas, aplica recursivamente e retorna cell array
    if iscell(x) && numel(x) > 1
        M = cellfun(@parseStringToNumeric, x, 'UniformOutput', false);
        return
    end

    % Se for cell scalar, pega o conteúdo
    if iscell(x)
        x = x{1};
    end

    % Se agora for numeric  retorna
    if isnumeric(x)
        M = x;
        return
    end

    % Converte para char e limpa espaços
    s = strtrim(char(x));

    s = strrep(s, ',','.' );                % vírgula decimal -> ponto (se usar vírgula)
    s = regexprep(s, '\]\s*\[', ';');       % "][", "] [" -> ';' (separa linhas)
    s = regexprep(s, '[\[\]]', '');         % remove todos os colchetes
    s = regexprep(s, '[^0-9\+\-\.\s;eE]', '');
    s = regexprep(s, '\s+', ' ');           % compacta espaços
    s = strtrim(s);

    % Tenta converter
    if isempty(s)
        M = [];
        return
    end

    M = str2num(s); 
    if isempty(M)
        M = [];
    end
end

% Ideia: Usar valores de um excel e mudar as linhas conforme situação de
% treliça que quieramos analisar
T = readtable('data.xlsx'); %Biblioteca para leitura de arquivos
DataLine=1; % Escolhendo a linha

E = T{DataLine,1};
A = T{DataLine,2};

n_elementos = T{DataLine,3};
n_gdl = T{DataLine,4};

relacoes_nos = cell2mat(T{DataLine,5});
relacoes_nos = parseStringToNumeric(relacoes_nos);

gdl_nos = cell2mat(T{DataLine,6});
gdl_nos = parseStringToNumeric(gdl_nos);

pos_nos =cell2mat(T{DataLine,7});
pos_nos = parseStringToNumeric(pos_nos);

gdl_fixos = cell2mat(T{DataLine,8});
gdl_fixos = parseStringToNumeric(gdl_fixos);

forcas = cell2mat(T{DataLine,9});
forcas = parseStringToNumeric(forcas);
valor_forca = forcas(1, 2);

disp(relacoes_nos);
disp(gdl_nos);
disp(pos_nos);
disp(gdl_fixos);
disp(forcas);