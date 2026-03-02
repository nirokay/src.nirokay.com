const popcatCanvasWidth: number = 400;
const popcatCanvasHeight: number = 500;
const popcatResources: string = "../resources/images/games/popcat/";
const popcatResourcesSounds: string = "../resources/sounds/games/popcat/";

const popcatFallingInitSpeedCONST: number = 2;
let popcatFallingInitSpeed: number = popcatFallingInitSpeedCONST; // this will increase over the span of the game
const popcatFallingMultSpeed: number = 1.5;

const popcatEatingLine: number = popcatCanvasHeight - 60;

const livesCONST: number = 3;
let lives: number = livesCONST;
let score: number = 0;
let highscore: number = 0;

let popcatGameRunning: boolean = false;
let popcatGameRestarted: boolean = false;

// Images:
function newPopcatImg(path: string): HTMLImageElement {
    let result: HTMLImageElement = new Image();
    result.src = popcatResources + path;
    return result;
}
let popcatCatIdle: HTMLImageElement = newPopcatImg("cat/idle.png");
let popcatCatNomp: HTMLImageElement = newPopcatImg("cat/nomp.png");

let foodImages: HTMLImageElement[] = [
    newPopcatImg("food/fish_blue.png"),
    newPopcatImg("food/fish_blue_flushed.png"),
    newPopcatImg("food/fish_red.png"),
    newPopcatImg("food/fish_red_flushed.png"),
];
let notFoodImages: HTMLImageElement[] = [
    newPopcatImg("notfood/bomb.png"),
    newPopcatImg("notfood/cig.png"),
    newPopcatImg("notfood/car_red.png"),
    newPopcatImg("notfood/car_blue.png"),
    newPopcatImg("notfood/car_gray.png"),
    newPopcatImg("notfood/atomic_bomb.png"),
];

// Sounds:
function newPopCatSfx(path: string): HTMLAudioElement {
    return new Audio(popcatResourcesSounds + path);
}
let popcatSfxPop: HTMLAudioElement = newPopCatSfx("pop.ogg");

// Items:
class FallingItem {
    height: number = popcatCanvasHeight * 2;
    sideways: number = popcatCanvasWidth / 2;
    speed: number = popcatFallingInitSpeed;
    image: HTMLImageElement = newPopcatImg("no_img.png");
    isFood: boolean = true;
}
let popcatFallingFood: FallingItem[] = [];
let popcatFallingNotFood: FallingItem[] = [];

function getRandomHeightOffset(): number {
    return Math.random() * popcatCanvasHeight + 200;
}
function getRandomSpeedOffset(): number {
    return Math.random() * popcatFallingMultSpeed;
}

function getRandomIndexValue<T>(list: T[]): T {
    let index: number = Math.floor(Math.random() * (list.length - 1));
    return list[index];
}

function getRandomFallingItem(isFood: boolean): FallingItem {
    let result: FallingItem = new FallingItem();
    result.height = -getRandomHeightOffset();
    result.speed *= getRandomSpeedOffset();
    result.isFood = isFood;

    let image: HTMLImageElement;
    if (isFood) {
        image = getRandomIndexValue(foodImages);
    } else {
        image = getRandomIndexValue(notFoodImages);
    }

    result.sideways = popcatCanvasWidth / 2 - image.width / 2; // maybe in the future there will be a horizontal offset
    result.image = image;
    return result;
}
function getRandomFallingFood(): FallingItem {
    return getRandomFallingItem(true);
}
function getRandomFallingNotFood(): FallingItem {
    return getRandomFallingItem(false);
}

// Score and Lives:
function updateScore() {
    score++;
    if (score % 5 == 0) {
        popcatFallingInitSpeed *= 1.1;
        popcatFallingFood.push(getRandomFallingFood());
        popcatFallingNotFood.push(getRandomFallingNotFood());
    }
}
function updateLives() {
    lives--;
}

// Init:
function popcatGameHasRestarted() {
    // Restart game and init objects:
    popcatGameRunning = true;
    popcatGameRestarted = true;

    // Reset speed:
    popcatFallingInitSpeed = popcatFallingInitSpeedCONST;

    // Reset lives and score:
    lives = livesCONST;
    if (score > highscore) highscore = score;
    score = 0;

    // Init objects:
    popcatFallingFood = [
        getRandomFallingFood(),
        getRandomFallingFood(),
        getRandomFallingFood(),
        getRandomFallingFood(),
    ];
    popcatFallingNotFood = [
        getRandomFallingNotFood(),
        getRandomFallingNotFood(),
    ];
}

// Main:
function popcatGame() {
    // Canvas:
    let canvas: HTMLCanvasElement | null = document.getElementById(
        "canvas",
    ) as HTMLCanvasElement;
    if (canvas == null) {
        alert("Canvas not found.");
        return;
    }
    let context: CanvasRenderingContext2D | null = canvas.getContext("2d");
    if (context == null) {
        alert("Canvas rendering fucked up, idk...");
        return;
    }

    // Variables:
    let catMouthOpenLastFrame: boolean = false;
    let catMouthOpen: boolean = false;

    // Events:
    // * Open mouth:
    canvas.addEventListener("mousedown", (e) => {
        catMouthOpenLastFrame = catMouthOpen;
        catMouthOpen = true;
    });
    canvas.addEventListener("touchstart", (e) => {
        catMouthOpenLastFrame = catMouthOpen;
        catMouthOpen = true;
    });

    // * Close mouth:
    canvas.addEventListener("mouseup", (e) => {
        catMouthOpenLastFrame = catMouthOpen;
        catMouthOpen = false;
    });
    canvas.addEventListener("touchend", (e) => {
        catMouthOpenLastFrame = catMouthOpen;
        catMouthOpen = false;
    });
    canvas.addEventListener("mouseout", (e) => {
        catMouthOpenLastFrame = catMouthOpen;
        catMouthOpen = false;
    });
    canvas.addEventListener("touchcancel", (e) => {
        catMouthOpenLastFrame = catMouthOpen;
        catMouthOpen = false;
    });

    function updateItem(index: number, isFood: boolean) {
        function getNewItem(): FallingItem {
            return isFood ? getRandomFallingFood() : getRandomFallingNotFood();
        }
        function isInEatingRange(): boolean {
            return (
                item.height <= popcatEatingLine &&
                item.height + item.image.height >= popcatEatingLine
            );
        }

        let item: FallingItem = isFood
            ? popcatFallingFood[index]
            : popcatFallingNotFood[index];

        // Fall:
        item.height += item.speed;

        // Respawn if reached the bottom:
        if (item.height > popcatCanvasHeight + 100) item = getNewItem();

        // Eating logic:
        if (catMouthOpen && isInEatingRange()) {
            isFood ? updateScore() : updateLives();
            item = getNewItem();
        }

        // Update array with item:
        isFood
            ? (popcatFallingFood[index] = item)
            : (popcatFallingNotFood[index] = item);
    }

    // Game logic:

    function init() {
        popcatGameHasRestarted();
    }

    function update() {
        if (context == null) {
            alert("Context unavailable in loop.");
            return;
        }

        // Init game if has been (re-)started:
        if (popcatGameRestarted) {
            init();
            popcatGameRestarted = false;
        }

        // Play pop sound (here because it should be able to be played when not in game):
        if (catMouthOpen && !catMouthOpenLastFrame) {
            popcatSfxPop.play();
        }

        // Quit game if no lives:
        if (lives <= 0) popcatGameRunning = false;

        // Quit loop, if game is not running:
        if (!popcatGameRunning) return;

        // Let items fall:
        // Respawn items and check if eaten:
        for (let i = 0; i < popcatFallingFood.length; i++) {
            updateItem(i, true);
            popcatFallingFood[i].height += popcatFallingFood[i].speed;
            if (popcatFallingFood[i].height > popcatCanvasHeight + 100)
                popcatFallingFood[i] = getRandomFallingFood();
        }
        for (let i = 0; i < popcatFallingNotFood.length; i++) {
            updateItem(i, false);
            popcatFallingNotFood[i].height += popcatFallingNotFood[i].speed;
            if (popcatFallingNotFood[i].height > popcatCanvasHeight + 100)
                popcatFallingNotFood[i] = getRandomFallingNotFood();
        }

        // Section only if mouth is open (in eating mode):
        if (!catMouthOpen) return;
    }

    function render() {
        if (context == null) {
            alert("Context unavailable in loop.");
            return;
        }
        // Background:
        context.clearRect(0, 0, popcatCanvasWidth, popcatCanvasHeight);

        // Cat:
        let catImage: HTMLImageElement = catMouthOpen
            ? popcatCatNomp
            : popcatCatIdle;
        context.drawImage(
            catImage,
            popcatCanvasWidth / 2 - catImage.width / 2,
            popcatCanvasHeight - catImage.height - 10,
        );

        [...popcatFallingFood, ...popcatFallingNotFood].forEach((item) => {
            context.drawImage(item.image, item.sideways, item.height);
        });

        // Draw eating line:
        context.beginPath();
        context.moveTo(0, popcatEatingLine);
        context.lineTo(popcatCanvasWidth, popcatEatingLine);
        context.stroke();
    }

    function main() {
        update();
        render();
        setTimeout(main, 10);
    }
    main();
}

window.onload = () => {
    popcatGame();
};
