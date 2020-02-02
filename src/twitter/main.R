##### SETUP #####

# setando diretorio
setwd("../../data/raw")

# pacotes
pcts <- c("rtweet","httpuv", "dplyr","readxl")
install.packages(pcts)
lapply(pcts, library, character.only = T)
library(rtweet, httpuv, dplyr)

# criacao do Token
source("../../src/twitter/secret.R") # tokens
# So executar uma vez
token <- create_token(
  app = "StalkerBot3000",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)
# Get_token pra testar 
get_token()

##### Declaracoes #####
infl_base <- read_xlsx(path = "../../data/processed/infl_base.xlsx")
flw_num <- 75
interesse <- list(bot=0,
                   humor=0,
                   animais=0,
                   politica=0,
                   youtuber=0,
                   esquerda=0,
                   jornalista=0,
                   dev=0,
                   ciencia=0,
                   musica=0,
                   anime=0,
                   geek=0,
                   audiovisual=0,
                   arte=0,
                   lgbtq=0,
                   Na=0
                  )
##### Actual Fucking Code #####
infl_screenname <- readline(prompt = "Digite o nome do influencer a ser analisado (sem o @)\n")

# pegar 100 seguidores 
# (talvez devessemos alterar isso para ser uma porcentagem mas acho que demore demais muito mais que 100)
infl_flw <- get_followers(infl_screenname, n = flw_num)

# for pra anotar os amigos dos seguidores
for (flw in infl_flw$user_id) {
  tryCatch(expr = { flw_fds <- get_friends(users = flw, retryonratelimit = TRUE, n = 5000) },
         warning = function(w) {
           print(w)
           erro <- w
           Sys.sleep(60*15)
         }  )
  print(paste("Amigos do usuario", flw, "armazenados"))
  if ("user_id" %in% colnames(flw_fds)) {
    print("ya")
  join_infl_fds<- inner_join(infl_base, flw_fds, by = "user_id")
  for (infl_fds in join_infl_fds$categoria_1) {
    print(infl_fds)
    interesse[infl_fds] <- interesse[[infl_fds]] + 1
  }
  for (infl_fds in join_infl_fds$categoria_2) {
    print(infl_fds)
    interesse[infl_fds] <- interesse[[infl_fds]] + 1
  }
  print(paste("Interesses de", flw, "armazenados"))
  }
}

print("Interesses dos seguidores analisados, criando arquivo com resultados")

resultado <- data.frame(
  screenname = infl_screenname,
  user_id = lookup_users(infl_screenname)$user_id,
  flw_num = flw_num,
  data_coleta = date(),
  bot = interesse$bot,
  humor = interesse$humor,
  animais = interesse$animais,
  politica = interesse$politica,
  youtuber = interesse$youtuber,
  esquerda = interesse$esquerda,
  jornalista = interesse$jornalista,
  dev= interesse$dev,
  ciencia= interesse$ciencia,
  musica= interesse$musica,
  anime= interesse$anime,
  geek= interesse$geek,
  audiovisual= interesse$audiovisual,
  arte= interesse$arte,
  lgbtq= interesse$lgbtq,
  Na= interesse$Na
)

arq_name <- paste(infl_screenname, Sys.Date(), sep = "_")


saveRDS(resultado, file = paste(arq_name,"rds", sep = "."))
print("Salvado em RDS")

write.csv(resultado, file = paste(arq_name,"csv", sep = "."))
print("Salvado em CSV")

##### testes estupidos
fds <- get_friends("3000Stalker")

rm(interesses)

print(lookup_users("quadroembranco")$user_id)

for (infl_fds in join_infl_fds$categoria_1) {
  print(infl_fds)
}

interesse[infl_fds] <- interesse[infl_fds] + 1
typeof(infl_fds)
a <- "animais"
typeof(a)
interesse[a] <- interesse[[a]] + 1
typeof(interesse[[a]])

base_teste <- interesse
infl <- lookup_users(infl_screenname)


lol <- data.frame(roupa = interesse[[bot]])
rm(resultado)
interesse
date()

Sys.Date()

interesse$bot

get_friends(1206358247508234241)
