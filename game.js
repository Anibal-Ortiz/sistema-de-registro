// El código de nuestro juego irá aquí.

// --- CONFIGURACIÓN INICIAL ---
// Obtener el elemento canvas y su contexto
const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');

// --- ESTADO DEL JUEGO ---
// Definir al héroe como un objeto
const hero = {
    x: 375, // Posición inicial en el eje X
    y: 450, // Posición ajustada para estar sobre el suelo
    width: 50, // Ancho del héroe
    height: 50, // Alto del héroe
    color: '#d95763', // Un color rojizo para el cuerpo
    speed: 200, // Velocidad en píxeles por segundo
    velocityY: 0 // Velocidad vertical para el salto
};

const gravity = 1500; // Aceleración de la gravedad en píxeles/segundo^2

const monster = {
    x: 100,
    y: 450, // Misma altura que el héroe para que esté en el suelo
    width: 50,
    height: 50,
    color: 'red',
    speed: 100,
    direction: 1 // 1 para derecha, -1 para izquierda
};

// --- MANEJO DE ENTRADAS (TECLADO) ---
const keys = {}; // Objeto para almacenar el estado de las teclas

// Añadir listeners para los eventos de teclado
window.addEventListener('keydown', (e) => {
    keys[e.key] = true;
});

window.addEventListener('keyup', (e) => {
    keys[e.key] = false;
});

// --- FUNCIONES de ACTUALIZACIÓN Y DIBUJO ---

function checkCollision(rect1, rect2) {
    return (
        rect1.x < rect2.x + rect2.width &&
        rect1.x + rect1.width > rect2.x &&
        rect1.y < rect2.y + rect2.height &&
        rect1.y + rect1.height > rect2.y
    );
}

// update: Se encarga de actualizar la lógica del juego (movimiento, colisiones, etc.)
function update(deltaTime) {
    // --- MOVIMIENTO HORIZONTAL ---
    if (keys['ArrowLeft'] || keys['a']) {
        hero.x -= hero.speed * (deltaTime / 1000);
    }
    if (keys['ArrowRight'] || keys['d']) {
        hero.x += hero.speed * (deltaTime / 1000);
    }

    // --- MOVIMIENTO VERTICAL (SALTO Y GRAVEDAD) ---
    const groundLevel = canvas.height - 100 - hero.height;
    const onGround = hero.y >= groundLevel;

    // Iniciar el salto si se presiona la tecla y está en el suelo
    if ((keys['ArrowUp'] || keys['w'] || keys[' ']) && onGround) {
        hero.velocityY = -700; // Impulso inicial del salto (valor negativo va hacia arriba)
    }

    // Aplicar gravedad a la velocidad vertical
    hero.velocityY += gravity * (deltaTime / 1000);

    // Actualizar la posición Y del héroe
    hero.y += hero.velocityY * (deltaTime / 1000);

    // --- COLISIONES ---
    // Colisión con el suelo
    if (hero.y > groundLevel) {
        hero.y = groundLevel;
        hero.velocityY = 0;
    }

    // Colisión entre héroe y monstruo
    if (checkCollision(hero, monster)) {
        console.log("¡Colisión! El héroe ha chocado con el monstruo.");
        // Por ahora, reiniciamos la posición del héroe y del monstruo para dar feedback
        hero.x = 375;
        hero.y = 450;
        hero.velocityY = 0;
        monster.x = 100;
    }

    // Limitar el movimiento horizontal del héroe a los bordes del canvas
    if (hero.x < 0) {
        hero.x = 0;
    }
    if (hero.x + hero.width > canvas.width) {
        hero.x = canvas.width - hero.width;
    }

    // --- MOVIMIENTO DEL MONSTRUO ---
    monster.x += monster.speed * monster.direction * (deltaTime / 1000);

    // Hacer que el monstruo rebote en los bordes del canvas
    if (monster.x <= 0 || monster.x + monster.width >= canvas.width) {
        monster.direction *= -1; // Invertir la dirección
    }
}

// draw: Se encarga de dibujar todo en el canvas
function draw() {
    // Limpiar el canvas en cada fotograma
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Dibujar el cielo
    ctx.fillStyle = '#87CEEB'; // Un bonito color azul cielo
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Dibujar el suelo
    ctx.fillStyle = '#228B22'; // Verde bosque
    ctx.fillRect(0, canvas.height - 100, canvas.width, 100); // El suelo ocupa los últimos 100 píxeles

    // Dibujar al héroe (un poco más detallado)
    // Cuerpo
    ctx.fillStyle = hero.color; // Usamos el color definido en el objeto del héroe
    ctx.fillRect(hero.x, hero.y, hero.width, hero.height);

    // Cabeza
    const headHeight = hero.height / 2;
    const headWidth = hero.width / 1.5;
    ctx.fillStyle = '#F0DDBA'; // Un color piel
    ctx.fillRect(hero.x + (hero.width - headWidth) / 2, hero.y - headHeight, headWidth, headHeight);

    // Dibujar al monstruo
    ctx.fillStyle = monster.color;
    ctx.fillRect(monster.x, monster.y, monster.width, monster.height);
}

// --- BUCLE PRINCIPAL DEL JUEGO ---
let lastTime = 0;
function gameLoop(timestamp) {
    // Calcular el tiempo delta para un movimiento consistente
    const deltaTime = timestamp - lastTime;
    lastTime = timestamp;

    // 1. Actualizar el estado del juego
    update(deltaTime);

    // 2. Dibujar el juego
    draw();

    // 3. Pedir al navegador que vuelva a llamar a gameLoop para el siguiente fotograma
    requestAnimationFrame(gameLoop);
}

// --- INICIAR EL JUEGO ---
// Iniciar el bucle del juego por primera vez
requestAnimationFrame(gameLoop);
