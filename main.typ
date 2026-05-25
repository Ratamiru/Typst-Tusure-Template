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

// Нумерация: 1, 1.1, 1.1.1 — без точки в конце
#set heading(numbering: (..args) => args.pos().map(str).join("."))

// Заголовок 1 уровня: по центру, полужирный, КАПС
#show heading.where(level: 1): it => context {
  let n = counter(heading).display(it.numbering)
  block(above: 1em, below: 0.6em, width: 100%,
    align(center, strong(upper(n + h(0.4em) + it.body)))
  )
}

// Заголовок 2 уровня: по центру, полужирный, обычный регистр
#show heading.where(level: 2): it => context {
  let n = counter(heading).display(it.numbering)
  block(above: 0.8em, below: 0.4em, width: 100%,
    align(center, strong(n + h(0.4em) + it.body))
  )
}

// Подписи к рисункам: «Рисунок N — название»
#show figure.caption: it => context [
  Рисунок #counter(figure).display() — #it.body
]

// Ссылки @label на рисунки: @fig-name → «рисунке N»
// Читаем счётчик по месту рисунка, не по месту ссылки
#show ref: it => {
  let el = it.element
  if el != none and el.func() == figure {
    let num = context counter(figure).at(el.location()).first()
    link(el.location())[рисунке #num]
  } else {
    it
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ТИТУЛЬНЫЙ ЛИСТ
// ════════════════════════════════════════════════════════════════════════════
#include "title.typ"

// ════════════════════════════════════════════════════════════════════════════
// ВВЕДЕНИЕ (отдельная страница)
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()

#align(center)[
  *Лабораторная работа* \
  *«Название лабораторной работы»*
]

#v(1em)

*Цель работы:* цель.

*Вариант задания:* описание варианта.

#pagebreak()

// ════════════════════════════════════════════════════════════════════════════
// ОСНОВНОЕ СОДЕРЖАНИЕ
// ════════════════════════════════════════════════════════════════════════════

= Листинги программного кода

== Исходный код (Testactivity.java)

Текст. На @fig-example представлен интерфейс приложения.

```java
// код
```

= Результаты работы приложения

Описание результатов.

#figure(
  image("1.png", width: 70%),
  caption: [Главный экран приложения],
) <fig-example>

*Вывод:* итоги работы.
