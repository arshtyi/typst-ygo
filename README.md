# typst-ygo

此[Typst](https://typst.app)模板可用于创作游戏王卡片.

## Note

- 模板不会提交到[universe](https://typst.app/universe).
- 目前仅支持简体中文.
- 仅限已发售的卡片.
- 不支持 DIY 卡片.
- 模板可能不会非常频繁地更新,因为非web的游戏王卡片模板非常难做,而且不稳定.所以我只会在有时间和动力的时候更新,并且我不会承诺任何更新计划.并且不是所有问题都会被解决,因为如果每个参数(和行为)都是合法的就不会有任何问题.

## Examples

<table>
    <tbody>
        <tr>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-01.png" alt="1" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-02.png" alt="2" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-03.png" alt="3" style="width:100%;max-width:240px;height:auto;" /></td>
        </tr>
        <tr>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-04.png" alt="4" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-05.png" alt="5" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-06.png" alt="6" style="width:100%;max-width:240px;height:auto;" /></td>
        </tr>
        <tr>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-07.png" alt="7" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-08.png" alt="8" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-09.png" alt="9" style="width:100%;max-width:240px;height:auto;" /></td>
        </tr>
    </tbody>
</table>

## Usage

### Assets

使用此模板时应当拥有类似[arshtyi/Card-Templates-Of-YuGiOh](https://github.com/arshtyi/Card-Templates-Of-YuGiOh)的资源文件.文件树应当和本仓库(`assets/`)类似,但你也可以修改文件树,只要在模板中override正确的资源路径即可.

### Quick Start

假设你已经拥有了[assets](#assets)中的资源文件,并且在`template`目录下编写：

```typ
#import "../lib/mod.typ": card, card_kind, frame_family, make_frame, monster_frame
#card(
    attribute: "trap",
    card_image: 100261007,
    description: "这个卡名的②的效果1回合只能使用1次。\n①：只要自己的场上或墓地有「卡通」卡存在，对方把手卡全部持续公开，自己随时可以把对方场上的里侧表示卡确认。\n②：自己的场上·墓地有卡通怪兽以及「卡通」魔法卡存在的场合，宣言1个同一连锁上没有把效果发动的卡名才能发动。这张卡表侧表示存在期间，直到回合结束时原本卡名和宣言的卡相同的卡发动的效果无效化。",
    frame: make_frame(card_kind.trap),
    id: 100261007,
    name: "看透心灵之眼",
    race: "continuous",
)
```

### Export

PPI的最佳值为600.
