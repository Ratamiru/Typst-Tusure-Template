// ════════════════════════════════════════════════════════════════════════════
// ТУСУР — шаблон лабораторной работы
// ════════════════════════════════════════════════════════════════════════════

#set text(font: "Liberation Serif", size: 14pt, lang: "ru")
#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 1.5cm),
  numbering: "1",
  number-align: center,
)

// Полуторный интервал + отступ первой строки 1.25 см
#set par(
  leading: 0.85em,
  first-line-indent: 1.25cm,
  justify: true,
)

// Нумерация: 1, 1.1 — без точки в конце
#set heading(numbering: (..args) => args.pos().map(str).join("."))

// Фиктивный параграф — нужен после каждого заголовка,
// чтобы Typst добавлял отступ первой строки следующего абзаца
#let fakepar = par(text(size: 0pt, ""))

// Заголовок 1 уровня: по центру, 14pt, полужирный, КАПС
#show heading.where(level: 1): it => context {
  let n = counter(heading).display(it.numbering)
  [
    #block(above: 1em, below: 0.6em, width: 100%,
      align(center, text(size: 14pt, strong(upper(n + h(0.4em) + it.body))))
    )
    #fakepar
  ]
}

// Заголовок 2 уровня: по центру, 14pt, полужирный
#show heading.where(level: 2): it => context {
  let n = counter(heading).display(it.numbering)
  [
    #block(above: 0.8em, below: 0.4em, width: 100%,
      align(center, text(size: 14pt, strong(n + h(0.4em) + it.body)))
    )
    #fakepar
  ]
}

// Подписи к рисункам: «Рисунок N — название»
#show figure.caption: it => context [
  Рисунок #counter(figure).display() — #it.body
]

// Ссылки @label → «рисунке N»
#show ref: it => {
  let el = it.element
  if el != none and el.func() == figure {
    let num = context counter(figure).at(el.location()).first()
    link(el.location())[рисунке #num]
  } else {
    it
  }
}

// Стиль блоков кода
#show raw.where(block: true): it => block(
  fill: luma(245),
  inset: (x: 10pt, y: 8pt),
  radius: 3pt,
  width: 100%,
  text(font: "Liberation Mono", size: 10pt, it)
)

// ════════════════════════════════════════════════════════════════════════════
// ТИТУЛЬНЫЙ ЛИСТ
// ════════════════════════════════════════════════════════════════════════════
#include "title.typ"

// ════════════════════════════════════════════════════════════════════════════
// ВВЕДЕНИЕ
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()

#align(center)[
  *Лабораторная работа №X* \
  *«Название лабораторной работы»*
]

#v(1em)

*Цель работы:* цель.

*Задание:* описание задания.

#pagebreak()

// ════════════════════════════════════════════════════════════════════════════
// ОСНОВНОЕ СОДЕРЖАНИЕ
// ════════════════════════════════════════════════════════════════════════════

= Ход работы

== Первый раздел

Текст раздела. Как представлено на @fig-example, ...

#figure(
  image("screenshots/1.png", width: 80%),
  caption: [Подпись к рисунку],
) <fig-example>

== Второй раздел

Текст со вставкой кода:

```python
# пример кода
print("Hello")
```

= Заключение

Итоги работы.
