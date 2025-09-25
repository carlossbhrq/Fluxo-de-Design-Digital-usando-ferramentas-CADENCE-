t# rtl-to-gdsii-multiplexer-cadence-gpdk45
Este repositório documenta a implementação completa do fluxo RTL-to-GDSII para um circuito multiplexador (MUX), utilizando a suíte de ferramentas Cadence e a tecnologia de 45 nm do PDK padrão da Cadence (GPDK 045). O projeto abrange todas as etapas do design digital, desde a descrição do hardware em Verilog/VDHL até a geração do layout físico final (GDSII), passando por síntese, placement, roteamento e verificação. O objetivo é servir como um guia prático e referência para o desenvolvimento de circuitos integrados digitais com essas ferramentas.



## 1. Especificações: 

- A largura do MUX é parametrizada com o valor padrão de 5;
- Se sel for 1'b0, a entrada in0 é passada para a saída mux_out;
- Se sel for 1'b0, a entrada in0 é passada para a saída mux_out. 



## 2. Projeto de arquitetura: 

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/22f04cabce257a526264cb800d31cf1b0474e4be/MUX.png)

*Figura: Multiplexador 2:1 com entradas in0, in1, seletor sel e saída mux_out*



## 3. Projeto RTL:

- Nessa etapa, foi criado em linguagem Verilog o arquivo multiplexor.v, responsável por descrever o comportamento do multiplexador.



## 4. Verificação RTL:

- Dando prosseguimento, criou-se um arquivo testbench (multiplexor_test.v) para a verificação funcional do multiplexador;
- Por meio do código "xrun multiplexor.v multiplexor_test.v", verifica-se o projeto do multiplexador (projetado com sucesso, conforme as imagems abaixo);

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/22f04cabce257a526264cb800d31cf1b0474e4be/01.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/22f04cabce257a526264cb800d31cf1b0474e4be/02.png)

- Pode-se também acessar o SimVision por meio do código "xrun multiplexor.v multiplexor_test.v -gui -access +rwc" para vizualizar os resultados da simulação (conforme ilustra as imagens a abaixo).

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/22f04cabce257a526264cb800d31cf1b0474e4be/03.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/22f04cabce257a526264cb800d31cf1b0474e4be/04.png)



## 5. Síntese: 
### 5.1 Criando o script para execução. 

Dentro do diretório "Síntese", cria-se o arquivo de script "genus_scrip_muxtiplexor.tcl", que contém entradas necessárias para a realização da síntese como RTL, biblioteca de células padrão e restrições (constraints).

O script `genus_script_multiplexor.tcl` realiza:

1. **Configuração** do ambiente e bibliotecas;
2. **Síntese** do RTL para netlist otimizada; 
3. **Geração** de relatórios de qualidade;
4. **Exportação** dos resultados para P&R.



### 5.2 Restrições de tempo ou arquivo SDC. 

Por meio de um arquivo SDC, podemos definir o período do clock, a largura do pulso, os tempos de subida e descida, a incerteza, bem como os atrasos de entrada e saída para diferentes sinais. 

Diante disso, foi criado no diretório '"constraints" o arquivo "constraints_multiplexor.sdc", definindo algumas restrições básicas para o nosso projeto. 

1. ***set_max_delay 3.0 -from [all_inputs] -to [all_outputs]***
Função: Define o tempo máximo de propagação permitido através do circuito combinacional.

2. ***set_driving_cell -lib_cell INVX1 [all_inputs]***
Função: Modela a força de acionamento (drive strength) dos sinais de entrada.

3. ***set_load 0.05 [all_outputs]***
Função: Define a carga capacitiva que a saída do circuito deve acionar.



### 5.2 Iniciando o Genus 

1. Abre-se o terminal dentro do diretório "synthesis" e inicia-se o processo de síntese do projeto do multiplexador através do comando ***genus -f genus_script_multiplexor.tcl***.
2. Finalizada a síntese, foram gerados os arquivos listados abaixos, que encontram-se contidos nos diretórios ***reports*** e ***outputs***:

## 📤 Outputs Gerados

| Arquivo | Descrição |
|---------|-----------|
| `multiplexor_netlist.v` | Netlist sintetizada em Verilog |
| `multiplexor_sdc.sdc` | Constraints exportados |
| `delays_multiplexor.sdf` | Atrasos temporais para simulação |
| `report_timing_MUX.rpt` | Análise detalhada de timing |
| `report_area_MUX.rpt` | Relatório de área utilizada |
| `report_power_MUX.rpt` | Estimativa de consumo de potência |
| `report_qor_MUX.rpt` | Relatório de Quality of Results (QoR) |



![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/a3ce85d9a5731300e2d8bd1477ca33f4c9792ef5/S%C3%ADntese-L%C3%B3gica/05.png)

*Figura: Print do terminal do Genus pós-síntese.*


3. Para fechar o Genus, utiliza-se o comando **exit**.



## 5. Implementação: 

### 5.1 Importando o projeto. 

Nesta seção, deve-se importar o arquivo netlist, timing constraints, libraries e demais arquivos necessários para implementação física do projeto via Innovus. 

1. Dentro do diretório ***physical_design***, abre-se o terminal de comando;
2. Para inicializar o software Innovus, utiliza-se o comando **innovus -stylus**;
3. Após isso, via terminal, faremos a importação de todos os arquivos necessários para iniciarmos o projeto.
- **set_db init_read_netlist_files ../physical_design/multiplexor_netlist.v**;
- **set_db init_lef_files {../lef/gsclib045_tech.lef ../lef/gsclib045_macro.lef}**;
- **set_db init_power_nets VDD**;
- **set_db init_ground_nets VSS**;
- **set_db init_mmmc_files multiplexor.view**;
- **read_mmmc multiplexor.view"**
- **read_physical -lefs {../lef/gsclib045_tech.lef ../lef/gsclib045_macro.lef}**;
- **read_netlist ../physical_design/multiplexor_netlist.v -top multiplexor**;
- **init_design**.

5. Por fim, podemos visualizar os resultados da importação do projeto no GUI do Innovus, selecionando **Floorplan view** e depois **Tools - Design Browser**.


![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/880b1cd1a81698edeabb2c25b08f783f6b561186/physical_design/07.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/880b1cd1a81698edeabb2c25b08f783f6b561186/physical_design/08.png)



#### 5.1.1 MMMC View Definition file. 

O arquivo multiplexor.view (diretório physical_design) contém ponteiros para bibliotecas de tempo, arquivos de tecnologia para extração e arquivos de restrições SDC, definindo as condições de análise para:

##### **Analysis Views:**
- **WC (Worst-Case):** Setup timing analysis
- **BC (Best-Case):** Hold timing analysis

##### **Bibliotecas Utilizadas:**
- `slow_vdd1v0_basicCells.lib` - Pior caso de timing
- `fast_vdd1v0_basicCells.lib` - Melhor caso de timing

##### **Configuração de Parasitas:**
- Tabela de capacitâncias típicas do GPDK045
- Tecnologia QRC para extração RC



### 5.2 Floorplannning the Design 

**Parâmetros utilizados:**
- **Aspect Ratio:** 1.0 (forma quadrada)
- **Utilization:** 40% (baixa para facilitar routing)
- **Margens:** 2.5μm (suficiente para pins e power)

1. Para formatarmos o floorplan com as especificações acima, no GUI, selecionamos **Floorplan -> Specify Floorplan**;
2. Na janela **Specify Floorplan**, preencha os dados conforme a imagem abaixo e clique em **OK**.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/0a538636906906d3a192ba01a946abd39b099f18/physical_design/09.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/25bce1ec51ff808113b88225592119e61db854c6/physical_design/10.png)



### 5.3 Pin Assignment 

Na seção, colocam-se pinos de entrada-saída (E/S) ao redor do bloco. 

1. Para posicionar todos os pinos E/S, utilizaremos o arquivo **mux_pins.io**, que contém a configuração física dos pinos do design. Assim, faz-se a leitura do arquivo através do comando **read_io_file mux_pins.io**;
2. Em seguida, atualiza-se a tela usando o botão de redesenho e visualize o posicionamento dos pinos na janela de design.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/0cd3799d5a407d1e64bc80243b30647da71620d4/physical_design/11.png)



### 5.3 Power Plannning

Nesta etapa, criam-se os anéis de alimentação (power rings) e trilhas (stripes), visando distribuir os sinais VDD e VSS por todo o chip.

1. Acessar a Ferramenta de Power Planning
- Menu: Power → Power Planning → Add Ring.

2. Seleção dos Nets de Alimentação
- No campo Net(s), clique no ícone de pasta 📁;
- No painel Possible Nets, selecione VDD e VSS (Shift + Click);
- Clique em Add para mover para Chosen Nets;
- Clique em OK para confirmar.

3. Ainda na janela **Add Rings**, preecha os campos **Ring Type** e **Ring Configuration** conforme a imagem abaixo.
 
![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e9106ddb155d99d9c950c208d487f00d1bb5a31a/physical_design/12.png)


4. Para gerar os **power rings**, clique em **Apply**.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e9106ddb155d99d9c950c208d487f00d1bb5a31a/physical_design/13.png)


5. Acessar a Ferramenta de Stripes
- Menu: Power → Power Planning → Add Stripes

6. Ainda na janela **Add Stripes**, preencha os campos **Set Configuration**, **Set Pattern**, **Stripe Boundary** e **First/Last Stripe** conforme a imagem abaixo.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/c3064692ab2dc14d3c327489912a70ba855bc8bc/physical_design/14.png)


8. Para gerar os **power stripes**, clique em **OK**.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/c3064692ab2dc14d3c327489912a70ba855bc8bc/physical_design/15.png)

Figura: Observe que as power stripes e as vias que conectam os rings às stripes são criadas. 


9. Salvar o floorplan;
- Menu: File → Save → Floorplan
- Especifique **multiplexor.fp** para o nome do arquivo;
- Clique em **Save**.



### 5.4 Creating Power Rails with Special Route

Neste tópico, iremos conectar os pinos de alimentação das células padrão (standard cells) à malha de power global, criando os "power rails" que distribuem VDD/VSS diretamente para cada célula.

1. Antes do routing, é necessário associar os nets globais VDD/VSS aos pins de power das standard cells.
- connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name *
- connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name *

2. Acesso à Ferramenta Special Route.
-Menu: Route → Special Route

3. Configuração dos Nets
- No campo Net(s), clique no ícone de pasta 📁;
- No painel Possible Nets, selecione VDD e VSS (Shift + Click);
- Clique em Add para mover para Chosen Nets;
- Clique em OK para confirmar.

4. Configuração **SRoute**
- Desmarque todas as opções, exceto **Follow Pins**;
- Isso irá criar power rails seguindo as rows das standard cells.

5. Configuração da aba Via Generation
- Clique na aba **Via Generation**; 
- Em **Make Via Connections To**, selecione **Stripe**
- Em **Specify Layer Ranges**, mantenha as configurações padrão. 
- Clique **OK** para confirmar.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/d3cdc36e4bcceb8f5129f924154406adb6c7bfb1/physical_design/16.png)

Figura: O Special Route finaliza a distribuição de alimentação, conectando cada célula individual à malha de power global criada anteriormente.



### 5.4 Running Placement Optimization

Neste tópico, iremos posicionar fisicamente todas as células padrão (standard cells) dentro do core do chip, otimizando para timing, área, potência e congestionamento.

1. Placement para Design sem DFT 
- **place_opt_design**.

2. O que o place_opt_design realiza?
- Placement Inicial - Posicionamento global das células;
- Otimização de Timing - Ajuste para fechar setup/hold time;
- Otimização de Área - Minimização da área utilizada;
- Otimização de Potência - Redução de consumo.


![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/99166e2f7aa9cdef8379980640686395e8056230/physical_design/22.png)

Figura: Posicionamento das standard cells. Além do posicionamento da célula, a rota de teste foi executada no projeto. 



### 5.5 Running Clock Tree Synthesis (CTS)

O CTS é o processo de distribuir o sinal de clock para todos os elementos sequenciais (flip-flops, registradores) do chip de forma sincronizada e balanceada. 

Visto que o design é um multiplexador puramente combinacional sem elementos de clock, podemos pular com segurança a etapa de CTS e ir direto para o routing, economizando tempo e evitando mensagens de erro desnecessárias.



### 5.6 Routing the Nets

Nesta etapa, será realizado o roteamento especial das redes de alimentação VDD e VSS para criar a estrutura de power distribution network (PDN).

1. Acesso à Ferramenta NanoRoute
- Menu: Route → NanoRoute → Route
- No campo Concurrent Routing Features marque selecione **Timing Driven** e **SI Driven** (demais campos devem ficar conforme a imagem abaixo);

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e5a4a8d75f31baa78842801e6afd011ad77ddf1a/physical_design/19.png)


- Clique em **OK**. 


![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e5a4a8d75f31baa78842801e6afd011ad77ddf1a/physical_design/20.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/8e7baf08c459cf38487bb56131b94caf9e6615a4/physical_design/24.png)



### 5.7 Extraction and Timing Analysis

Nesta estapa, realizaremos processo de extração de parasíticos (RC Extraction) e análise de timing (Setup e Hold) após o roteamento do design.

1. Executar a Extração RC

No shell do Innovus, rode o comando:

- **extract_rc**

Esse comando realiza a extração de resistências e capacitâncias parasíticas sobre o design já roteado.


2. Exportar SPEF

Para salvar os parasíticos extraídos em um arquivo SPEF, use:

- **write_parasitics -spef_file multiplexor.spef**

3. Configurar OCV (obrigatório para post-route)

- **set_db timing_analysis_type ocv**

4. Manter a configuração MMMC para corners

- **set_db timing_analysis_cppr both**

5.Especificar technology node

- **set_db design_process_node 45**

6. Executar análise de Setup e Hold

- **time_design -post_route**
- **time_design -post_route -hold**

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/624ba8eafc502ef44c9cde55f04a3c70c004fe8f/physical_design/25.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/624ba8eafc502ef44c9cde55f04a3c70c004fe8f/physical_design/26.png)

As imagens acima comprovam que a análise de timing foi realizada com sucesso.



### 5.8 Running Physical Verification

#### 5.8.1 Verifying Geometry

Neste tópico, verificaremos se o layout físico do design atende às regras de fabricação do processo 45nm.

1. Acessar menu Check → Check DRC
2. Manter opções padrão selecionadas
3. Clicar OK para executar a verificação


![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/cc534f3b772dbc9fa10d025531b4df37a70ee1c1/physical_design/27.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/cc534f3b772dbc9fa10d025531b4df37a70ee1c1/physical_design/28.png)



#### 5.8.2 Verifying Connectivity

Neste tópico, verificaremos a integridade das conexões elétricas no design roteado.

1. Acessar menu Check → Check Connectivity;
2. Preencha todos os campos conforme a imagem abaixo.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/cc534f3b772dbc9fa10d025531b4df37a70ee1c1/physical_design/29.png)


3. Clicar OK para executar a verificação.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/cc534f3b772dbc9fa10d025531b4df37a70ee1c1/physical_design/30.png)



### 5.9 Running Power Analysis 

Neste tópico, realizaremos a análise estática de consumo de potência do design multiplexor.

1. Acessar Menu: Power → Power Analysis → Setup;
2. Preencha a janela Set Power Analysis Mode conforme a imagem abaixo.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/087190eb88cec2871eda035f42a62cf4452c5744/physical_design/31.png)


3. Clique em OK;
4. Via terminal, digite **source power.tcl**, para carregar as regras de power;
5. Para iniciar o processo de análise de power, acesse Menu: Power → Power Analysis → Run;
6. Preencha a janela Run Power Analysis conforme a imagem abaixo;

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/ed6abb1d1e0863facacd039aa250d9a3ec9810a0/physical_design/32.png)


7. Clique em OK.

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/0ea79b2da12b1d187e87ad313b4e9631101c6b1f/physical_design/33.png)


8. Para iniciar a Rail Analysis, acesse Menu: Power → Rail Analysis → Setup;
9. Preencha a janela Set Rail Analysis Mode conforme a imagem abaixo;

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/415897a148b42a35b7e84361549f34fd9b0b1a7d/physical_design/34.png)


10. Clique em OK;
11. Acesse Menu: Power → Rail Analysis → Run;
12. Preencha a janela Run Rail Analysis conforme a imagem abaixo;

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/089581db0de022fd3f56726cf8bed647c2d505f3/physical_design/36.png)


13. Clique em Create;
14. Preencha a janela Edit Pad Location conforme a imagem abaixo;
- Para preencher o Pad Location List, deve-se clicar em Get Coord e depois clicar em algum local da janela de projeto do Innovus, como por exemplo locais com rings de power existentes.
- Em seguida, clique em Add;
- Clique em Save;
- Salve como multiplexor.pp;
- Clique em Cancel para fechar a janela Edit Pad Location;

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/6c085bfee3b04bff4cd91fc0264691ad11b95b32/physical_design/38.png)


15. De volta a janela Run Rail Analysis, preencha o campo File com multiplexor.pp e o campo Net Name com VDD, em seguida clique em ADD;
16. Preencha o campo Results Directory com ./run1;
17. A janela Run Rail Analysis deve ser preenchida conforme a imagem abaixo. 

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/247d1d30d3cda08f23675aad0b4e884748d03cbf/physical_design/42.png)


17. CLique em OK. 

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/296e4f05b836b065cc8354f0042eafab532baf2d/physical_design/43.png)



#### 5.9.1 Viewing Power Analysis Results

Neste subtópico, iremos visualizar e analisar os resultados de Power e Rail. 

1. Carregamento dos Resultados da Análise
- read_power_rail_results -power_db run1/power.db -rail_directory run1/VDD_25C_avg_2
  
2. Acesso à Interface de Resultados
- Menu: Power → Report → Power Rail Result
- Double-click no ícone ![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/8478f24decfa3d9c894a2b9328398c14baebc766/physical_design/44.1.png) para abrir o Power Rail Plot.


3. Configuração da Visualização Rail Analysis

- No painel esquerdo Power Rail Plot, selecionar Rail;
- No dropdown, selecionar ir – IR Drop;
- Ajustar parâmetros de visualização conforme necessário. 

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/a03898bbd5a1b9d399f829aa2cd611bf88c59601/physical_design/45.png)



### 5.10 Filler Cell Placement 

Neste tópico, iremos preencher espaços vazios no layout com células de preenchimento (filler cells) para:

- Garantir continuidade do well e implant layers
- Prevenir latch-up e problemas de fabricação
- Manter continuidade de power rails
- Assegurar DRC-clean layout

1. Clique em Menu: Place → Physical Cell → Add Filler;
2. Na janela Add Filler
- Clique em Select no campo Cell Name(s);
- Selecione as Cells FILL8, FILL64, FILL4, FILL32, FILL2, FILL16, FILL1;
- Clique em Add;
- Clique em Close;
-Clique em OK para iniciar a colocação das células de preenchimento. 

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/c9e6592a5dd1a0bca46a1b80dfabda24271bfa46/physical_design/46.png)

Figura: Pós colocação das células de preenchimento. 


### 5.10 Generating a Stream File (GDS/OASIS) 

Nesta última etapa, iremos gerar arquivo GDSII (Stream File) para entrega à foundry para fabricação do chip.

1. Clique em Menu: File → Save → GDS/OASIS;
2. Na janela GDS/OASIS Export
- Preencha o campo Output file com o nome do arquivo GDSII (nesse caso, multiplexor.gds);

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/c9e6592a5dd1a0bca46a1b80dfabda24271bfa46/physical_design/47.png)

3. Clique em OK.
4. Por fim, feche o software Innovus.
- Para isso, digite o comando exit. 












