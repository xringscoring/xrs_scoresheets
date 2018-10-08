#= require_self

window.addEventListener 'load', (e)->
  mappedRounds = window.TARGET_ROUNDS.reduce( (m, tR)->
    m[tR['short_name']] = tR
    return m
  , {})

  getRandomScore = (min, max)->
    Math.floor(Math.random() * (max - min + 1)) + min

  getScoreData = (shortName)->
    return {} unless window.SHOOT_DATA?
    window.SHOOT_DATA[newRound] ? {}

  evenizedScore = (score)->
    2 * Math.round(score / 2)

  updateRoundName = (name)->
    roundNameSpan = document.getElementById('round-name')
    roundNameSpan.innerText = "[ #{name } ]"

  buildTable = (newRound, bowType)->
    html = "<thead></thead>"

    tData = mappedRounds[newRound]

    tableElement = document.getElementById('xcard-table')

    scorecard = new XCard.Scorecard({
      targetRoundDefinition: tData
      tableElement: tableElement
      scoreData: getScoreData(newRound)
      bowType: bowType
    })

    tableElement.innerHTML = scorecard.html()

    updateRoundName(tData['name'])

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
