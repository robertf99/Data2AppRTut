installIfNotExists = function(x){
  allPkgs = installed.packages()
  if(!x%in% allPkgs){
    install.packages(x)
  }
}

installIfNotExists('DBI')
installIfNotExists('RSQLite')
installIfNotExists('request')
installIfNotExists('plumber')
installIfNotExists('plotly')
installIfNotExists('shiny')


