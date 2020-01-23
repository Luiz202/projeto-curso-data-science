##### SETUP #####

# setando diretorio
setwd("../../data/raw")

# pacotes
pcts <- c("rtweet","httpuv", "dplyr","readxl")
install.packages(pcts)
lapply(pcts, library, character.only = T)
library(rtweet, httpuv, dplyr)

# criação do Token
source("secret.R") # tokens
# Só executar uma vez
token <- create_token(
  app = "StalkerBot3000",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)
# Get_token pra testar 
get_token()

##### Declarações #####
infl_base <- read_xlsx(path = "infl_base.xlsx")
counter <- 1
# lembrar de fazer a lista lourenço seu retardado 

##### Actual Fucking Code #####
infl_screenname <- readline(prompt = "Digite o nome do influencer a ser analisado (sem o @)\n")

# pegar 100 seguidores 
# (talvez devessemos alterar isso para ser uma porcentagem mas acho que demore demais muito mais que 100)
infl_flw <- get_followers(infl_screenname, n = 100)

# for pra anotar os amigos dos seguidores
for (flw in infl_flw$user_id) {
  flw_fds <- get_friends(users = flw, retryonratelimit = TRUE, n = 5000)
  print(paste("Amigos do usuario", flw, "armazenados"))
  join_infl_fds<- inner_join(infl_base, flw_fds, by = "user_id")
}


##### testes estupidos
fds <- get_friends("3000Stalker")

rm(fds_data)

print(lookup_users("communistbops")$user_id)


