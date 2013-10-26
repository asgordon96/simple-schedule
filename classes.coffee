$ ->
  $.get("class_schedule.csv", (data, other) -> 
    data = data.split("\n")
    data = (line.split(",") for line in data)
    data_by_block = { A:[], B:[], C:[], D:[], E:[], F:[] }
    for line in data
      data_by_block[line[0]].push(line)
    
    for block in Object.keys(data_by_block)
      list = $(".#{block}")
      for class_data in data_by_block[block]
        item = $("<li></li>").text("#{class_data[2]}")
        item.data(class_data)
        html_string = "<h3>#{class_data[2]}</h3><p>#{class_data[3]}</p><p>Room: #{class_data[4]}</p>"
        item.popup({on:'click', html:html_string})
        list.append(item)
      
    filter_by_subject = (subject) ->
      items = $("li")
      items.removeClass("selected")
      for i in [0...items.length]
        list_item = $(items[i])
        if list_item.data()[1] == subject
          list_item.addClass("selected")
      
    $("select").change( -> filter_by_subject($("select").val()) )
  )