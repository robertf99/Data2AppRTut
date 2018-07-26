source('requirements.R')
data_url = "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
data_cols = list(
  c('age', 'i'),
  c('workclass', 'c'),
  c('fnlwgt', 'i'),
  c('education', 'c'),
  c('education_num', 'i'),
  c('marital_status', 'c'),
  c('occupation', 'c'),
  c('relationship', 'c'),
  c('race', 'c'),
  c('sex', 'c'),
  c('capital_gain', 'i'),
  c('capital_loss', 'i'),
  c('hours_per_week', 'i'),
  c('native_country', 'c'),
  c('class_label', 'c')
)

data_folder = "./data"
dir.create(data_folder)

data_path = paste0(getwd(),'/data/adult.csv')
data_fn = file(data_path,'w')

db_fn = paste0(getwd(),'/data/database')

download_data = function(){
  write_lines(GET(data_url), data_fn)
  close(data_fn)
}

create_db = function(){
  con = dbConnect(SQLite(),db_fn)
  dbDisconnect(con)
}

load_data = function(){
  df = read_csv(data_path,
                col_names = sapply(data_cols, function(x)x[1]),
                col_types = lapply(data_cols, function(x)x[2]))
  con = dbConnect(SQLite(),db_fn)
  dbWriteTable(con, 'adult', df)
  dbDisconnect(con)
}

#############
# Main
#############
download_data()
create_db()
load_data()

##################
# Run host for api
#################
r=plumb('./app/api.R')
r$run(port=8000)

