#import "../lib/mod.typ": card
#import "../lib/card/types.typ": card_kind, frame_family, make_frame, monster_frame
#card(
    atk: 5000,
    attribute: "earth",
    card_image: 23288411,
    def: 5000,
    description: "这张卡不能通常召唤。让这张卡以外的自己的手卡·墓地的「莫忘」怪兽5种类各1只回到卡组·额外卡组的场合才能从手卡·墓地特殊召唤。\n①：自己场上没有其他怪兽存在的场合，这张卡可以向对方怪兽全部各作1次攻击。②：1回合1次，对方把魔法·陷阱·怪兽的效果发动的场合才能发动。从自己的手卡·墓地把1只「莫忘」怪兽特殊召唤。",
    frame: make_frame(card_kind.monster, monster_frame.effect),
    id: 23288411,
    level: 11,
    name: "冥骸合龙-莫忘冥地王灵",
    type_line: "【幻龙族/特殊召唤/效果】",
)

#card(
    atk: 2400,
    attribute: "dark",
    card_image: 13332685,
    def: 1800,
    description: "「巳剑降临」降临\n这个卡名的①的效果在决斗中只能使用1次，③的效果1回合只能使用1次。\n①：把手卡的这张卡给对方观看才能发动。从卡组把1只「巳剑」怪兽特殊召唤。那之后，自己场上1只怪兽解放。②：对方场上的怪兽的攻击力下降800。③：这张卡被解放的场合才能发动。从卡组把「天羽羽斩之巳剑」以外的1张「巳剑」卡加入手卡。那之后，可以把这张卡特殊召唤。",
    frame: make_frame(card_kind.monster, monster_frame.ritual),
    id: 13332685,
    level: 8,
    name: "天羽羽斩之巳剑",
    type_line: "【爬虫族/仪式/效果】",
)

#card(
    atk: 3100,
    attribute: "light",
    card_image: 56733747,
    def: 2500,
    description: "「元素英雄 新宇侠」＋「翼侠」融合怪兽\n这张卡不用融合召唤不能特殊召唤。这个卡名的①的效果1回合只能使用1次。\n①：这张卡特殊召唤的场合才能发动。把最多有场上的怪兽的属性种类数量的对方场上的卡破坏。②：场上的这张卡攻击力上升自己墓地的怪兽数量×300，不会被效果破坏。③：这张卡战斗破坏怪兽的场合发动。给与对方那只怪兽的原本攻击力数值的伤害。",
    frame: make_frame(card_kind.monster, monster_frame.fusion),
    id: 56733747,
    level: 8,
    name: "元素英雄 闪光新宇翼侠",
    type_line: "【战士族/融合/效果】",
)

#card(
    atk: 400,
    attribute: "light",
    card_image: 35952884,
    def: 4000,
    description: "同调怪兽调整＋调整以外的同调怪兽2只以上\n这张卡不用同调召唤不能特殊召唤。\n①：这张卡在同1次的战斗阶段中可以作出最多有那些作为同调素材的怪兽之内除调整以外的怪兽数量的攻击。②：1回合1次，魔法·陷阱·怪兽的效果发动时才能发动。那个发动无效并破坏。③：表侧表示的这张卡从场上离开时才能发动。从额外卡组把1只「流星龙」特殊召唤。",
    frame: make_frame(card_kind.monster, monster_frame.synchro),
    id: 35952884,
    level: 12,
    name: "流天类星龙",
    type_line: "【龙族/同调/效果】",
)

#card(
    atk: 4000,
    attribute: "light",
    card_image: 48348921,
    def: 3000,
    description: "光属性8星怪兽×3\n这张卡也能在自己场上的「No.62 银河眼光子龙皇」上面重叠来超量召唤。\n①：自己战斗阶段开始时，把这张卡1个超量素材取除才能发动。这张卡在这次战斗阶段中最多3次可以向怪兽攻击。②：这张卡有「银河眼光子龙」在作为超量素材的场合，得到以下效果。●这张卡不受对方怪兽的效果影响。●这张卡的攻击力上升这张卡作为超量素材中的怪兽的等级·阶级的合计×100。",
    frame: make_frame(card_kind.monster, monster_frame.xyz),
    id: 48348921,
    level: 8,
    name: "混沌No.62 超银河眼光子龙皇",
    type_line: "【龙族/超量/效果】",
)

#card(
    atk: 4000,
    attribute: "dark",
    card_image: 13331639,
    def: 4000,
    description: "龙族的融合·同调·超量·灵摆怪兽各1只合计4只\n这张卡不用融合召唤不能特殊召唤。\n①：这张卡特殊召唤的场合发动。对方场上的卡全部破坏。②：这张卡不会被对方的效果破坏，对方不能把这张卡作为效果的对象。③：这张卡战斗破坏对方怪兽时才能发动。从卡组·额外卡组把1只「霸王眷龙」怪兽特殊召唤。④：怪兽区域的这张卡被战斗·效果破坏的场合才能发动。这张卡在自己的灵摆区域放置。",
    frame: make_frame(card_kind.monster, monster_frame.fusion, family: frame_family.pendulum),
    id: 13331639,
    level: 12,
    name: "霸王龙 扎克",
    pendulum_description: "①：只要这张卡在灵摆区域存在，对方不能把场上的融合·同调·超量怪兽的效果发动。②：1回合1次，抽卡阶段以外从卡组有卡加入对方手卡时才能发动。那些卡破坏。",
    scale: 12,
    type_line: "【龙族/灵摆/融合/效果】",
)

#card(
    atk: 2300,
    attribute: "dark",
    card_image: 86066372,
    description: "效果怪兽2只以上\n对方不能对应这张卡的效果的发动把效果发动。\n①：这张卡连接召唤的场合，以那1只作为连接素材的连接怪兽为对象才能发动。这张卡的攻击力上升那只怪兽的连接标记数量×1000。②：从自己的场上·墓地把1只连接怪兽除外才能发动。对方场上1张卡破坏。这个回合，自己不能为让「访问码语者」的效果发动而把相同属性的怪兽除外。",
    frame: make_frame(card_kind.monster, monster_frame.link, family: frame_family.link),
    id: 86066372,
    link_markers: (
        bottom: true,
        left: true,
        right: true,
        top: true,
    ),
    link_value: 4,
    name: "访问码语者",
    type_line: "【电子界族/连接/效果】",
)

#card(
    attribute: "spell",
    card_image: 2263869,
    description: "对方不能对应这张卡的发动把怪兽的效果发动。\n①：从额外卡组把1只怪兽送去墓地，以和那只怪兽相同种类（融合·同调·超量·灵摆·连接）的对方场上1只怪兽为对象才能发动。那只怪兽回到卡组。",
    frame: make_frame(card_kind.spell, card_kind.spell),
    id: 2263869,
    name: "月女神之镞",
    race: "normal",
)

#card(
    attribute: "trap",
    card_image: 23002292,
    description: "这张卡也能把基本分支付一半从手卡发动。\n①：对方把陷阱卡发动时才能发动。那个发动无效，那张卡直接盖放。那之后，对方可以从卡组把1张陷阱卡在自身的魔法与陷阱区域盖放。这张卡的发动后，直到回合结束时对方不能把陷阱卡发动。",
    frame: make_frame(card_kind.trap, card_kind.trap),
    id: 23002292,
    name: "红灯重启",
    race: "counter",
)
