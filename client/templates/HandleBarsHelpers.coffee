Handlebars.registerHelper "prettifyDate", (timestamp) ->
  new Date(timestamp).toString('dd-MM-yyyy')

Handlebars.registerHelper "bool", (boolean)->
  boolean ? "true":"false"

Handlebars.registerHelper "age", (timestamp)->
  Math.floor((new Date() - timestamp) / (1000*60*60*24)) + " days old"