# Fluxo-de-Design-Digital-usando-ferramentas-CADENCE
Este repositório documenta detalhadamente as etapas referentes ao FRONT-END do fluxo de design digital utilizando as ferramentas CADENCE para um multiplexador de endereços. 

## 1. Especificações 
-O multiplexador de endereços seleciona entre o endereço da instrução durante a fase de busca da instrução e o endereço do operando durante a fase de execução da instrução;
-A largura do MUX é parametrizada com o valor padrão de 5;
-Se sel for 1'b0, a entrada in0 é passada para a saída mux_out;
-Se sel for 1'b0, a entrada in0 é passada para a saída mux_out. 

## 2. Projeto de arquitetura 

![Diagrama do Multiplexador](./block_diagrams/mux_block_diagram.png)
*Figura 1: Multiplexador 2:1 com entradas in0, in1, seletor sel e saída mux_out*
