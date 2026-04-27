# typst-ygo

This template can be used to create a Yu-Gi-Oh! card using [Typst](https://typst.app/).

## Note

- This template would not be submitted to [universe](https://typst.app/universe/).
- Simplified Chinese Only, so far.
- Sold cards Only.
- No DIY.
- This template may not update very frequently, because Yu-Gi-Oh! cards template(not on web) is very hard to make, and is not stable.So I will only update it when I have time and motivation, and I will not promise any update schedule.

## Examples

| | |
| --- | --- |
| <img src="template/card-1.png" alt="1" width="260" /> | <img src="template/card-2.png" alt="2" width="260" /> |
| <img src="template/card-3.png" alt="3" width="260" /> | <img src="template/card-4.png" alt="4" width="260" /> |

## Usage

### Assets

You must have the resource files like: [arshtyi/Card-Templates-Of-YuGiOh](https://github.com/arshtyi/Card-Templates-Of-YuGiOh). The file-tree should be like this repo(`assets/`), but you can also modify the file-tree as you like, just remember to use the correct path in the template(see [quick start](#quick-start) and [arshtyi/YuGiOh-Cards-Asset](https://github.com/arshtyi/YuGiOh-Cards-Asset)).

### Arguments

You can check the [arshtyi/YuGiOh-Cards-Asset](https://github.com/arshtyi/YuGiOh-Cards-Asset) to learn the arguments of this template.

### Quick Start

Assumping you have the resource files in [assets](#assets) and write in the directory `template`:

```typ
#import "../lib/card.typ": card
#card(
    atk: 4000,
    attribute: "dark",
    cardImage: 13331639,
    cardType: "monster",
    def: 4000,
    description: "龙族的融合·同调·超量·灵摆怪兽各1只合计4只\n这张卡不用融合召唤不能特殊召唤。\n①：这张卡特殊召唤的场合发动。对方场上的卡全部破坏。②：这张卡不会被对方的效果破坏，对方不能把这张卡作为效果的对象。③：这张卡战斗破坏对方怪兽时才能发动。从卡组·额外卡组把1只「霸王眷龙」怪兽特殊召唤。④：怪兽区域的这张卡被战斗·效果破坏的场合才能发动。这张卡在自己的灵摆区域放置。",
    frameType: "fusion-pendulum",
    id: 13331639,
    level: 12,
    name: "霸王龙 扎克",
    pendulumDescription: "①：只要这张卡在灵摆区域存在，对方不能把场上的融合·同调·超量怪兽的效果发动。②：1回合1次，抽卡阶段以外从卡组有卡加入对方手卡时才能发动。那些卡破坏。",
    scale: 12,
    typeline: "【龙族/灵摆/融合/效果】",
)
```

### Export

The PPI should be 600.
