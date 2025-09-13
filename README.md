# Fluxo-de-Design-Digital-usando-ferramentas-CADENCE
Este repositório documenta detalhadamente as etapas referentes ao FRONT-END do fluxo de design digital utilizando as ferramentas CADENCE para um multiplexador de endereços. 

## 1. Especificações: 
- O multiplexador de endereços seleciona entre o endereço da instrução durante a fase de busca da instrução e o endereço do operando durante a fase de execução da instrução;
- A largura do MUX é parametrizada com o valor padrão de 5;
- Se sel for 1'b0, a entrada in0 é passada para a saída mux_out;
- Se sel for 1'b0, a entrada in0 é passada para a saída mux_out. 

## 2. Projeto de arquitetura: 

![Diagrama do Multiplexador](./block_diagrams/mux_block_diagram.png)
*Figura 1: Multiplexador 2:1 com entradas in0, in1, seletor sel e saída mux_out*

## 3. Projeto RTL:

- Nessa etapa, foi criado em linguagem Verilog o arquivo multiplexor.v, responsável por descrever o comportamento do multiplexador.

## 4. Verificação RTL:

- Dando prosseguimento, criou-se um arquivo testbench (multiplexor_test.v) para a verificação funcional do multiplexador;
- Por meio do código "xrun multiplexor.v multiplexor_test.v", verifica-se o projeto do multiplexador (projetado com sucesso, conforme as imagems abaixo);
- Pode-se também acessar o SimVision por meio do código "xrun multiplexor.v multiplexor_test.v -gui -access +rwc" para vizualizar os resultados da simulação (conforme ilustra as imagens a abaixo).


## 5. Síntese: 

### 5.1 Síntese com Quartus II:
- 1° Passo: Verificar RTL via Xcelium/SimVision;
- 2° Passo: Prosseguir com a síntese+implementação no Quartus II.
  
### 5.2 Síntese com Genus: 
- 1° Passo: Síntese no Genus- Seu RTL é sintetizado para um netlist de portas lógicas genéricas (independente de tecnologia);
- 2° Passo: Preparação para o Quartus - O netlist e todos os arquivos de apoio são exportados;
- 3° Passo: Implementação no Quartus - O Quartus importa o netlist, mapeia essas portas genéricas para os primitivos específicos do Cyclone IV (LUTs, FFs, etc.), realiza o place-and-route e gera o arquivo de programação (.sof).


