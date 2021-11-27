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
