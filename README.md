# typst-ygo

此[Typst](https://typst.app)模板可用于创作游戏王卡片.

## Note

- 模板不会提交到[universe](https://typst.app/universe).
- 数据规范见[arshtyi/ygo-definitions](https://github.com/arshtyi/ygo-definitions).
- web版本:[typst-ygo-web](https://github.com/arshtyi/typst-ygo-web).
- desktop版本:[ygo-draw](https://github.com/arshtyi/ygo-draw).
- cli版本:[ygo-draw-cli](https://github.com/arshtyi/ygo-draw-cli).

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
        <tr>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-10.png" alt="1" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-11.png" alt="2" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-12.png" alt="3" style="width:100%;max-width:240px;height:auto;" /></td>
        </tr>
        <tr>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-13.png" alt="1" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-14.png" alt="2" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-15.png" alt="3" style="width:100%;max-width:240px;height:auto;" /></td>
        </tr>
        <tr>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-16.png" alt="1" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-17.png" alt="2" style="width:100%;max-width:240px;height:auto;" /></td>
            <td width="33%"><img src="https://raw.githubusercontent.com/arshtyi/typst-ygo/main/template/card-18.png" alt="3" style="width:100%;max-width:240px;height:auto;" /></td>
        </tr>
    </tbody>
</table>

## Usage

### Assets

- 你应当获取必要的资源文件,见[arshtyi/ygo-assets](https://github.com/arshtyi/ygo-assets).
- 你应当获取必要的数据文件,见[arshtyi/ygo-cards](https://github.com/arshtyi/ygo-cards).

<details>
<summary>assets 目录结构</summary>

```txt
assets
├── ot
│   ├── attribute
│   │   ├── dark.png
│   │   ├── divine.png
│   │   ├── earth.png
│   │   ├── fire.png
│   │   ├── light.png
│   │   ├── spell.png
│   │   ├── trap.png
│   │   ├── water.png
│   │   └── windy.png
│   ├── bar
│   │   ├── atk-def.png
│   │   └── atk-link.png
│   ├── card
│   │   └── ot.json
│   ├── font
│   │   ├── YGO_Card_JP.ttf
│   │   ├── Yu-Gi-Oh! DFKaiW5-A.ttf
│   │   ├── Yu-Gi-Oh! ITC Stone Serif M.ttf
│   │   ├── Yu-Gi-Oh! Matrix.ttf
│   │   └── Yu-Gi-Oh! RoGSanSrfStd-Bd.ttf
│   ├── frame
│   │   ├── effect-pendulum.png
│   │   ├── effect.png
│   │   ├── fusion-pendulum.png
│   │   ├── fusion.png
│   │   ├── link.png
│   │   ├── normal-pendulum.png
│   │   ├── normal.png
│   │   ├── ritual-pendulum.png
│   │   ├── ritual.png
│   │   ├── spell.png
│   │   ├── synchro-pendulum.png
│   │   ├── synchro.png
│   │   ├── token.png
│   │   ├── trap.png
│   │   ├── xyz-pendulum.png
│   │   └── xyz.png
│   ├── icon
│   │   ├── continuous.png
│   │   ├── counter.png
│   │   ├── equip.png
│   │   ├── field.png
│   │   ├── quick-play.png
│   │   └── ritual.png
│   ├── images
│   │   ├── 10000022.jpg
│   │   ├── 13332685.jpg
│   │   ├── 34298391.jpg
│   │   ├── 35952884.jpg
│   │   ├── 4731783.jpg
│   │   ├── 48348921.jpg
│   │   ├── 54701958.jpg
│   │   ├── 54842941.jpg
│   │   └── 66518509.jpg
│   ├── level
│   │   └── level.png
│   ├── link
│   │   ├── 0.png
│   │   ├── 1.png
│   │   ├── 2.png
│   │   ├── 3.png
│   │   ├── 4.png
│   │   ├── 5.png
│   │   ├── 6.png
│   │   └── 7.png
│   └── rank
│       └── rank.png
└── rd
    ├── attribute
    │   ├── dark.png
    │   ├── earth.png
    │   ├── fire.png
    │   ├── light.png
    │   ├── spell.png
    │   ├── trap.png
    │   ├── water.png
    │   └── windy.png
    ├── bar
    │   ├── atk-def.png
    │   └── maximum-atk.png
    ├── card
    │   └── rd.json
    ├── font
    │   ├── YGO_Card_JP.ttf
    │   ├── Yu-Gi-Oh! DFKaiW5-A.ttf
    │   ├── Yu-Gi-Oh! ITC Stone Serif M.ttf
    │   └── Yu-Gi-Oh! RoGSanSrfStd-Bd.ttf
    ├── frame
    │   ├── effect.png
    │   ├── fusion.png
    │   ├── normal.png
    │   ├── ritual.png
    │   ├── spell.png
    │   └── trap.png
    ├── icon
    │   ├── continuous.png
    │   ├── equip.png
    │   ├── field.png
    │   └── ritual.png
    ├── images
    │   ├── 120155021.jpg
    │   ├── 120155022.jpg
    │   ├── 120155023.jpg
    │   ├── 120231069.jpg
    │   ├── 120257066.jpg
    │   ├── 120287032.jpg
    │   ├── 120293046.jpg
    │   ├── 120293068.jpg
    │   └── 120305014.jpg
    ├── legend
    │   └── legend.png
    └── level
        └── container.png
```

</details>

### Export

PPI的最佳值为600.
