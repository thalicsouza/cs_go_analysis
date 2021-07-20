# cs_go_analysis
Repositório para armazenar projeto com análises sobre partidas de CS:GO

## Modelo para previsão de engajamento

### Linguagens e versões
Python 3.7

PyCaret 2.3.2

SQL

### Dicionário de dados
![dicionario](https://user-images.githubusercontent.com/30202443/126378627-e54db2cf-0fd0-4ea3-80b4-d3b5275c21bf.PNG)

### Arquivos
- ABT: tabela utilizada para treinamento e validação do modelo
- Val_predictions: tabela utilizada para fazer o scoring do modelo
- Dicionario_dados: tabela com o formato e descrição de das variáveis da ABT
- ETL.sql: query utilizada para criação da ABT
- general_queries.sql: todas as queries utilizadas para responder às perguntas do teste  
- GC_case.ipynb: notebook utilizado na construção do modelo preditivo
- Final_GradientBoosting_Classifier_jul21.pkl: arquivo que armazena o modelo validado

