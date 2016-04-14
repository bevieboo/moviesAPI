options = {
  adapter: 'postgresql',
  database: 'omdb'
}
ActiveRecord::Base.establish_connection(options)
