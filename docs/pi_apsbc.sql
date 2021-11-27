CREATE TABLE `acl` (
  `acl_grupo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `acl_display` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `acl_privilegios` varchar(360) COLLATE utf8_unicode_ci NOT NULL,
  `acl_obs` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `classe` (
  `cls_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `esc_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cls_turno` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `cls_descricao` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `prf_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cls_obs` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `cls_ativa` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `contatos` (
  `ctt_codigo` int(11) NOT NULL,
  `esc_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ctt_nome` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ctt_email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `ctt_telefone` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `ctt_cargo` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ctt_obs` varchar(250) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `escolas` (
  `esc_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `esc_nome` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `esc_cep` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `esc_logradouro` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `esc_bairro` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `esc_numero` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `movimentos` (
  `mov_codigo` int(11) NOT NULL,
  `prf_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `mov_comprovante` blob NOT NULL,
  `mov_datahora` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `sol_codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `professores` (
  `prf_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `esc_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `prf_condicao` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `prf_nome` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `prf_disciplinas` varchar(240) COLLATE utf8_unicode_ci NOT NULL,
  `prf_nascimento` date NOT NULL,
  `prf_documento` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `prf_obs` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `prf_ativo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `solicitacoes` (
  `sol_codigo` int(11) NOT NULL,
  `prf_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `sol_datahora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sol_agenda_inicio` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sol_agenda_termino` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cls_codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `sol_motivo` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `sol_comprovante` blob NOT NULL,
  `sol_atendida` tinyint(1) NOT NULL,
  `sol_ativa` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `usuarios` (
  `usr_usuario` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `acl_grupo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `usr_display` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `usr_email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `usr_senha` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `acl`
  ADD PRIMARY KEY (`acl_grupo`);

ALTER TABLE `classe`
  ADD PRIMARY KEY (`cls_codigo`),
  ADD KEY `esc_codigo` (`esc_codigo`),
  ADD KEY `prf_codigo` (`prf_codigo`);

ALTER TABLE `contatos`
  ADD PRIMARY KEY (`ctt_codigo`),
  ADD KEY `esc_codigo` (`esc_codigo`),
  ADD KEY `ctt_cargo` (`ctt_cargo`);

ALTER TABLE `escolas`
  ADD PRIMARY KEY (`esc_codigo`),
  ADD KEY `esc_bairro` (`esc_bairro`);
ALTER TABLE `escolas` ADD FULLTEXT KEY `esc_nome` (`esc_nome`);

ALTER TABLE `movimentos`
  ADD PRIMARY KEY (`mov_codigo`),
  ADD KEY `prf_codigo` (`prf_codigo`),
  ADD KEY `sol_codigo` (`sol_codigo`);

ALTER TABLE `professores`
  ADD PRIMARY KEY (`prf_codigo`),
  ADD KEY `esc_codigo` (`esc_codigo`),
  ADD KEY `prf_condicao` (`prf_condicao`);
ALTER TABLE `professores` ADD FULLTEXT KEY `prf_disciplinas` (`prf_disciplinas`);

ALTER TABLE `solicitacoes`
  ADD PRIMARY KEY (`sol_codigo`),
  ADD KEY `prf_codigo` (`prf_codigo`),
  ADD KEY `cls_codigo` (`cls_codigo`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usr_usuario`),
  ADD KEY `acl_grupo` (`acl_grupo`);


ALTER TABLE `contatos`
  MODIFY `ctt_codigo` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `movimentos`
  MODIFY `mov_codigo` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `solicitacoes`
  MODIFY `sol_codigo` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `classe`
  ADD CONSTRAINT `classe_ibfk_1` FOREIGN KEY (`esc_codigo`) REFERENCES `escolas` (`esc_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `classe_ibfk_2` FOREIGN KEY (`prf_codigo`) REFERENCES `professores` (`prf_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `contatos`
  ADD CONSTRAINT `contatos_ibfk_1` FOREIGN KEY (`esc_codigo`) REFERENCES `escolas` (`esc_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `movimentos`
  ADD CONSTRAINT `movimentos_ibfk_1` FOREIGN KEY (`sol_codigo`) REFERENCES `solicitacoes` (`sol_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movimentos_ibfk_2` FOREIGN KEY (`prf_codigo`) REFERENCES `professores` (`prf_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `professores`
  ADD CONSTRAINT `professores_ibfk_1` FOREIGN KEY (`esc_codigo`) REFERENCES `escolas` (`esc_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `solicitacoes`
  ADD CONSTRAINT `solicitacoes_ibfk_1` FOREIGN KEY (`cls_codigo`) REFERENCES `classe` (`cls_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `solicitacoes_ibfk_2` FOREIGN KEY (`prf_codigo`) REFERENCES `professores` (`prf_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`acl_grupo`) REFERENCES `acl` (`acl_grupo`) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE VIEW `agenda` AS SELECT
    `solicitacoes`.`sol_codigo` AS `sol_codigo`,
    `solicitacoes`.`prf_codigo` AS `prf_codigo`,
    `solicitacoes`.`sol_datahora` AS `sol_datahora`,
    `solicitacoes`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `solicitacoes`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `solicitacoes`.`cls_codigo` AS `cls_codigo`,
    `solicitacoes`.`sol_motivo` AS `sol_motivo`,
    `solicitacoes`.`sol_comprovante` AS `sol_comprovante`,
    `solicitacoes`.`sol_atendida` AS `sol_atendida`,
    `solicitacoes`.`sol_ativa` AS `sol_ativa`,
    `movimentos`.`prf_codigo` AS `prf_volante`
FROM
    (
        `solicitacoes`
    JOIN `movimentos` ON
        (
            (
                `solicitacoes`.`sol_codigo` = `movimentos`.`sol_codigo`
            )
        )
    );

CREATE VIEW `agenda_classe` AS SELECT
    `agenda`.`sol_codigo` AS `sol_codigo`,
    `agenda`.`prf_codigo` AS `prf_codigo`,
    `agenda`.`sol_datahora` AS `sol_datahora`,
    `agenda`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `agenda`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `agenda`.`cls_codigo` AS `cls_codigo`,
    `agenda`.`sol_motivo` AS `sol_motivo`,
    `agenda`.`sol_comprovante` AS `sol_comprovante`,
    `agenda`.`sol_atendida` AS `sol_atendida`,
    `agenda`.`sol_ativa` AS `sol_ativa`,
    `agenda`.`prf_volante` AS `prf_volante`,
    `classe`.`esc_codigo` AS `esc_codigo`,
    `classe`.`cls_turno` AS `cls_turno`,
    `classe`.`cls_descricao` AS `cls_descricao`
FROM
    (
        `agenda`
    JOIN `classe` ON
        (
            (
                `agenda`.`cls_codigo` = `classe`.`cls_codigo`
            )
        )
    );

CREATE VIEW `agenda_classe_solicitacao` AS SELECT
    `agenda_solicitacoes`.`sol_codigo` AS `sol_codigo`,
    `agenda_solicitacoes`.`prf_codigo` AS `prf_codigo`,
    `agenda_solicitacoes`.`sol_datahora` AS `sol_datahora`,
    `agenda_solicitacoes`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `agenda_solicitacoes`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `agenda_solicitacoes`.`cls_codigo` AS `cls_codigo`,
    `agenda_solicitacoes`.`sol_motivo` AS `sol_motivo`,
    `agenda_solicitacoes`.`sol_comprovante` AS `sol_comprovante`,
    `agenda_solicitacoes`.`sol_atendida` AS `sol_atendida`,
    `agenda_solicitacoes`.`sol_ativa` AS `sol_ativa`,
    `classe`.`esc_codigo` AS `esc_codigo`,
    `classe`.`cls_turno` AS `cls_turno`,
    `classe`.`cls_descricao` AS `cls_descricao`
FROM
    (
        `agenda_solicitacoes`
    JOIN `classe` ON
        (
            (
                `agenda_solicitacoes`.`cls_codigo` = `classe`.`cls_codigo`
            )
        )
    );

CREATE VIEW `agenda_escola` AS SELECT
    `agenda_classe`.`sol_codigo` AS `sol_codigo`,
    `agenda_classe`.`prf_codigo` AS `prf_codigo`,
    `agenda_classe`.`sol_datahora` AS `sol_datahora`,
    `agenda_classe`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `agenda_classe`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `agenda_classe`.`cls_codigo` AS `cls_codigo`,
    `agenda_classe`.`sol_motivo` AS `sol_motivo`,
    `agenda_classe`.`sol_comprovante` AS `sol_comprovante`,
    `agenda_classe`.`sol_atendida` AS `sol_atendida`,
    `agenda_classe`.`sol_ativa` AS `sol_ativa`,
    `agenda_classe`.`prf_volante` AS `prf_volante`,
    `agenda_classe`.`esc_codigo` AS `esc_codigo`,
    `agenda_classe`.`cls_turno` AS `cls_turno`,
    `agenda_classe`.`cls_descricao` AS `cls_descricao`,
    `escolas`.`esc_nome` AS `esc_nome`,
    `escolas`.`esc_cep` AS `esc_cep`,
    `escolas`.`esc_logradouro` AS `esc_logradouro`,
    `escolas`.`esc_bairro` AS `esc_bairro`,
    `escolas`.`esc_numero` AS `esc_numero`
FROM
    (
        `agenda_classe`
    JOIN `escolas` ON
        (
            (
                `agenda_classe`.`esc_codigo` = `escolas`.`esc_codigo`
            )
        )
    );

CREATE VIEW `agenda_escola_solicitacao` AS SELECT
    `agenda_classe_solicitacao`.`sol_codigo` AS `sol_codigo`,
    `agenda_classe_solicitacao`.`prf_codigo` AS `prf_codigo`,
    `agenda_classe_solicitacao`.`sol_datahora` AS `sol_datahora`,
    `agenda_classe_solicitacao`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `agenda_classe_solicitacao`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `agenda_classe_solicitacao`.`cls_codigo` AS `cls_codigo`,
    `agenda_classe_solicitacao`.`sol_motivo` AS `sol_motivo`,
    `agenda_classe_solicitacao`.`sol_comprovante` AS `sol_comprovante`,
    `agenda_classe_solicitacao`.`sol_atendida` AS `sol_atendida`,
    `agenda_classe_solicitacao`.`sol_ativa` AS `sol_ativa`,
    `agenda_classe_solicitacao`.`esc_codigo` AS `esc_codigo`,
    `agenda_classe_solicitacao`.`cls_turno` AS `cls_turno`,
    `agenda_classe_solicitacao`.`cls_descricao` AS `cls_descricao`,
    `escolas`.`esc_nome` AS `esc_nome`,
    `escolas`.`esc_cep` AS `esc_cep`,
    `escolas`.`esc_logradouro` AS `esc_logradouro`,
    `escolas`.`esc_bairro` AS `esc_bairro`,
    `escolas`.`esc_numero` AS `esc_numero`
FROM
    (
        `agenda_classe_solicitacao`
    JOIN `escolas` ON
        (
            (
                `agenda_classe_solicitacao`.`esc_codigo` = `escolas`.`esc_codigo`
            )
        )
    );

CREATE VIEW `agenda_solicitacoes` AS SELECT
    `solicitacoes`.`sol_codigo` AS `sol_codigo`,
    `solicitacoes`.`prf_codigo` AS `prf_codigo`,
    `solicitacoes`.`sol_datahora` AS `sol_datahora`,
    `solicitacoes`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `solicitacoes`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `solicitacoes`.`cls_codigo` AS `cls_codigo`,
    `solicitacoes`.`sol_motivo` AS `sol_motivo`,
    `solicitacoes`.`sol_comprovante` AS `sol_comprovante`,
    `solicitacoes`.`sol_atendida` AS `sol_atendida`,
    `solicitacoes`.`sol_ativa` AS `sol_ativa`
FROM
    `solicitacoes`
WHERE
    (
        NOT(
            `solicitacoes`.`sol_codigo` IN(
            SELECT
                `movimentos`.`sol_codigo`
            FROM
                `movimentos`
        )
        )
    );

CREATE VIEW `agenda_solicitacoes_abertas` AS SELECT
    `agenda_escola_solicitacao`.`sol_codigo` AS `sol_codigo`,
    `agenda_escola_solicitacao`.`prf_codigo` AS `prf_codigo`,
    `agenda_escola_solicitacao`.`sol_datahora` AS `sol_datahora`,
    `agenda_escola_solicitacao`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `agenda_escola_solicitacao`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `agenda_escola_solicitacao`.`cls_codigo` AS `cls_codigo`,
    `agenda_escola_solicitacao`.`sol_motivo` AS `sol_motivo`,
    `agenda_escola_solicitacao`.`sol_comprovante` AS `sol_comprovante`,
    `agenda_escola_solicitacao`.`sol_atendida` AS `sol_atendida`,
    `agenda_escola_solicitacao`.`sol_ativa` AS `sol_ativa`,
    `agenda_escola_solicitacao`.`esc_codigo` AS `esc_codigo`,
    `agenda_escola_solicitacao`.`cls_turno` AS `cls_turno`,
    `agenda_escola_solicitacao`.`cls_descricao` AS `cls_descricao`,
    `agenda_escola_solicitacao`.`esc_nome` AS `esc_nome`,
    `agenda_escola_solicitacao`.`esc_cep` AS `esc_cep`,
    `agenda_escola_solicitacao`.`esc_logradouro` AS `esc_logradouro`,
    `agenda_escola_solicitacao`.`esc_bairro` AS `esc_bairro`,
    `agenda_escola_solicitacao`.`esc_numero` AS `esc_numero`,
    `professores`.`prf_nome` AS `prf_nome`,
    `professores`.`prf_documento` AS `prf_documento`,
    `professores`.`prf_disciplinas` AS `prf_disciplinas`
FROM
    (
        `agenda_escola_solicitacao`
    JOIN `professores` ON
        (
            (
                `agenda_escola_solicitacao`.`prf_codigo` = `professores`.`prf_codigo`
            )
        )
    );

CREATE VIEW `agenda_volantes` AS SELECT
    `agenda_escola`.`sol_codigo` AS `sol_codigo`,
    `agenda_escola`.`prf_codigo` AS `prf_codigo`,
    `agenda_escola`.`sol_datahora` AS `sol_datahora`,
    `agenda_escola`.`sol_agenda_inicio` AS `sol_agenda_inicio`,
    `agenda_escola`.`sol_agenda_termino` AS `sol_agenda_termino`,
    `agenda_escola`.`cls_codigo` AS `cls_codigo`,
    `agenda_escola`.`sol_motivo` AS `sol_motivo`,
    `agenda_escola`.`sol_comprovante` AS `sol_comprovante`,
    `agenda_escola`.`sol_atendida` AS `sol_atendida`,
    `agenda_escola`.`sol_ativa` AS `sol_ativa`,
    `agenda_escola`.`prf_volante` AS `prf_volante`,
    `agenda_escola`.`esc_codigo` AS `esc_codigo`,
    `agenda_escola`.`cls_turno` AS `cls_turno`,
    `agenda_escola`.`cls_descricao` AS `cls_descricao`,
    `agenda_escola`.`esc_nome` AS `esc_nome`,
    `agenda_escola`.`esc_cep` AS `esc_cep`,
    `agenda_escola`.`esc_logradouro` AS `esc_logradouro`,
    `agenda_escola`.`esc_bairro` AS `esc_bairro`,
    `agenda_escola`.`esc_numero` AS `esc_numero`,
    `professores`.`prf_nome` AS `prf_volante_nome`,
    `professores`.`prf_documento` AS `prf_volante_documento`
FROM
    (
        `agenda_escola`
    JOIN `professores` ON
        (
            (
                `agenda_escola`.`prf_volante` = `professores`.`prf_codigo`
            )
        )
    );