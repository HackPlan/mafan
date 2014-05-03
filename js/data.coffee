define [], ->
    key: "mafan-data"
    default: 
      player:
        level: 0
        goods: []
      levels: [
          level: 0
        ,
          level: 1
          name: "婴儿"
        ,
          level: 2
          name: "小孩儿"
        ,
          level: 3
          name: "青年"
      ]
      problems: [
          title: "什么都没有"
          dismiss: ["希望"]
          gain: [
              name: "希望"
          ]
          time: 30
        ,
          title: "你没有生命"
          require: ["希望"]
          dismiss: ["生命"]
          gain: [
              name: "生命"
          ]
          growth: true
          time: 30
        ,
          level: [1]
          title: "你是一个婴儿"
          require: ["记忆"]
          take: [
              name: "记忆"
              number: 5
          ]
          growth: true
          time: 60
        ,
          level: [1..4]
          title: "你需要学习"
          gain: [
              name: "知识"
          ]
          time: 60
        ,
          level: [1..4]
          title: "你需要玩耍"
          gain: [
              name: "记忆"
          ]
          time: 30
        ,
          level: [2]
          title: "你是一个小孩儿"
          take: [
              name: "知识"
              number: 5
            ,
              name: "经历"
              number: 3
          ]
          growth: true
          time: 60
        ,
          level: [2..4]
          title: "你需要朋友"
          gain: [
              name: "朋友"
          ]
          time: 20
        ,
          level: [2..4]
          title: "你厌倦了朋友"
          require: ["朋友"]
          take: [
              name: "朋友"
          ]
          gain: [
              name: "经历"
          ]
          time: 10
        ,
          level: [2..4]
          title: "你需要工作"
          require: ["知识"]
          gain: [
              name: "压力"
            ,
              name: "金钱"
          ]
          time: 30
        ,
          title: "你需要放松"
          require: ["压力"]
          take: [
              name: "压力"
          ]
          time: 30
        
        ]