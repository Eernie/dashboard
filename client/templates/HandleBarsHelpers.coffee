Handlebars.registerHelper "prettifyDate", (timestamp) ->
  new Date(timestamp).toString('dd-MM-yyyy')