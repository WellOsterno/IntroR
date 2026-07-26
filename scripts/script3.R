# Introdução a R aplicado a Demografia - 3

### 1. Utilize # no inicio da linha para que o programa não a leia.
### Assim podemos utilizá-la para comentar o que estamos fazendo no código.
### 2. Após escrever o código, digite Ctrl + Enter para rodar/ativá-lo.
### podemos clicar em Run no canto superior direito desta tela também.

# Criar a base fictícia de pessoas
pessoas <- data.frame(
  id= 1:10,
  nome = c(
    "Ana", "Bruno", "Carlos", "Daniela", "Eduardo",
    "Fernanda", "Gabriel", "Helena", "Igor", "Julia"
  ),
  sexo = c(
    "F","M","M","F","M",
    "F","M","F","M","F"
  )
)

# Criar a base fictícia de renda
renda <- data.frame(
  id= 1:10,
  renda = c(
    2500, 4200, 3100, 2800, 5200,
    3300, 2100, 4700, 3900, 2600
  )
)

# Carregar pacote necessário
library(dplyr)

# Comando para o unir as bases
# ?left_join
# ?join()

base1 <- left_join(
  x=pessoas,
  y=renda,
  by="id"
)

head(base1)


# Código dos município
# IBGE: RELATÓRIO DE DIVISÃO TERRITORIAL BRASILEIRA (2024)

municipios <- data.frame(
  cod_mun = c(3509502, 3550308, 5300108),
  municipio = c(
    "Campinas",
    "São Paulo",
    "Brasília"
  )
)

domicilios <- data.frame(
  id_dom = 1:10,
  cod_mun = c(
    3509502,3509502,3509502,
    3550308,3550308,3550308,3550308,
    5300108,5300108,5300108
  ),
  moradores = c(
    2,4,5,
    3,2,6,1,
    4,5,2
  )
)

# Join entre as duas bases a partir do código do município
base2 <- left_join(
  domicilios,
  municipios,
  "cod_mun"
)

# Perceba que agora temos o nome do município por linha. Podemos utilizar, por exemplo, para criar um gráfico.
head(base2)

# Dados fictícios

# Base de população do município por ano
populacao <- data.frame(
  municipio = c(
    "Campinas","Campinas",
    "São Paulo","São Paulo",
    "Brasília","Brasília"
  ),
  ano = c(
    2022,2023,
    2022,2023,
    2022,2023
  ),
  populacao = c(
    1214000,1223000,
    12325000,12396000,
    2817000,2853000
  )
)

# Base de óbitos do município por ano
obitos <- data.frame(
  municipio = c(
    "Campinas","Campinas",
    "São Paulo","São Paulo",
    "Brasília","Brasília"
  ),
  ano = c(
    2022,2023,
    2022,2023,
    2022,2023
  ),
  obitos = c(
    8200,8400,
    96500,97800,
    18100,18400
  )
)

# Join com duas chaves primárias
left_join(
  populacao,
  obitos,
  by=c("municipio","ano")
)

# Criar um join com uma coluna quando deveria ser duas
left_join(
  populacao,
  obitos,
  by=c("municipio")
)

municipios2 <- data.frame(
  codigo = c(3509502, 3550308, 5300108),
  municipio = c(
    "Campinas",
    "São Paulo",
    "Brasília"
  )
)

domicilios2 <- data.frame(
  id_dom = 1:10,
  cod_mun = c(
    3509502,3509502,3509502,
    3550308,3550308,3550308,3550308,
    5300108,5300108,5300108
  ),
  moradores = c(
    2,4,5,
    3,2,6,1,
    4,5,2
  )
)

left_join(
  municipios2,
  domicilios2,
  by= join_by(codigo == cod_mun),
)

