# Introdução a R aplicado a Demografia - 2

### 1. Utilize # no inicio da linha para que o programa não a leia.
### Assim podemos utilizá-la para comentar o que estamos fazendo no código.
### 2. Após escrever o código, digite Ctrl + Enter para rodar/ativá-lo.
### podemos clicar em Run no canto superior direito desta tela também.




# Se não tem remotes instalado, retire o # da linha abaixo.
# install.packages("remotes")

# requires the development version of rstan, sorry!
# install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
# remotes::install_github("timriffe/DemoTools")

# Conferir o helper de Demotools
?DemoTools



##############################################################
########    Avaliação de preferência por dígito    ###########



# Importar a base de dados

library(readxl)

pop_single <- readxl::read_excel("bases/base_pop_s_age.xlsx")

# O caminho (nas aspas acima) é o que identifica o arquivo que precisamos inserir.
# Neste caso estamos usando um formato específico por termos baixado todo o minicurso online.
# Para identificar o arquivo no seu computador, insira algo como:
# "C:/Users/usuario/Desktop/grafico/base.xlsx"
# lembre-se que cada computador tem caminhos e nomes diferentes. 


# Visualizar a base
head(pop_single)

# Ferramenta básica do R
br_vetor <- pop_single$`Brasil, 1970`
co_vetor <- pop_single$`Colômbia, 1973`
mo_vetor <- pop_single$`Moçambique, 1997`
Age <- pop_single$Idade

# Com dplyr
# Perceba   que não estamos salvando o resultado no objeto, então o que vale é o que fizemos anteriormente.

library(dplyr)
pop_single %>%
  pull(`Brasil, 1970`)


# Cálculo do Índice de Whipple por país

library(DemoTools)

br_whippleI <-  check_heaping_whipple(
  Value = br_vetor, 
  Age = Age, 
  ageMin = 23, 
  ageMax = 62, 
  digit = c(0, 5)
)

co_whippleI <- check_heaping_whipple(
  Value = co_vetor, 
  Age = Age, 
  ageMin = 23, 
  ageMax = 62, 
  digit = c(0, 5)
)

mo_whippleI <- check_heaping_whipple(
  Value = mo_vetor, 
  Age = Age, 
  ageMin = 23, 
  ageMax = 62, 
  digit = c(0, 5)
)

print(br_whippleI)
print(co_whippleI)
print(mo_whippleI)



################################################################
########    INTERPOLAÇÃO DA CONTAGEM POPULACIONAL    ###########



# Importar a base da população de moçambique por quinquenio
pop_abr <- readxl::read_excel("bases/base_pop_abr_age.xlsx")

# Visualizar a base
head(pop_abr)

# argumentos da função:
# Value:
mo_abr_vetor <- pop_abr$pop

library(stringr)

# Age
AgeAbr <- pop_abr %>%
  mutate(
    Age =  
      as.numeric(str_extract(
        string = pop_abr$Idade, 
        pattern = "\\d+"))
  ) %>%
  pull(Age)

print(mo_abr_vetor)
print(AgeAbr)

# Aplicar a função para interpolar

sprague <- graduate(
  Value = mo_abr_vetor, 
  Age = AgeAbr, 
  method = "sprague")

single_age  <- names2age(sprague) # identifica a idade simples a partir do vetor criado pela função graduate.

print(sprague)



################################################################
#############    CONTRUÇÃO DA TABELA DE VIDA    ################


# Importar as taxas específicas de mortalidade 
nmx <- read_excel("bases/nmx_br_m_2022.xlsx")

head(nmx)

# Definir as faixas etárias
AgeLT <- nmx %>%
  mutate(
    age =  
      as.numeric(str_extract(
        string = idade, 
        pattern = "\\d+"))
  ) %>%
  pull(age)

# Definir as taxas específicas de mortalidade
tem <- nmx$nmx

# Tabela de vida por idade simples até 100 anos ou mais
br22 <- lt_abridged2single(
  nMx = tem,
  Age = AgeLT,
  axmethod = "un",
  OAG = TRUE, # True se o ultimo grupo é aberto
)

View(br22) # para ver a tabela completa
head(br22) # para ver só as primeiras cinco linhas



#############################################
#############    GRÁFICOS    ################

# População de moçambique por idade simples
# utilizando o pacote basico do R
plot(Age, mo_vetor,
     xlab="Idade",
     ylab="População",
     type='l',
     main="População por idade simples em Moçambique (1997)")

# População de moçambique por idade simples
# utilizando o ggplot2

# install.packages(ggplot2)
library(ggplot2)

df1 <- data.frame(
  Age = Age,
  Populacao = mo_vetor
)

ggplot(
  data=df1, 
  aes(x = Age, y = Populacao)) +
  geom_line(linewidth = 0.8) +
  labs(
    title = "População por idade simples em Moçambique (1997)",
    x = "Idade",
    y = "População"
  ) +
  theme_minimal(base_size = 12)



# Interpolação da população e a população observada
# Base para o gráfico
df2 <- data.frame(
  Idade = single_age,
  Sprague = sprague,
  MO = mo_70
)

# Criação do gráfico com o ggplot2
ggplot(df2, aes(x = Idade)) +
  geom_line(
    aes(y = Sprague, color = "Sprague"),
    linewidth = 1
  ) +
  geom_line(
    aes(y = MO, color = "Observado - 1997"),
    linewidth = 0.7
  ) +
  scale_color_manual(
    name = "Método",
    values = c(
      "Sprague" = "black",
      "Observado - 1997" = "red"
    )
  ) +
  labs(
    title = "Interpolação com método de Sprague",
    x = "Idade",
    y = "População"
  ) +
  theme_classic(base_size = 10)


################################################################
###############    EXPORTAÇÃO DE ARQUIVOS    ###################

# install.packages(openxlsx)
library(openxlsx)

# Exportar base de dados

write.xlsx(
  x=br22,
  file="bases/br22.xlsx")

# Exportar gráficos em jpeg

graf <- ggplot(
  data=df1, 
  aes(x = Age, y = Populacao)) +
  geom_line(linewidth = 0.8) +
  labs(
    title = "População por idade simples em Moçambique (1997)",
    x = "Idade",
    y = "População"
  ) +
  theme_minimal(base_size = 12)

ggsave(
  filename = "bases/grafico.jpeg",
  plot = graf,
  width = 12,
  height = 7
)


###############################################
###############    LOOPS    ###################

# 1. Exemplo inicial

# difinir o conjunto
numeros <- c(2, 4, 6, 8)

# definir o início da soma
soma <- 0

# loop da soma

for(n in numeros){
  
  soma <- soma + n
  print(soma)
}

print("resultado fora do loop")

# 2. Loop para o Índice de Whipple

# primeiro criamos o conjunto de países
paises <- c("Brasil, 1970","Colômbia, 1973","Moçambique, 1997")

# Dentro do loop, o "p" no argumento Value indica qual coluna está sendo usada da base "pop_single", da mesma forma que criamos os vetores dos países

for (p in paises) {
  resultado <- check_heaping_whipple(
    Value = pop_single[[p]], 
    Age = Age, 
    ageMin = 23, 
    ageMax = 62, 
    digit = c(0, 5)
  )
  
  print(resultado)
}