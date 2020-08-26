BEGIN;
SELECT set_config('calima.user','calima', FALSE);

delete from ger_produto_emp as p1 where
    (select count(1) from ger_produto_emp as p2 where p2.id_ger_produto =
                                                      p1.id_ger_produto and p2.id_ger_empresa = p1.id_ger_empresa) > 1
                                    and (select min(id) from ger_produto_emp as p2 where
    p2.id_ger_produto = p1.id_ger_produto and p2.id_ger_empresa = p1.id_ger_empresa) <> p1.id;

insert into ger_produto_emp select nextval('s_ger_ids'), p.id, e.id, null, 0, 0, 0, false, false, false, false, 0, null, null, null, null, null, null, null, null,null, null,null, null
from ger_produto as p
       inner join ger_grupo_empresa_config as c on c.id_ger_grupo_produto = p.id_ger_grupo_produto
       inner join ger_empresa as e on e.id_ger_grupo_empresa_raiz = c.id_ger_grupo_empresa_raiz
where not exists (SELECT pemp.id
                  FROM ger_produto_emp as pemp
                         INNER JOIN ger_empresa emp ON emp.id = pemp.id_ger_empresa
                  WHERE
                      emp.id = e.id and pemp.id_ger_produto = p.id);

insert into mlf_produto_emp select nextvaL('s_ger_ids'), s.id, 0, null, false, null, false, false, false, false, null, false, null, null, null, null
from ger_produto_emp as s where
    (select count(x.id) from mlf_produto_emp as x where x.id_ger_produto_emp = s.id) = 0;

COMMIT;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_10_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_10_fk FOREIGN KEY (id_mlf_codigo_dctf_pis) REFERENCES mlf_codigo_dctf (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_11_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_11_fk FOREIGN KEY (id_mlf_codigo_dctf_cofins) REFERENCES mlf_codigo_dctf (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_12_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_12_fk FOREIGN KEY (id_ger_origem_mercadoria_entrada) REFERENCES ger_origem_mercadoria (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_13_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_13_fk FOREIGN KEY (id_ger_origem_mercadoria_saida) REFERENCES ger_origem_mercadoria (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_14_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_14_fk FOREIGN KEY (id_ger_situacao_tributaria_entrada) REFERENCES ger_situacao_tributaria (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_15_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_15_fk FOREIGN KEY (id_ger_situacao_tributaria_saida) REFERENCES ger_situacao_tributaria (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_16_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_16_fk FOREIGN KEY (id_ger_cst_simples_nacional_entrada) REFERENCES ger_cst_simples_nacional (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_17_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_17_fk FOREIGN KEY (id_ger_empresa) REFERENCES ger_empresa (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_18_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_18_fk FOREIGN KEY (id_ger_produto) REFERENCES ger_produto (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_1_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_1_fk FOREIGN KEY (id_ger_cst_simples_nacional_saida) REFERENCES ger_cst_simples_nacional (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_2_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_2_fk FOREIGN KEY (id_ger_cst_pis_entrada) REFERENCES ger_cst_pis (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_3_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_3_fk FOREIGN KEY (id_ger_cst_pis_saida) REFERENCES ger_cst_pis (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_4_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_4_fk FOREIGN KEY (id_ger_cst_cofins_entrada) REFERENCES ger_cst_cofins (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_5_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_5_fk FOREIGN KEY (id_ger_cst_cofins_saida) REFERENCES ger_cst_cofins (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_6_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_6_fk FOREIGN KEY (id_ger_cst_ipi_entrada) REFERENCES ger_cst_ipi (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_7_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_7_fk FOREIGN KEY (id_ger_cst_ipi_saida) REFERENCES ger_cst_ipi (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_8_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_8_fk FOREIGN KEY (id_ger_natureza_receita_pis) REFERENCES ger_natureza_receita (id) ON UPDATE CASCADE;

ALTER TABLE ONLY ger_produto_emp DROP CONSTRAINT IF EXISTS gerprodutoemp_9_fk;
ALTER TABLE ONLY ger_produto_emp
  ADD CONSTRAINT gerprodutoemp_9_fk FOREIGN KEY (id_ger_natureza_receita_cofins) REFERENCES ger_natureza_receita (id) ON UPDATE CASCADE;

CREATE INDEX IF NOT EXISTS gerprodutoemp_10_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_pis_saida);

CREATE INDEX IF NOT EXISTS gerprodutoemp_11_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_cofins_entrada);

CREATE INDEX IF NOT EXISTS gerprodutoemp_12_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_cofins_saida);

CREATE INDEX IF NOT EXISTS gerprodutoemp_13_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_ipi_entrada);

CREATE INDEX IF NOT EXISTS gerprodutoemp_14_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_ipi_saida);

CREATE INDEX IF NOT EXISTS gerprodutoemp_15_idx
  ON ger_produto_emp
  USING btree (id_ger_natureza_receita_pis);

CREATE INDEX IF NOT EXISTS gerprodutoemp_16_idx
  ON ger_produto_emp
  USING btree (id_ger_natureza_receita_cofins);

CREATE INDEX IF NOT EXISTS gerprodutoemp_17_idx
  ON ger_produto_emp
  USING btree (id_mlf_codigo_dctf_pis);

CREATE INDEX IF NOT EXISTS gerprodutoemp_18_idx
  ON ger_produto_emp
  USING btree (id_mlf_codigo_dctf_cofins);

CREATE INDEX IF NOT EXISTS gerprodutoemp_1_idx
  ON ger_produto_emp
  USING btree (id_ger_produto);

CREATE INDEX IF NOT EXISTS gerprodutoemp_2_idx
  ON ger_produto_emp
  USING btree (id_ger_empresa);

CREATE INDEX IF NOT EXISTS gerprodutoemp_3_idx
  ON ger_produto_emp
  USING btree (id_ger_origem_mercadoria_entrada);

CREATE INDEX IF NOT EXISTS gerprodutoemp_4_idx
  ON ger_produto_emp
  USING btree (id_ger_origem_mercadoria_saida);

CREATE INDEX IF NOT EXISTS gerprodutoemp_5_idx
  ON ger_produto_emp
  USING btree (id_ger_situacao_tributaria_entrada);

CREATE INDEX IF NOT EXISTS gerprodutoemp_6_idx
  ON ger_produto_emp
  USING btree (id_ger_situacao_tributaria_saida);

CREATE INDEX IF NOT EXISTS gerprodutoemp_7_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_simples_nacional_entrada);

CREATE INDEX IF NOT EXISTS gerprodutoemp_8_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_simples_nacional_saida);

CREATE INDEX IF NOT EXISTS gerprodutoemp_9_idx
  ON ger_produto_emp
  USING btree (id_ger_cst_pis_entrada);

ALTER TABLE ONLY ger_produto_emp_aliquota_uf DROP CONSTRAINT IF EXISTS gerprodutoempaliquotauf_1_fk;
ALTER TABLE ONLY ger_produto_emp_aliquota_uf
  ADD CONSTRAINT gerprodutoempaliquotauf_1_fk FOREIGN KEY (id_ger_cep_uf_destino) REFERENCES ger_cep_uf (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY ger_produto_emp_aliquota_uf DROP CONSTRAINT IF EXISTS gerprodutoempaliquotauf_2_fk;
ALTER TABLE ONLY ger_produto_emp_aliquota_uf
  ADD CONSTRAINT gerprodutoempaliquotauf_2_fk FOREIGN KEY (id_ger_cep_uf_origem) REFERENCES ger_cep_uf (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY ger_produto_emp_aliquota_uf DROP CONSTRAINT IF EXISTS gerprodutoempaliquotauf_3_fk;
ALTER TABLE ONLY ger_produto_emp_aliquota_uf
  ADD CONSTRAINT gerprodutoempaliquotauf_3_fk FOREIGN KEY (id_ger_produto_emp) REFERENCES ger_produto_emp (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY ger_produto_emp_aliquota_uf DROP CONSTRAINT IF EXISTS gerprodutoempaliquotauf_1_uk;
ALTER TABLE ONLY ger_produto_emp_aliquota_uf
  ADD CONSTRAINT gerprodutoempaliquotauf_1_uk UNIQUE (id_ger_produto_emp, id_ger_cep_uf_origem, id_ger_cep_uf_destino)
  DEFERRABLE INITIALLY DEFERRED;

CREATE INDEX IF NOT EXISTS gerprodutoempaliquotauf_1_idx
  ON ger_produto_emp_aliquota_uf
  USING btree (id_ger_produto_emp);

CREATE INDEX IF NOT EXISTS gerprodutoempaliquotauf_2_idx
  ON ger_produto_emp_aliquota_uf
  USING btree (id_ger_cep_uf_origem);

CREATE INDEX IF NOT EXISTS gerprodutoempaliquotauf_3_idx
  ON ger_produto_emp_aliquota_uf
  USING btree (id_ger_cep_uf_destino);

ALTER TABLE ONLY mlf_produto_emp DROP CONSTRAINT IF EXISTS mlfprodutoemp_1_fk;
ALTER TABLE ONLY mlf_produto_emp
  ADD CONSTRAINT mlfprodutoemp_1_fk FOREIGN KEY (id_ger_forcli) REFERENCES ger_forcli (id) ON UPDATE CASCADE;

ALTER TABLE ONLY mlf_produto_emp DROP CONSTRAINT IF EXISTS mlfprodutoemp_2_fk;
ALTER TABLE ONLY mlf_produto_emp
  ADD CONSTRAINT mlfprodutoemp_2_fk FOREIGN KEY (id_ger_produto_emp) REFERENCES ger_produto_emp (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY mlf_produto_emp DROP CONSTRAINT IF EXISTS mlfprodutoemp_3_fk;
ALTER TABLE ONLY mlf_produto_emp
  ADD CONSTRAINT mlfprodutoemp_3_fk FOREIGN KEY (id_ger_unidade_estatistica) REFERENCES ger_unidade_medida (id) ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE INDEX IF NOT EXISTS mlfprodutoemp_1_idx
  ON mlf_produto_emp
  USING btree (id_ger_produto_emp);

CREATE INDEX IF NOT EXISTS mlfprodutoemp_2_idx
  ON mlf_produto_emp
  USING btree (id_ger_forcli);

CREATE INDEX IF NOT EXISTS mlfprodutoemp_3_idx
  ON mlf_produto_emp
  USING btree (id_ger_unidade_estatistica);