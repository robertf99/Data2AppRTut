##################
# Run host for api
#################
r=plumb('./app/api.R')
r$run(port=8000)