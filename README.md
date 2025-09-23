# Fluxo-de-Design-Digital-usando-ferramentas-CADENCE
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

![image alt](https://github.com/carlossbhrq/Fluxo-de-Design-Digital-usando-ferramentas-CADENCE-/blob/22f04cabce257a526264cb800d31cf1b0474e4be/MUX.png)

*Figura: Print do terminal do Genus pós-síntese.*


3. Para fechar o Genus, utiliza-se o comando **exit**. 


