#set text(font: "Times New Roman", size: 14pt, lang: "ru")
#set page(paper: "a4", margin: 2cm)
#set heading(numbering: "1.")
#include "title.typ"

#align(center)[
  *Лабораторная работа*\
  *«Создание пользовательских интерфейсов и использование элементов управления в приложениях под Android»*
]

*Цель работы:* изучить интерфейс IDE Android Studio и получить навыки составления и отладки простого Android-приложения с использованием базовых элементов графического интерфейса пользователя.

*Вариант задания:* разработка калькулятора в Android Studio.



= Листинги программного кода

== Исходный код (Testactivity.java)

```java
package com.example.test;

import android.os.Bundle;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import android.widget.Button;
import android.widget.TextView;

public class Testactivity extends AppCompatActivity {

    TextView tvDisplay;
    double firstNumber = 0;
    String operator = "";
    boolean newInput = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        //БОЙЛЕРПЛЕЙТ НЕ ТРОГАТЬ
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_testactivity);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        tvDisplay = findViewById(R.id.tvDisplay);

        // Цифры
        Button btn0 = findViewById(R.id.btn0);
        Button btn1 = findViewById(R.id.btn1);
        Button btn2 = findViewById(R.id.btn2);
        Button btn3 = findViewById(R.id.btn3);
        Button btn4 = findViewById(R.id.btn4);
        Button btn5 = findViewById(R.id.btn5);
        Button btn6 = findViewById(R.id.btn6);
        Button btn7 = findViewById(R.id.btn7);
        Button btn8 = findViewById(R.id.btn8);
        Button btn9 = findViewById(R.id.btn9);
        // Подписка на ивенты
        btn0.setOnClickListener(v -> appendDigit("0"));
        btn1.setOnClickListener(v -> appendDigit("1"));
        btn2.setOnClickListener(v -> appendDigit("2"));
        btn3.setOnClickListener(v -> appendDigit("3"));
        btn4.setOnClickListener(v -> appendDigit("4"));
        btn5.setOnClickListener(v -> appendDigit("5"));
        btn6.setOnClickListener(v -> appendDigit("6"));
        btn7.setOnClickListener(v -> appendDigit("7"));
        btn8.setOnClickListener(v -> appendDigit("8"));
        btn9.setOnClickListener(v -> appendDigit("9"));

        // Операции
        Button btnAdd = findViewById(R.id.btnAdd);
        Button btnSub = findViewById(R.id.btnSub);
        Button btnMul = findViewById(R.id.btnMul);
        Button btnDiv = findViewById(R.id.btnDiv);

        btnAdd.setOnClickListener(v -> setOperator("+"));
        btnSub.setOnClickListener(v -> setOperator("-"));
        btnMul.setOnClickListener(v -> setOperator("*"));
        btnDiv.setOnClickListener(v -> setOperator("/"));

        // Равно и сброс
        Button btnEquals = findViewById(R.id.btnEquals);
        Button btnClear  = findViewById(R.id.btnClear);

        btnEquals.setOnClickListener(v -> calculate());
        btnClear.setOnClickListener(v -> clear());
    }

    void appendDigit(String digit) {
        if (newInput) {
            tvDisplay.setText(digit);
            newInput = false;
        } else {
            String current = tvDisplay.getText().toString();
            tvDisplay.setText(current.equals("0") ? digit : current + digit);
        }
    }

    void setOperator(String op) {
        firstNumber = Double.parseDouble(tvDisplay.getText().toString());
        operator = op;
        newInput = true;
    }

    void calculate() {
        double second = Double.parseDouble(tvDisplay.getText().toString());
        double result = 0;

        switch (operator) {
            case "+": result = firstNumber + second; break;
            case "-": result = firstNumber - second; break;
            case "*": result = firstNumber * second; break;
            case "/":
                if (second != 0) result = firstNumber / second;
                else { tvDisplay.setText("Ошибка"); return; }
                break;
        }

        // Убираем .0 если число целое
        if (result == (long) result)
            tvDisplay.setText(String.valueOf((long) result));
        else
            tvDisplay.setText(String.valueOf(result));

        newInput = true;
    }

    void clear() {
        tvDisplay.setText("0");
        firstNumber = 0;
        operator = "";
        newInput = false;
    }
}
```

== Разметка интерфейса (activity_testactivity.xml)

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/main"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".Testactivity">

    <!-- Дисплей -->
    <TextView
        android:id="@+id/tvDisplay"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:text="0"
        android:textSize="40sp"
        android:gravity="end"
        android:padding="16dp"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"/>

    <!-- Кнопки -->
    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        app:layout_constraintTop_toBottomOf="@id/tvDisplay"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent">

        <!-- Ряд 1 -->
        <LinearLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:orientation="horizontal">
            <Button android:id="@+id/btn7" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="7"/>
            <Button android:id="@+id/btn8" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="8"/>
            <Button android:id="@+id/btn9" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="9"/>
            <Button android:id="@+id/btnDiv" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="/"/>
        </LinearLayout>

        <!-- Ряд 2 -->
        <LinearLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:orientation="horizontal">
            <Button android:id="@+id/btn4" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="4"/>
            <Button android:id="@+id/btn5" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="5"/>
            <Button android:id="@+id/btn6" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="6"/>
            <Button android:id="@+id/btnMul" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="*"/>
        </LinearLayout>

        <!-- Ряд 3 -->
        <LinearLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:orientation="horizontal">
            <Button android:id="@+id/btn1" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="1"/>
            <Button android:id="@+id/btn2" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="2"/>
            <Button android:id="@+id/btn3" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="3"/>
            <Button android:id="@+id/btnSub" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="-"/>
        </LinearLayout>

        <!-- Ряд 4 -->
        <LinearLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:orientation="horizontal">
            <Button android:id="@+id/btnClear" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="C"/>
            <Button android:id="@+id/btn0" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="0"/>
            <Button android:id="@+id/btnEquals" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="="/>
            <Button android:id="@+id/btnAdd" android:layout_width="0dp" android:layout_height="match_parent" android:layout_weight="1" android:text="+"/>
        </LinearLayout>

    </LinearLayout>



</androidx.constraintlayout.widget.ConstraintLayout>```


= Результаты работы приложения
Для проверки работы приложения использовалась эмуляция устройства Google Pixel 7. В ходе тестирования было установлено, что виртуальное устройство Medium Phone API 36.1 (устройство по умолчанию) обеспечивало более стабильную производительность.

#figure(image("1.png", width: 70%),
caption: [Ввод первого числа, пример самого интерфейса программы],
)
#figure(image("2.png", width: 70%),
caption: [Ввод второго числа],
)

#figure(image("3.png", width: 70%),
caption: [Операция суммы],
)
*Вывод*:
За лабораторную работу мы ознакомились с интерфейсом android studio, создали простое приложение калькулятора с простой логикой.
На будушее стоит запомнить что при использовыании некоторых элементов интефейса к примеру кнопки, нужно добавлять include в .java файл чтобы не ловить ошибку компиляции. 
