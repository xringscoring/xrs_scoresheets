XCard.extend

  uniqueArray: (ary) ->
    j = {}
    for e in ary
      j[ "#{e}#{typeof e}" ] = e

    Object.keys(j).map (v)->
      j[v]
  
