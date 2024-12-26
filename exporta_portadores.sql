-- Exporta títulos ativos para um portador específico
SELECT 
    1,
    login,
    cpf_cnpj,
    formapag,
    tipo,
    descricao,
    processamento,
    datavenc,
    datapag,
    titulo,
    nossonum,
    valor,
    valorpag,
    valorger,
    geranfe,
    codigo_carne,
    linhadig,
    '',
    status,
    calculado,
    numconta,
    remvalor
FROM vtab_titulos 
WHERE deltitulo = 0 
  AND numconta = {portador} 
ORDER BY codigo_carne, titulo 
INTO OUTFILE '/tmp/mkauth-titulos-{portador}.csv' 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

-- Exporta títulos removidos para um portador específico
SELECT 
    1,
    login,
    cpf_cnpj,
    formapag,
    tipo,
    descricao,
    processamento,
    datavenc,
    datapag,
    titulo,
    nossonum,
    valor,
    valorpag,
    valorger,
    geranfe,
    codigo_carne,
    linhadig,
    '',
    status,
    calculado,
    numconta,
    remvalor
FROM vtab_titulos 
WHERE deltitulo = 1 
  AND numconta = {portador} 
ORDER BY codigo_carne, titulo 
INTO OUTFILE '/tmp/mkauth-titulos-removidos-{portador}.csv' 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

-- Visualiza todos os registros da tabela 'sis_boleto'
SELECT * 
FROM sis_boleto 
\G;

-- Visualiza todos os registros da tabela 'sis_provedor'
SELECT * 
FROM sis_provedor 
\G;
