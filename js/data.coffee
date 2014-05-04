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
        ,
          level: 4
          name: "中年"
        ,
          level: 5
          name: "老年"
      ]
      problems: [
          level: [0]
          title: "什么都没有"
          dismiss: ["希望"]
          gain: [
              name: "希望"
          ]
          time: 30
        ,
          level: [0]
          title: "你没有生命"
          require: ["希望"]
          dismiss: ["生命"]
          gain: [
              name: "生命"
          ]
          growth: true
          time: 30
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
          level: [1]
          title: "你是一个婴儿"
          take: [
              name: "记忆"
              number: 5
          ]
          growth: true
          time: 60
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
          level: [3]
          title: "你是一个年轻人"
          take: [
              name: "经历"
              number: 5
            ,
              name: "压力"
              number: 3
            ,
              name: "破碎的心"
              number: 2
          ]
          growth: true
          time: 60
        ,
          level: [3..4]
          title: "你需要爱人"
          dismiss: ["爱人", "家庭"]
          gain: [
              name: "爱人"
          ]
          time: 20
        ,
          level: [3..4]
          title: "爱人离开了你"
          require: ["爱人"]
          take: [
              name: "爱人"
          ]
          gain: [
              name: "破碎的心"
          ]
          time: 20
        ,
          level: [3..4]
          title: "你需要工作"
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
        ,
          level: [4]
          title: "你是一个中年人"
          take: [
              name: "经历"
              number: 5
            ,
              name: "压力"
              number: 3
            ,
              name: "朋友"
              number: 5
          ]
          growth: true
          time: 60
        ,
          level: [4]
          title: "你需要结婚成家"
          require: ["爱人"]
          dismiss: ["家庭"]
          gain: [
              name: "家庭"
          ]
          time: 60
        ,
          level: [5]
          title: "你疾病缠身"
          take: [
              name: "金钱"
              number: 3
          ]
          time: 60
        ,
          level: [5]
          title: "你感到孤独"
          take: [
              name: "朋友"
              number: 5
          ]
          gain: [
              name: "希望"
          ]
          time: 60
        ,
          level: [5]
          title: "你在逐渐死去"
          take: [
              name: "希望"
            ,
              name: "生命"
          ]
          growth: true
          time: 600
        ,
          level: [6]
          title: "你死了"
          take: [
              name: "你拥有的一切"
          ]
          growth: true
          reset: true
          time: 600
        ]