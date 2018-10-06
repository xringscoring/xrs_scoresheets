#= require_self

window.addEventListener 'load', (e)->
  mappedRounds = window.TARGET_ROUNDS.reduce( (m, tR)->
    m[tR['short_name']] = tR
    return m
  , {})

  buildTable = (newRound, bowType)->
    html = "<thead></thead>"

    tData = mappedRounds[newRound]
    tRound = new XCard.TargetDataAdapter(tData, bowType)

    for d in tRound.distances
      config = new XCard.DistanceConfig(d)
      block = new XCard.DistanceBlock({config: config})
      html = html + block.toHtml().outerHTML

    table = document.getElementById('xcard-table')
    table.innerHTML = html

    document.getElementById('hiddenBlock').style.display = "block"

  selector = document.getElementById('chooseRound')
  for tRound in window.TARGET_ROUNDS
    option = document.createElement("option")
    option.value = tRound['short_name']
    option.text = tRound['name']
    selector.appendChild(option)

  document.getElementById("chooseRound").addEventListener 'change', (event)->
    newRound = event.target.value
    bowType = document.getElementById('bowType').value
    if newRound isnt ''
      buildTable(newRound, bowType)


  document.getElementById("bowType").addEventListener 'change', (event)->
    bowType = event.target.value
    newRound = document.getElementById('chooseRound').value
    buildTable(newRound, bowType)
