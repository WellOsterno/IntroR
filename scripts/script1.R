# Introdução a R aplicado a Demografia - 1

### 1. Utilize # no inicio da linha para que o programa não a leia.
### Assim podemos utilizá-la para comentar o que estamos fazendo no código.
### 2. Após escrever o código, digite Ctrl + Enter para rodar/ativá-lo.
### podemos clicar em Run no canto superior direito desta tela também.


# Inserir (printar) uma string

print("Olá!")

# Fazer um cálculo

1+1

# Salvar uma informação em um objeto:

a <- 1+1

# "chamar" o objeto

a

# Identificar o tipo de variável do objeto

class(a)

##############################################
########    OPERAÇÕES NUMÉRICAS    ###########

# Soma

1 + 1 # 2

# Subtração

a-a # 0

# Divisão

1/1000 # 0.001

a/2 # 1

# Multiplicação

a*5 # 10

# Potência

a^2 # 4

# Radicialização

a^(1/2)

4^(1/2)

27^(1/3)

sqrt(4) # Especificamente para raiz quadrada

# Arredondamentos

pi

# a função round() arrendonda para o inteiro mais próximo
# podemos entender melhor essa função com ?round()

?round()

round(pi) 

# o argumento digits possibilita manter o número de casas decimais que queremos
round(pi, digits = 2)

# Mas também pode ser suprimido o nome do argumento
round(pi, 2)

# floor() retorna o valor inteiro mais próximo abaixo do valor de interesse
floor(pi)

# ceiling() retorna o valor inteiro mais próximo acima do valor
ceiling(pi)


##################################################
########    OPERAÇÕES DE COMPARAÇÃO    ###########

# Podemos utilizar as operações de comparação para dois objetos:

# Criando duas variáveis
x <- 10
y <- 5

# Igual a
x == y

# Diferente de
x != y 

# Maior que / Menor que
x > y  
x < y  

# Maior ou igual / Menor ou igual
x >= y # Retorna TRUE
x <= 2*y # Retorna FALSE

# Percebam que todos os resultados acima são valores lógicos ou booleanos (True/False)
class(x)
class(y)
class(x <= y) # logic

# Transformação da faixa etária será feita posteriormente

############################################################
########    TRANSFORMAÇÕES DE TEXTO (STRINGS)    ###########

# Utilizaremos o código de município do IBGE como exemplo.

# Salvar a informação em um objeto

campinas_codIBGE <- "350950 CAMPINAS"

# Contar caracteres

nchar(campinas_codIBGE) # 15


# Converter para maiúsculas e minúsculas

toupper(campinas_codIBGE)
tolower(campinas_codIBGE)

# Capitalizar (necessário pacote stringr)

# Instalar o pacote se ainda não está instalado. Se precisar instalar, retire o # abaixo.
# install.packages(stringr)

# Carregar o pacote
library(stringr)

str_to_title(tolower(campinas_codIBGE)) # "350950 Campinas"

# Extrair parte do texto - criando uma substring
substr(campinas_codIBGE, 1, 6) # "350950"

substr(campinas_codIBGE, 8, 16) # "CAMPINAS"

# Essas extrações podem ser feitas com stringr
str_sub(campinas_codIBGE, 1, 6)
str_sub(campinas_codIBGE, 8)

#Salvar os objetos código e município
codigo <- str_sub(campinas_codIBGE, 1, 6)
municipio <- str_sub(campinas_codIBGE, 8)

codigo
municipio

# Poderíamos também utilizar o espaço para fazer as duas substrings, independemente do número de caracteres em cada uma.
# Lista contendo "350950" e "CAMPINAS"

strsplit(campinas_codIBGE, " ")

# Acessar cada componente separadamente. O "[[1]]" é para acessar a primeira (e única) lista. 
# O [1] ou [2] acessa o elemento de tal lista.
strsplit(campinas_codIBGE, " ")[[1]][1]
strsplit(campinas_codIBGE, " ")[[1]][2]

# Substituir texto
sub("CAMPINAS", "SUMARÉ", campinas_codIBGE)

# Com stringr
str_replace(campinas_codIBGE, "CAMPINAS", "SUMARÉ")

# Remover caracteres específicos
gsub(pattern = "350950 ", replacement = "", x = campinas_codIBGE) # "CAMPINAS"
gsub("350950 ", "", campinas_codIBGE) # Podemos suprirmir os nomes dos argumentos pois eles estão na ordem correta sem pular argumentos.

# Verificar se contém um texto

grepl("CAMP", campinas_codIBGE)

str_detect(campinas_codIBGE, "CAMP")

# Juntar textos

paste("Município:", municipio)

paste(codigo, municipio, sep = " - ")

str_c(codigo, " - ", municipio)

paste(codigo,"-", municipio)

# Remover espaços extras
texto <- "   350950   CAMPINAS   "

# Retira espaços no começo e no fim
trimws(texto)

# Retira espaços no começo e no fim e espaços duplicados
str_squish(texto)

# Verificar se começa ou termina com determinado texto

startsWith(campinas_codIBGE, "350950")
endsWith(campinas_codIBGE, "CAMPINAS")

str_starts(campinas_codIBGE, "350950")
str_ends(campinas_codIBGE, "CAMPINAS")


############################################################
##############    CONVERSÃO DE VARIÁVEIS    ################

# Converter o código do município para tipo numeric

codigo_num <- as.numeric(codigo)

codigo_num

# Difinir escolaridade

escolaridade <- c(
  "Ensino fundamental",
  "Ensino médio",
  "Ensino técnico",
  "Ensino superior"
)

class(escolaridade)

# Transformação para factor
escolaridade <- factor(escolaridade)

# Tipo da variável
class(escolaridade)

# Podemos conferir os nível ordenados da variável
levels(escolaridade)

### Atenção para erros de conversão:
as.numeric("Campinas")

############################################################
##################    BASES DE DADOS    ####################

# Criar manualmente uma base de dados, formato Data.Frame:
# dentro da função data.fame, cada argumento é uma coluna
# à esquerda é o nome da coluna, à direita os seus elementos
exemplo <- data.frame(
  id = c(1,2,3,4),
  nome = c("Campinas","São Paulo", "Rio de Janeiro", "Natal"),
  un = c(50,80,40,40) #un = unidades escolares
)

# Podemos utilizar print() ou somente o nome do objeto para visualizá-lo
print(exemplo)
exemplo

# Instalar os pacotes via internet, se precisar
# install.packages("readxl")

library(readxl)

# Necesário ajustar o caminho do arquivo
# O caminho é o que identifica o arquivo que precisamos inserir.
# Neste caso estamos usando um formato específico por termos baixado todo o minicurso online.
# Para identificar o arquivo no seu computador, insira algo como:
# "C:/Users/usuario/Desktop/grafico/base.xlsx"
# lembre-se que cada computador tem caminhos e nomes diferentes. 

caminho <- "bases/base_pop.xlsx"
base_pop <- read_excel(caminho)

# A função head() apresenta as primeiras linhas da base, para termos uma noção da base.
head(base_pop)

# Visualizar as principais informações da base de dados

## nomes das colunas
names(base_pop)

# Com dplyr
#install.packages("dplyr)

library(dplyr)
glimpse(base_pop)

# Podemos acessar uma coluna específica com o comando básico do R
base_pop$Total

# Com dplyr
base_pop %>%
  select(Total)

# Ver somente a informação da população de 40 anos.
base_40 <- base_pop %>%
  filter(`Idade simples` == "40 anos")

head(base_40)

# Filtrar todas as idades com pelo menos 3 milhões de habitantes
base_pop %>%
  filter(Total >= 3000000)

# Conferir somente quais são as idades incluídas pelo filtro:
base_pop %>%
  filter(Total >= 3000000) %>%
  pull(`Idade simples`)

# Transformar a Idade Simpmles em uma nova coluna numérica
base_pop <- base_pop %>%
  mutate(
    idade_num = as.numeric(str_extract(string = `Idade simples`, pattern = "\\d+")))

# Conferir base
head(base_pop)

# Criar coluna da faixa etária
base_pop <- base_pop %>%
  mutate(
    faixa_etaria = case_when(
      idade_num == 0 ~ "0 a 1 ano",
      idade_num >= 1  & idade_num <= 4  ~ "1 a 4 anos",
      idade_num >= 5  & idade_num <= 9  ~ "5 a 9 anos",
      idade_num >= 10 & idade_num <= 14 ~ "10 a 14 anos",
      idade_num >= 15 & idade_num <= 19 ~ "15 a 19 anos",
      idade_num >= 20 & idade_num <= 24 ~ "20 a 24 anos",
      idade_num >= 25 & idade_num <= 29 ~ "25 a 29 anos",
      idade_num >= 30 & idade_num <= 34 ~ "30 a 34 anos",
      idade_num >= 35 & idade_num <= 39 ~ "35 a 39 anos",
      idade_num >= 40 & idade_num <= 44 ~ "40 a 44 anos",
      idade_num >= 45 & idade_num <= 49 ~ "45 a 49 anos",
      idade_num >= 50 & idade_num <= 54 ~ "50 a 54 anos",
      idade_num >= 55 & idade_num <= 59 ~ "55 a 59 anos",
      idade_num >= 60 & idade_num <= 64 ~ "60 a 64 anos",
      idade_num >= 65 & idade_num <= 69 ~ "65 a 69 anos",
      idade_num >= 70 & idade_num <= 74 ~ "70 a 74 anos",
      idade_num >= 75 & idade_num <= 79 ~ "75 a 79 anos",
      idade_num >= 80 ~ "80 anos e mais",
      TRUE ~ as.character(`idade_num`)
    )
  )

head(base_pop)

# Agrupar a base em grupos quinquenais
# Criar um novo objeto é uma boa prática importante
base_quinquenal <- base_pop %>%
  group_by(faixa_etaria) %>%
  summarise(pop = sum(Total))

head(base_quinquenal)

# Corrigir a ordem das faixas etárias
ordem_idade <- c(
  "0 a 1 ano",  "1 a 4 anos",  "5 a 9 anos",  "10 a 14 anos",  "15 a 19 anos",  "20 a 24 anos",  "25 a 29 anos",
  "30 a 34 anos",  "35 a 39 anos",  "40 a 44 anos",  "45 a 49 anos",  "50 a 54 anos",  "55 a 59 anos",  "60 a 64 anos",
  "65 a 69 anos",  "70 a 74 anos",  "75 a 79 anos",  "80 anos e mais"
)

# A função arrange realiza o ordenamento da base da forma desejada.
base_quinquenal <- base_quinquenal %>%
  arrange(match(faixa_etaria,ordem_idade)) #ordem correta das faixas etárias

############################################################
######################    FUNÇÕES    #######################

# Estamos chamando de somasub por ser uma soma de valores subsequentes
somasub <- function(x){
  sum(x,x+1,x+2)
}

# Aplicação
somasub(10)

somasub(567)

# Outro exemplo, é a criação de nomes com o mesmo sobrenome:
fnomes <- function(fname) {
  paste(fname, "Oliveira")
}

fnomes("Pedro")
fnomes("Ana")
fnomes("Rosa")

# Conjunto de número entre 0 e 6
cjt <- c(0,1,2,3,4,5,6)

# Média calculada manualmente
soma <- sum(cjt)
contagem <- length(cjt)
soma/contagem # média

# Média a partir da função mean()
mean(cjt)

sd(cjt)

# Documentação do pacote
?dplyr

# Documentação da função
?select
?arrange

?mean