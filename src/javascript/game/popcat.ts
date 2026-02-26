const popcatCanvasWidth: number = 400;
const popcatCanvasHeight: number = 500;
const popcatResources: string = "../resources/images/games/popcat/";

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

function popcatGameHasRestarted() {
    // Restart game and init objects
    popcatGameRunning = true;
    popcatGameRestarted = true;
}

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
    let catMouthOpen: boolean = false;
    let score: number = 0;

    // Events:
    // * Open mouth:
    canvas.addEventListener("mousedown", (e) => {
        catMouthOpen = true;
    });
    canvas.addEventListener("touchstart", (e) => {
        catMouthOpen = true;
    });

    // * Close mouth:
    canvas.addEventListener("mouseup", (e) => {
        catMouthOpen = false;
    });
    canvas.addEventListener("touchend", (e) => {
        catMouthOpen = false;
    });
    canvas.addEventListener("mouseout", (e) => {
        catMouthOpen = false;
    });
    canvas.addEventListener("touchcancel", (e) => {
        catMouthOpen = false;
    });

    // Game logic:

    function init() {
        score = 0;
    }

    function update() {
        if (context == null) {
            alert("Context unavailable in loop.");
            return;
        }
        if (popcatGameRestarted) {
            init();
            popcatGameRestarted = false;
        }
        if (!popcatGameRunning) return;
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
