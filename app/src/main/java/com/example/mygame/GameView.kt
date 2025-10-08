package com.example.mygame

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.view.SurfaceHolder
import android.view.SurfaceView

// Data class para representar a nuestro héroe
data class Hero(var x: Float, var y: Float, val width: Float, val height: Float, val paint: Paint)

class GameView(context: Context) : SurfaceView(context), SurfaceHolder.Callback {

    private val gameThread: GameThread
    private val hero: Hero

    init {
        holder.addCallback(this)
        gameThread = GameThread(holder, this)

        // Inicializar al héroe
        val heroPaint = Paint().apply { color = Color.BLUE }
        hero = Hero(x = 100f, y = 500f, width = 100f, height = 100f, paint = heroPaint)
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        gameThread.setRunning(true)
        gameThread.start()
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {}

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        var retry = true
        gameThread.setRunning(false)
        while (retry) {
            try {
                gameThread.join()
                retry = false
            } catch (e: InterruptedException) {
                e.printStackTrace()
            }
        }
    }

    fun update() {
        // En el futuro, aquí actualizaremos la posición del héroe
    }

    fun drawToCanvas(canvas: Canvas) {
        super.draw(canvas)
        // Dibujar el fondo
        canvas.drawColor(Color.rgb(135, 206, 235)) // Un color cielo

        // Dibujar al héroe
        canvas.drawRect(hero.x, hero.y, hero.x + hero.width, hero.y + hero.height, hero.paint)
    }

    class GameThread(private val surfaceHolder: SurfaceHolder, private val gameView: GameView) : Thread() {
        private var running: Boolean = false
        private val targetFPS = 60

        fun setRunning(isRunning: Boolean) {
            this.running = isRunning
        }

        override fun run() {
            var startTime: Long
            var timeMillis: Long
            var waitTime: Long
            val targetTime = (1000 / targetFPS).toLong()

            while (running) {
                startTime = System.nanoTime()
                var canvas: Canvas? = null

                try {
                    canvas = surfaceHolder.lockCanvas()
                    synchronized(surfaceHolder) {
                        gameView.update()
                        if (canvas != null) {
                            gameView.drawToCanvas(canvas)
                        }
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                } finally {
                    if (canvas != null) {
                        try {
                            surfaceHolder.unlockCanvasAndPost(canvas)
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                    }
                }

                timeMillis = (System.nanoTime() - startTime) / 1000000
                waitTime = targetTime - timeMillis

                try {
                    if (waitTime > 0) {
                        sleep(waitTime)
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }
}
