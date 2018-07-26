#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer unboxedJSON
#* @get /data
function(){
  con = dbConnect(SQLite(),db_fn)
  df = dbGetQuery(con, 
                  'SELECT 
                  age,
                  education_num,
                  SUM(fnlwgt) as value
                FROM adult
                  WHERE sex = \'Female\'
                GROUP BY
                  age,
                  education_num'
  )
  dbDisconnect(con)
  return(df)
}
