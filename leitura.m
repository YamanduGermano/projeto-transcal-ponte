jsonFilePath = 'dados.json'; 
jsonText = fileread(jsonFilePath); 

dados = jsondecode(jsonText);

E=dados.elasticidade;
A=dados.area;
n_elementos = dados.n_elementos;
n_gdl = dados.n_gdl;

relacoes_nos = dados.rel_nos;
gdl_nos = dados.gdl_nos;
pos_nos = dados.pos_nos;
gdl_fixos = dados.gdl_fixos;
forcas = dados.forcas;