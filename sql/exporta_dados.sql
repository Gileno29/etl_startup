SELECT 
    c.id AS cliente_id,
    r.username AS login_pppoe,
    c.pessoa,
    c.nome,
    1,
    c.cpf_cnpj,
    10,
    15,
    rg,
    '' AS profissao,
    '' AS sexo,
    c.nascimento,
    '' AS fantasia,
    '' AS contato,
    c.endereco,
    c.numero,
    c.complemento,
    c.bairro,
    c.cep,
    c.estado,
    c.cidade,
    c.celular,
    c.celular2,
    c.email,
    c.obs,
    c.cadastro,
    c.cadastro,
    '' AS servidor,
    c.plano,
    '0' AS valor,
    c.tipo,
    c.ip,
    c.ip,
    c.mac,
    c.venc,
    c.desconto,
    c.acrescimo,
    '' AS transmissor,
    '' AS receptor,
    c.comodato,
    c.isento,
    c.cli_ativado,
    c.bloqueado,
    r.value AS senha,
    p.veldown AS plano_download,
    p.velup AS plano_upload,
    p.valor AS plano_valor,
    c.conta,
    c.fone,
    c.login,
    c.endereco_res,
    c.numero_res,
    c.bairro_res,
    c.cidade_res,
    c.cep_res,
    c.estado_res,
    c.complemento_res,
    c.nome_pai,
    c.nome_mae,
    c.naturalidade,
    c.dot_ref AS ponto_referencia
FROM sis_cliente c
INNER JOIN sis_plano p ON (p.nome = c.plano)
INNER JOIN radcheck r ON (r.login = c.login AND r.attribute = 'Password' AND r.login NOT LIKE '%:%')
WHERE c.cli_ativado = 's'
INTO OUTFILE '/tmp/mkauth-clientes-ativados.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


SELECT 
    c.id,
    c.login,
    c.pessoa,
    c.nome,
    1,
    c.cpf_cnpj,
    10,
    15,
    rg,
    '' AS profissao,
    '' AS sexo,
    c.nascimento,
    '' AS fantasia,
    '' AS contato,
    c.endereco,
    c.numero,
    c.complemento,
    c.bairro,
    c.cep,
    c.estado,
    c.cidade,
    c.celular,
    c.celular2,
    c.email,
    c.obs,
    c.cadastro,
    c.cadastro,
    '' AS servidor,
    c.plano,
    '0' AS valor,
    c.tipo,
    c.ip,
    c.ip,
    c.mac,
    c.venc,
    c.desconto,
    c.acrescimo,
    '' AS transmissor,
    '' AS receptor,
    c.comodato,
    c.isento,
    c.cli_ativado,
    c.bloqueado,
    c.senha,
    p.veldown AS plano_download,
    p.velup AS plano_upload,
    p.valor AS plano_valor,
    c.conta,
    c.fone,
    c.login,
    c.endereco_res,
    c.numero_res,
    c.bairro_res,
    c.cidade_res,
    c.cep_res,
    c.estado_res,
    c.complemento_res,
    c.nome_pai,
    c.nome_mae,
    c.naturalidade,
    c.dot_ref AS ponto_referencia
FROM sis_cliente c
INNER JOIN sis_plano p ON (p.nome = c.plano)
WHERE c.cli_ativado = 's'
INTO OUTFILE '/tmp/mkauth-clientes-ativados2.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


-- Exportar clientes ativados sem plano associado
SELECT 
    c.id,
    c.login,
    c.pessoa,
    c.nome,
    1,
    c.cpf_cnpj,
    10,
    15,
    rg,
    '' AS profissao,
    '' AS sexo,
    c.nascimento,
    '' AS fantasia,
    '' AS contato,
    c.endereco,
    c.numero,
    c.complemento,
    c.bairro,
    c.cep,
    c.estado,
    c.cidade,
    c.celular,
    c.celular2,
    c.email,
    c.obs,
    c.cadastro,
    c.cadastro,
    '' AS servidor,
    (
        SELECT groupname FROM radusergroup 
        WHERE username = c.login LIMIT 1
    ) AS plano,
    '0' AS valor,
    c.tipo,
    c.ip,
    c.ip,
    c.mac,
    c.venc,
    c.desconto,
    c.acrescimo,
    '' AS transmissor,
    '' AS receptor,
    c.comodato,
    c.isento,
    c.cli_ativado,
    c.bloqueado,
    c.senha,
    10240 AS download,
    10240 AS upload,
    0 AS planovalor,
    c.conta,
    c.fone,
    c.login,
    c.endereco_res,
    c.numero_res,
    c.bairro_res,
    c.cidade_res,
    c.cep_res,
    c.estado_res,
    c.complemento_res,
    c.nome_pai,
    c.nome_mae,
    c.naturalidade,
    c.dot_ref AS ponto_referencia
FROM sis_cliente c
LEFT JOIN sis_plano p ON (p.nome = c.plano)
WHERE c.cli_ativado = 's' AND p.nome IS NULL
INTO OUTFILE '/tmp/mkauth-clientes-ativados3.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exportar clientes com coordenadas
SELECT 
    login,
    coordenadas 
FROM sis_cliente 
WHERE coordenadas IS NOT NULL
INTO OUTFILE '/tmp/mkauth-clientes-coordenadas.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exportar clientes desativados
SELECT 
    c.id,
    c.login,
    c.pessoa,
    c.nome,
    1,
    c.cpf_cnpj,
    10,
    15,
    rg,
    '' AS profissao,
    '' AS sexo,
    c.nascimento,
    '' AS fantasia,
    '' AS contato,
    c.endereco,
    c.numero,
    c.complemento,
    c.bairro,
    c.cep,
    c.estado,
    c.cidade,
    c.celular,
    c.celular2,
    c.email,
    c.obs,
    c.cadastro,
    c.cadastro,
    '' AS servidor,
    IFNULL(c.plano, 'PLANO_DESATIVADO') AS plano,
    '0' AS valor,
    c.tipo,
    c.ip,
    c.ip,
    c.mac,
    c.venc,
    c.desconto,
    c.acrescimo,
    '' AS transmissor,
    '' AS receptor,
    c.comodato,
    c.isento,
    c.cli_ativado,
    c.bloqueado,
    c.senha,
    IFNULL(p.veldown, '0') AS plano_download,
    IFNULL(p.velup, '0') AS plano_upload,
    IFNULL(p.valor, '0') AS plano_valor,
    '0' AS conta,
    c.fone,
    c.login,
    c.endereco_res,
    c.numero_res,
    c.bairro_res,
    c.cidade_res,
    c.cep_res,
    c.estado_res,
    c.complemento_res,
    c.nome_pai,
    c.nome_mae,
    c.naturalidade,
    c.dot_ref AS ponto_referencia
FROM sis_cliente c
LEFT JOIN sis_plano p ON (p.nome = c.plano)
WHERE c.cli_ativado = 'n'
INTO OUTFILE '/tmp/mkauth-clientes-desativados.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


-- Exportar clientes ativados com dados adicionais e plano associado
SELECT 
    c.id,
    a.username AS login_pppoe,
    c.pessoa,
    c.nome,
    1,
    c.cpf_cnpj,
    10,
    15,
    rg,
    '' AS profissao,
    '' AS sexo,
    c.nascimento,
    '' AS fantasia,
    '' AS contato,
    IFNULL(a.end_endereco, c.endereco) AS endereco,
    IFNULL(a.end_numero, c.numero) AS numero,
    IFNULL(a.end_complemento, c.complemento) AS complemento,
    IFNULL(a.end_bairro, c.bairro) AS bairro,
    c.cep,
    c.estado,
    IFNULL(a.end_cidade, c.cidade) AS cidade,
    c.celular,
    c.celular2,
    c.email,
    c.obs,
    c.cadastro,
    c.cadastro,
    '' AS servidor,
    a.plano,
    '0' AS valor,
    a.tipo,
    a.ip,
    a.ip,
    a.mac,
    c.venc,
    c.desconto,
    c.acrescimo,
    '' AS transmissor,
    '' AS receptor,
    c.comodato,
    c.isento,
    c.cli_ativado,
    a.bloqueado,
    a.senha AS senha,
    p.veldown AS plano_download,
    p.velup AS plano_upload,
    p.valor AS plano_valor,
    c.conta,
    c.fone,
    c.login,
    c.endereco_res,
    c.numero_res,
    c.bairro_res,
    c.cidade_res,
    c.cep_res,
    c.estado_res,
    c.complemento_res,
    c.nome_pai,
    c.nome_mae,
    c.naturalidade,
    c.dot_ref AS ponto_referencia
FROM sis_cliente c
INNER JOIN sis_adicional a ON (a.login = c.login)
INNER JOIN sis_plano p ON (p.nome = a.plano)
WHERE c.cli_ativado = 's'
INTO OUTFILE '/tmp/mkauth-clientes-adicional.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exportar clientes ativados com dados adicionais e plano não associado
SELECT 
    c.id,
    a.username AS login,
    c.pessoa,
    c.nome,
    1,
    c.cpf_cnpj,
    10,
    15,
    rg,
    '' AS profissao,
    '' AS sexo,
    c.nascimento,
    '' AS fantasia,
    '' AS contato,
    IFNULL(a.end_endereco, c.endereco) AS endereco,
    IFNULL(a.end_numero, c.numero) AS numero,
    IFNULL(a.end_complemento, c.complemento) AS complemento,
    IFNULL(a.end_bairro, c.bairro) AS bairro,
    c.cep,
    c.estado,
    IFNULL(a.end_cidade, c.cidade) AS cidade,
    c.celular,
    c.celular2,
    c.email,
    c.obs,
    c.cadastro,
    c.cadastro,
    '' AS servidor,
    (
        SELECT groupname FROM radusergroup 
        WHERE username = a.username LIMIT 1
    ) AS plano,
    '0' AS valor,
    a.tipo,
    a.ip,
    a.ip,
    a.mac,
    c.venc,
    c.desconto,
    c.acrescimo,
    '' AS transmissor,
    '' AS receptor,
    c.comodato,
    c.isento,
    c.cli_ativado,
    a.bloqueado,
    a.senha AS senha,
    IFNULL(p.veldown, '0') AS plano_download,
    IFNULL(p.velup, '0') AS plano_upload,
    IFNULL(p.valor, '0') AS plano_valor,
    c.conta,
    c.fone,
    c.login,
    c.endereco_res,
    c.numero_res,
    c.bairro_res,
    c.cidade_res,
    c.cep_res,
    c.estado_res,
    c.complemento_res,
    c.nome_pai,
    c.nome_mae,
    c.naturalidade,
    c.dot_ref AS ponto_referencia
FROM sis_cliente c
INNER JOIN sis_adicional a ON (a.login = c.login)
LEFT JOIN sis_plano p ON (p.nome = a.plano)
WHERE c.cli_ativado = 's' AND p.nome IS NULL
INTO OUTFILE '/tmp/mkauth-clientes-adicional2.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


-- Exportar chamados de suporte
SELECT 
    chamado,
    login,
    CONCAT("MKAUTH ", assunto) AS assunto,
    status,
    abertura,
    visita,
    fechamento,
    CONCAT("Motivo:", assunto, "\nAtendente:", atendente) AS conteudo,
    motivo_fechar AS servicoprestado
FROM sis_suporte
INTO OUTFILE '/tmp/mkauth-chamados.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Criar ou substituir a visualização vtab_titulos
DROP VIEW IF EXISTS vtab_titulos;

CREATE VIEW vtab_titulos AS
SELECT 
    sis_cliente.nome,
    sis_cliente.pessoa,
    sis_cliente.nome_res,
    sis_cliente.senha,
    sis_cliente.email,
    sis_cliente.vendedor,
    sis_cliente.endereco,
    sis_cliente.complemento,
    sis_cliente.bairro,
    sis_cliente.cidade,
    sis_cliente.cep,
    sis_cliente.estado,
    sis_cliente.cpf_cnpj,
    sis_cliente.fone,
    sis_cliente.login,
    sis_cliente.venc,
    sis_cliente.celular,
    sis_cliente.conta,
    sis_cliente.plano,
    sis_cliente.numero,
    sis_cliente.desconto,
    sis_cliente.acrescimo,
    sis_cliente.ramal,
    sis_cliente.cli_ativado,
    sis_cliente.bloqueado,
    sis_cliente.grupo,
    sis_cliente.codigo,
    ((REPLACE(sis_lanc.valor, ',', '.') - sis_cliente.desconto) + sis_cliente.acrescimo) AS calculado,
    sis_cliente.tags,
    sis_cliente.comodato,
    sis_cliente.dias_corte,
    sis_cliente.geranfe,
    sis_cliente.mesref,
    REPLACE(sis_lanc.valor, ',', '.') AS valor,
    REPLACE(sis_lanc.valorpag, ',', '.') AS valorpag,
    sis_lanc.valorger,
    sis_lanc.formapag,
    sis_lanc.linhadig,
    '',
    sis_lanc.id AS titulo,
    sis_lanc.datavenc,
    sis_lanc.referencia,
    sis_lanc.nossonum,
    sis_lanc.datapag,
    sis_lanc.recibo,
    sis_lanc.status,
    sis_lanc.tipo,
    sis_lanc.processamento,
    sis_lanc.usergerou,
    sis_lanc.coletor,
    sis_lanc.tipocob,
    sis_lanc.codigo_carne,
    sis_lanc.fcartaobandeira,
    sis_lanc.fcartaonumero,
    sis_lanc.fchequenumero,
    sis_lanc.fchequebanco,
    sis_lanc.fchequeagcc,
    sis_lanc.obs AS descricao,
    sis_lanc.numconta,
    '' AS retorno,
    sis_lanc.deltitulo,
    sis_lanc.gerourem,
    sis_lanc.remvalor
FROM sis_cliente, sis_lanc
WHERE sis_cliente.login = sis_lanc.login;

-- Exportar mensagens de ocorrência
SELECT 
    chamado,
    atendente,
    msg_data,
    msg
FROM sis_msg
INTO OUTFILE '/tmp/mkauth-msg-ocorrencia.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';




--SELECT chamado,
--motivo_fechar,
--data 
--from sis_suporte 
--INTO OUTFILE '/tmp/mkauth-motivo-fechamento-ocorrencia.csv' CHARACTER SET utf8 FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta dados de autenticação do RADIUS
SELECT 
    radacctid,
    acctsessionid,
    acctuniqueid,
    username,
    realm,
    nasipaddress,
    nasportid,
    nasporttype,
    acctstarttime,
    AcctUpdateTime,
    acctstoptime,
    acctsessiontime,
    acctauthentic,
    connectinfo_start,
    connectinfo_stop,
    acctinputoctets,
    acctoutputoctets,
    calledstationid,
    callingstationid,
    acctterminatecause,
    servicetype,
    framedprotocol,
    framedipaddress
FROM radacct 
INTO OUTFILE '/tmp/mkauth-radacct.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta clientes ativados com dias de corte
SELECT 
    c.login,
    c.dias_corte 
FROM sis_cliente c 
INTO OUTFILE '/tmp/mkauth-clientes-ativados-dias_cortes.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta dados PIX da Gerencianet
SELECT 
    REPLACE(JSON_EXTRACT(sg.dados, '$.data_vencimento'), '\\', '') AS data_vencimento,
    REPLACE(JSON_EXTRACT(sg.dados, '$.data_documento'), '\\', '') AS data_documento,
    REPLACE(JSON_EXTRACT(sg.dados, '$.data_processamento'), '\\', '') AS data_processamento,
    JSON_EXTRACT(sg.dados, '$.status') AS status,
    JSON_EXTRACT(sg.dados, '$.valor_boleto') AS valor,
    JSON_EXTRACT(sg.dados, '$.cpf_cnpj') AS cpfcnpj,
    JSON_EXTRACT(sg.dados, '$.numero_documento') AS numero_documento,
    REPLACE(JSON_EXTRACT(sg.dados, '$.nosso_numero'), '\\', '') AS nosso_numero,
    REPLACE(JSON_EXTRACT(sg.dados, '$.qrcode'), '\\', '') AS qrcode
FROM sis_gnettits sg 
WHERE JSON_EXTRACT(sg.dados, '$.qrcode') IS NOT NULL 
  AND JSON_EXTRACT(sg.dados, '$.qrcode') <> FALSE
INTO OUTFILE '/tmp/mkauth-dados-pix-gerencianet.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta cobranças adicionais
SELECT 
    ss.id,
    ss.nome,
    ss.valor,
    ss.`data`,
    ss.insuser,
    ss.login 
FROM sis_sercontratos ss
WHERE ss.incluir = 'sim'
INTO OUTFILE '/tmp/mkauth-cobranca-adicional.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta títulos sem conta associada
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
    numconta
FROM vtab_titulos 
WHERE deltitulo = 0 
  AND numconta NOT IN (SELECT id FROM sis_boleto) 
ORDER BY codigo_carne, titulo 
INTO OUTFILE '/tmp/mkauth-titulos-sem-conta.csv' 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta dados de splitter (OLT, splitter e ONU)
SELECT 
    sc.login,
    sc.porta_olt,
    sc.porta_splitter,
    sc.caixa_herm,
    sc.onu_ont  
FROM sis_cliente sc 
UNION 
SELECT 
    sa.login,
    sa.porta_olt,
    sa.porta_splitter,
    sa.caixa_herm,
    sa.onu_ont  
FROM sis_adicional sa  
INTO OUTFILE '/tmp/mkauth-splitter.csv' CHARACTER SET utf8 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta cadastro de portadores (bancos)
SELECT 
    sb.id,
    sb.banco,
    sb.utilizar,
    sb.nome,
    sb.codigo_cedente,
    sb.agencia,
    sb.ag_digito,
    sb.ct_digito,
    sb.carteira,
    sb.convenio,
    sb.cedente,
    sb.cpf_cnpj,
    sb.token_gnet,
    sb.cliente_id_gnet,
    sb.cliente_secret_gnet,
    sb.iugu_token,
    sb.galax_id,
    sb.galax_hash,
    sb.token_pagseguro,
    sb.conta
FROM sis_boleto sb
INTO OUTFILE '/tmp/mkauth-cadastro-portadores.csv' CHARACTER SET utf8  
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Exporta configurações NAS para RADIUS
SELECT 
    ns.id,
    ns.nasname,
    ns.shortname,
    ns.description
FROM nas ns
INTO OUTFILE '/tmp/mkauth-radius-nas.csv' CHARACTER SET utf8  
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
