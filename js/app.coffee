require ['data'], (Gamedata) ->
  DEBUG_MODE = false

  dataStorage =
    fetch: ->
      data = Gamedata.default
      if localStorage.getItem(Gamedata.key) 
        data.player = JSON.parse(localStorage.getItem(Gamedata.key)) 
      data
    save: (data) ->
      localStorage.setItem(Gamedata.key, JSON.stringify(data))
    reset: ->
      localStorage.removeItem(Gamedata.key)

  clone = (src) ->
    JSON.parse JSON.stringify(src)

  Vue.directive 'available', (value) ->
    @el.disabled = !value

  app = new Vue
    el: "#app"
    data: dataStorage.fetch()
    methods:
      solve: (problem) ->
        player = @player
        addGood = (g, isTake) ->
          goodToAdd = clone(g)
          number = 0
          if isTake 
            number = -1 * (goodToAdd.number or 1)
          else
            number = goodToAdd.number or 1
          added = false
          for goods, index in player.goods
            if goodToAdd.name is goods.name
              unless goods.number
                goods.number = number + 1
              else
                goods.number = goods.number + number
              if goods.number is 0
                player.goods.splice(index, 1)
              added = true
              break
          unless added
            player.goods.push goodToAdd
        changeGoods = ->
          if problem.gain
            for gain in problem.gain
              addGood gain
          if problem.take
            for take in problem.take
              addGood take, true
        countedTime = 0
        problem.counting = true
        problem.percent = 0
        counting = setInterval ->
          countedTime += 1
          if DEBUG_MODE then countedTime += 10
          problem.percent = (countedTime / problem.time).toFixed(4)
          if countedTime >= problem.time
            clearInterval(counting)
            problem.counting = false
            if problem.reset
              player.level = 0
              player.goods = []
              dataStorage.save(player)
              return true
            changeGoods()
            player.level += 1 if problem.growth
            dataStorage.save(player)
        , 100
    filters:
      levelFilter: (problems) ->
        player = @player
        problems.filter (problem) ->
          return true unless problem.level 
          player.level in problem.level
      requireFilter: (problems) ->
        playerGoods = for one in @player.goods
          one.name
        problems.filter (problem) ->
          if not problem.require and not problem.dismiss
            return true
          if problem.require
            for r in problem.require
              unless r in playerGoods
                return false
          if problem.dismiss
            for r in problem.dismiss
              if r in playerGoods
                return false
          true
      defaultOne: (number) ->
        number or 1
      percentage: (n) ->
        (Math.floor(n * 10000) / 100).toFixed(1) + "%"
      solveAvailability: (takes, key) ->
        return false if this[key]
        player = @$root.player
        getGoodsNumer = (good) ->
          for g in player.goods
            return (g.number or 1) if g.name is good.name
          0
        unless takes
          return true
        for take in takes
          if take.number > getGoodsNumer(take)
            return false
        true
        