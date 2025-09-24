t# Fluxo-de-Design-Digital-usando-ferramentas-CADENCE
Este repositório documenta detalhadamente as etapas referentes ao fluxo de design digital utilizando as ferramentas CADENCE para um multiplexador. 

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
  a.**set_db init_read_netlist_files ../physical_design/multiplexor_netlist.v**;
  c.**set_db init_lef_files {../lef/gsclib045_tech.lef ../lef/gsclib045_macro.lef}**;
  d.**set_db init_power_nets VDD**;
  e.**set_db init_ground_nets VSS**;
  f.**set_db init_mmmc_files multiplexor.view**;
  g. **read_mmmc multiplexor.view"**
  f.**read_physical -lefs {../lef/gsclib045_tech.lef ../lef/gsclib045_macro.lef}**;
  g.**read_netlist ../physical_design/multiplexor_netlist.v -top multiplexor**;
  f.**init_design**.
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

Observe que as power stripes e as vias que conectam os rings às stripes são criadas. 

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


![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/1b0f0b808002eef309745819a88ba86e942b1d08/physical_design/17.png)

Figura: Posicionamento das standard cells. Além do posicionamento da célula, a rota de teste foi executada no projeto. 



### 5.5 Running Clock Tree Synthesis (CTS)

O CTS é o processo de distribuir o sinal de clock para todos os elementos sequenciais (flip-flops, registradores) do chip de forma sincronizada e balanceada. 

Visto que o design é um multiplexador puramente combinacional sem elementos de clock, podemos pular com segurança a etapa de CTS e ir direto para o routing, economizando tempo e evitando mensagens de erro desnecessárias.

### 5.6 Routing the Nets

Nesta etapa, será realizado o roteamento especial das redes de alimentação VDD e VSS para criar a estrutura de power distribution network (PDN).

1. Acesso à Ferramenta NanoRoute
- Menu: Route → NanoRoute → NanoRoute
- No campo Concurrent Routing Features marque selecione **Timing Driven** e **SI Driven** (demais campos devem ficar conforme a imagem abaixo);

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e5a4a8d75f31baa78842801e6afd011ad77ddf1a/physical_design/19.png)


- Clique em **OK**. 


![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e5a4a8d75f31baa78842801e6afd011ad77ddf1a/physical_design/20.png)

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/e5a4a8d75f31baa78842801e6afd011ad77ddf1a/physical_design/21.png)


### 5.7 Extraction and Timing Analysis

Nesta estapa, realizaremos processo de extração de parasíticos (RC Extraction) e análise de timing (Setup e Hold) após o roteamento do design.

1. Executar a Extração RC

No shell do Innovus, rode o comando:

- **extract_rc**

Esse comando realiza a extração de resistências e capacitâncias parasíticas sobre o design já roteado.


2. Exportar SPEF

Para salvar os parasíticos extraídos em um arquivo SPEF, use:

- **write_parasitics -spef_file multiplexor.spef**


3. Configurar o modo de análise de timing

- No terminal de comandos, execute **set_db timing_analysis_type ocv**.

Isto define o tipo de análise de timing para OCV (On-Chip Variation).

4. Executar análise de Setup e Hold

- Rode os seguintes comandos para verificar violações de timing: **time_design -post_route**
**time_design -post_route -hold**

![image alt]()
![image alt]()

As imagens acima comprovam que a análise de timing foi feita com sucesso.

### 5.8 Running Physical Verification

#### 5.8.1 Verifying Geometry

#### 5.8.2 Verifying Connectivity


### 5.9 Running Power Analysis 

#### 5.9.1 Viewing Power Analysis Results


### 5.10 Filler Cell Placement 


### 5.10 Generating a Stream File (GDS/OASIS) 














