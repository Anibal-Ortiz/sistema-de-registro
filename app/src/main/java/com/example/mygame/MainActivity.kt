package com.example.mygame

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Window
import android.view.WindowManager

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Poner la app en pantalla completa para una mejor inmersión
        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        )
        this.requestWindowFeature(Window.FEATURE_NO_TITLE)

        // Crear una instancia de nuestra GameView y establecerla como la vista principal
        setContentView(GameView(this))
    }
}
