require ['data'], (Gamedata) ->
  DEBUG_MODE = true

  dataStorage =
    fetch: ->
      data = Gamedata.default
      if localStorage.getItem(Gamedata.key) 
        data.player = JSON.parse(localStorage.getItem(Gamedata.key)) 
      data
    save: (data) ->
      localStorage.setItem(Gamedata.key, JSON.stringify(data))

  Vue.directive 'available', (value) ->
    @el.disabled = !value

  app = new Vue
    el: "#app"
    data: dataStorage.fetch()
    methods:
      solve: (problem) ->
        player = @player
        addGood = (g, isTake) ->
          if isTake 
            number = -1 * (g.number or 1)
          else
            number = g.number or 1
          added = false
          for one, index in player.goods
            if g.name is one.name
              unless one.number
                one.number = number + 1
              else
                one.number += number
              if one.number is 0
                player.goods.splice(index, 1)
              added = true
              break
          unless added
            player.goods.push g
        changeGoods = ->
          if problem.gain
            for one in problem.gain
              addGood one
          if problem.take
            for one in problem.take
              addGood one, true
        countedTime = 0
        problem.counting = true
        problem.percent = 0
        counting = setInterval ->
          countedTime += 0.097
          if DEBUG_MODE then countedTime += 1
          problem.percent = (countedTime / problem.time).toFixed(4)
          if countedTime >= problem.time
            clearInterval(counting)
            problem.counting = false
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
          unless problem.require
            return true
          for r in problem.require
            unless r in playerGoods
              return false
          true
      dismissFilter: (problems) ->
        playerGoods = for one in @player.goods
          one.name
        problems.filter (problem) ->
          unless problem.dismiss
            return true
          for r in problem.dismiss
            if r in playerGoods
              return false
          true
      defaultOne: (number) ->
        number or 1
      percentage: (n) ->
        (Math.floor(n * 10000) / 100).toFixed(1) + "%"
      solveAvailability: (takes) ->
        player = @$root.player
        console.log "takes", takes
        console.log "player.goods", player.goods
        getGoodsNumer = (good) ->
          for g in player.goods
            return g.number if g.name is good.name
          0
        unless takes
          return true
        for take in takes
          if take.number > getGoodsNumer(take)
            console.log "have no enough #{take.name}", getGoodsNumer(take)
            return false
        true
        