library(DBI)

con <- dbConnect(RSQLite::SQLite(), file.path(here::here("Databases"), path = "test.db"))
dbListTables(con)
dbWriteTable(con, "mtcars", mtcars)
dbListTables(con)
dbListFields(con, "mtcars")
res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")install.packages("dbplyr")
dbFetch(res)
dbClearResult(res)
res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
while (!dbHasCompleted(res)){
  chunk <- dbFetch(res, n = 5)
  print(nrow(chunk))
}
dbClearResult(res)
dbDisconnect(con)
