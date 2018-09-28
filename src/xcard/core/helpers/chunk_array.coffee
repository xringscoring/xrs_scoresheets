XCard.chunkArray =(arr, chunkSize)->
  return arr if ( (arr.length is 0) or (chunkSize is 1) )

  chunks = []
  i = 0
  n = arr.length

  while(i < n)
    chunks.push(arr.slice(i, i += chunkSize))

  chunks
