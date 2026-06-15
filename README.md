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

使用此模板时应当拥有本仓库 `assets/ot/` 结构中的资源文件、`assets/ot/card/ot.json` 和 `assets/ot/images/index.json`.目前重构后的默认入口只适配 `docs/docs.typ` 中定义的 OT 数据格式.

### Quick Start

假设你已经拥有了[assets](#assets)中的资源文件,并且在`template`目录下编写：

```typ
#import "../lib/mod.typ": ot_card_by_id, ot_card_data, ot_image_index

#let cards = ot_card_data()
#let images = ot_image_index()
#ot_card_by_id(23002292, cards: cards, images: images)
```

### Export

PPI的最佳值为600.从仓库根目录编译示例：

```sh
typst compile --root . --font-path assets/ot/font template/template.typ template/template.pdf
```
