#import "../lib/mod.typ": card
#import "../lib/card/types.typ": card_kind, frame_family, make_frame, monster_frame, spell_race, trap_race
#import "@preview/zebraw:0.6.3": *
#import "@preview/numbly:0.1.0": *

#set page(width: 210mm, height: 297mm, margin: (x: 18mm, y: 20mm))
#set text(lang: "zh", region: "cn", font: "Noto Serif CJK SC", size: 10.5pt)
#set par(justify: true, first-line-indent: (amount: 2em, all: true))
#show heading.where(level: 1): set text(size: 20pt, weight: "bold")
#show heading.where(level: 2): set text(size: 14pt, weight: "bold")
#show heading.where(level: 3): set text(size: 11.5pt, weight: "bold")
#show: zebraw.with(lang: false)
#set heading(
    numbering: numbly(
        "",
        "{2:1}. ",
        "{3:a}.",
    ),
)
#set list(indent: 6pt, marker: sym.bullet.tri)

= ygo

`ygo` 是一个用于生成游戏王卡图的 Typst 包.并不是出于DIY的目的而制作而是对目前最新版的卡图进行复刻.

以下假设您对YGO卡片用语和元素以及Typst有基本正确的了解.

== Quick Start

```typ
#import "../lib/mod.typ": card
#import "../lib/card/types.typ": card_kind, frame_family, make_frame, monster_frame, spell_race, trap_race
```
以`霸王龙 扎克`为例:
```typ
#card(
    atk: 4000,
    attribute: "dark",
    card_image: 13331639,
    def: 4000,
    description: "龙族的融合·同调·超量·灵摆怪兽各1只合计4只\n这张卡不用融合召唤不能特殊召唤。",
    frame: make_frame(card_kind.monster, monster_frame.fusion, family: frame_family.pendulum),
    id: 13331639,
    level: 12,
    name: "霸王龙 扎克",
    pendulum_description: "只要这张卡在灵摆区域存在，对方不能把场上的融合·同调·超量怪兽的效果发动。",
    scale: 12,
    type_line: "【龙族/灵摆/融合/效果】",
)
```
#figure(image("../template/card-6.png"))

每次调用 `card(...)` 会产出一整页卡片,并在末尾执行 `pagebreak(weak: true)`,所以它天然适合连续批量生成.

== 资源约定

`card` 本身不内置完整素材,调用前需要准备资源.默认会从 `../../assets/` 查找这些内容:
- `images/<card-image>.png`
- `figure/cards/card-<frame-name>.png`
- `figure/attributes/attribute-<attribute>.png`
- `figure/arrows/arrow-<marker>.png`
- `figure/icons/icon-<race>.png`
- `figure/indicators/*.png`

同时还需要这些字体,或者通过 `assets.fonts` 覆盖：
- `Yu-Gi-Oh! DFKaiW5-A`
- `Yu-Gi-Oh! Matrix`
- `Yu-Gi-Oh! Ro GSan Serif Std B`
- `Yu-Gi-Oh! ITC Stone Serif M`

如果你的素材目录结构不同,优先通过 `assets.path` 或更细粒度的字段覆盖,而不是改渲染逻辑.

= Guides

== `card`

```typ
#card(
    assets: (...),
    atk: 5000,
    attribute: "earth",
    card_image: 23288411,
    def: 5000,
    description: "...",
    frame: make_frame(card_kind.monster, monster_frame.effect),
    id: 23288411,
    level: 11,
    limit: (md: none, ocg: none, tcg: none),
    link_markers: (...),
    link_value: none,
    name: "...",
    pendulum_description: none,
    race: none,
    scale: none,
    type_line: "...",
)
```
/ `name`: 卡名.
/ `id`: 卡密.
/ `description`: 主效果文本.
/ `frame`: 卡框定义.建议始终通过 `make_frame(...)` 构造.
/ `attribute`: 属性或卡种图标名,例如 `dark`、`light`、`spell`、`trap`.
/ `card_image`: 中心图素材编号,默认会映射到 `images/<card_image>.png`.
/ `type_line`: 怪兽的种族/效果行,例如 `【龙族/效果】`.
/ `atk` / `def`: 攻击力与守备力.传 `-1` 会显示为 `?`.链接怪兽不使用 `def`.
/ `level`: 等级或阶级.超量怪兽会改用 Rank 图标.
/ `pendulum_description`: 灵摆效果文本,仅灵摆怪兽.
/ `scale`: 灵摆刻度,仅灵摆怪兽.
/ `race`: 魔法卡/陷阱卡的小图标种类.
/ `link_value`: 链接值,仅链接怪兽使用.
/ `link_markers`: 链接箭头字典.值只要不是 `none` 就会绘制对应箭头.
/ `assets`: 资源覆盖配置.

== `make_frame`

```typ
#make_frame(card_kind.monster, monster_frame.fusion)
#make_frame(card_kind.monster, monster_frame.xyz)
#make_frame(card_kind.monster, monster_frame.link, family: frame_family.link)
#make_frame(card_kind.monster, monster_frame.effect, family: frame_family.pendulum)
...
```

它返回一个结构化 frame 字典,渲染器依赖其中的：

- `kind`
- `variant`
- `family`

这样做的好处是调用端不需要自己拼 `"fusion-pendulum"` 此类名字.

== Enum

=== `card_kind`

- `card_kind.monster`
- `card_kind.spell`
- `card_kind.trap`

=== `frame_family`

- `frame_family.normal`
- `frame_family.pendulum`
- `frame_family.link`

=== `monster_frame`

- `monster_frame.token`
- `monster_frame.normal`
- `monster_frame.effect`
- `monster_frame.fusion`
- `monster_frame.ritual`
- `monster_frame.synchro`
- `monster_frame.xyz`
- `monster_frame.link`

=== `spell_race`

- `spell_race.normal`
- `spell_race.field`
- `spell_race.equip`
- `spell_race.continuous`
- `spell_race.quick_play`
- `spell_race.ritual`

=== `trap_race`

- `trap_race.normal`
- `trap_race.continuous`
- `trap_race.counter`

= Examples

== Normal Monster

```typ
#card(
    name: "青眼白龙",
    id: 89631139,
    description: "以高攻击力著称的传说之龙。",
    frame: make_frame(card_kind.monster, monster_frame.normal),
    attribute: "light",
    card_image: 89631139,
    atk: 3000,
    def: 2500,
    level: 8,
    type_line: "【龙族/通常】",
)
```

== Link Monster

```typ
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
```
== Pendulum Monster
```typ
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
```
== Counter Trap
```typ
#card(
    attribute: "trap",
    card_image: 23002292,
    description: "这张卡也能把基本分支付一半从手卡发动。\n①：对方把陷阱卡发动时才能发动。那个发动无效，那张卡直接盖放。那之后，对方可以从卡组把1张陷阱卡在自身的魔法与陷阱区域盖放。这张卡的发动后，直到回合结束时对方不能把陷阱卡发动。",
    frame: make_frame(card_kind.trap, card_kind.trap),
    id: 23002292,
    name: "红灯重启",
    race: "counter",
)

```
== More
请查看 `template/template.typ` .
= Hints
== Passwd
因为只有卡密才能唯一确定一张卡片,所以我们以卡密作为`id`.
== ID & Image
对于大多数卡片, `id` 和 `card_image` 是相同的.但是对于token并不是(一般来说,我们制定产生token的卡片的`card_image`为token的`card_image`(比如说幻兽机衍生物的卡图都是一样的),但是也有部分token的`card_image`应该考虑为其独有.).
== Scale
游戏王至今没有出现过左右灵摆刻度不同的卡片,所以我们把它们合并成一个`scale`字段.
== Link value & markers
游戏王至今没有出现过链接值与链接箭头不匹配的卡片.但是内置逻辑并没有强制要求它们必须匹配.
