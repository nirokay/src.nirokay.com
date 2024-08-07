// Html IDs:
// =========
class Cat {
    constructor(picture: string, score: string) {
        this.pictureId = picture;
        this.scoreId = score;
    }
    pictureId: string;
    scoreId: string;

    setFrame(source: string) {
        let element: HTMLPictureElement | null = document.getElementById(this.pictureId) as HTMLPictureElement;
        if(element == null) {
            console.error("Cat by id " + this.pictureId + " not found :(");
            return;
        }
        element.setAttribute("src", "../resources/images/games/pingpong/" + source);
    }

    setScore(score: number) {
        let element: HTMLElement | null = document.getElementById(this.scoreId);
        if(element == null) {
            console.error("Cat score by id " + this.scoreId + " not found");
            return;
        }
        element.innerHTML = score.toString();
    }
    increaseScore() {
        let element: HTMLElement | null = document.getElementById(this.scoreId);
        if(element == null) {
            console.error("Cat score by id " + this.scoreId + " not found");
            return;
        }
        this.setScore(parseInt(element.innerHTML) + 1);
    }
}
let catLeft = new Cat("id-cat-left-picture", "id-cat-left-score");
let catRight = new Cat("id-cat-right-picture", "id-cat-right-score");

// Cat files:
// ==========
//  - Cat failures:
const directoryCatFailure: string = "cat/failure/";
const filesCatFailure: string[] = [
    "sad-01.gif",
    "disbelief.gif"
];
//  - Cat successes:
const directoryCatSuccess: string = "cat/success/";
const filesCatSuccess: string[] = [
    "yippie.gif"
];
//  - Cat assets:
const directoryCatWhileGaming: string = "cat/";
const fileCatStandBy: string = "cat-standby.png";
const fileCatPong: string = "cat-pinged.png";


// Other constants:
// ================
const config = {
    pongs: {
        min: 3,
        multiplier: 10, // Range(0 .. 1) * multiplier
        msBetween: 1000
    }
};

// Variables:
// ==========
let gameLock: boolean = false;
let frameCount: number = 0;

/**
 * This gets the next games pongs
 */
function getGamePongs(): number {
    return Math.ceil(Math.random() * config.pongs.multiplier + config.pongs.min);
}

function setCatsIdle() {
    [catLeft, catRight].forEach(cat => {
        cat.setFrame(directoryCatWhileGaming + fileCatStandBy);
    });
}
function getRandomIndex(array: Array<string>): number {
    let multiplier: number = Math.random()
    return Math.ceil(array.length * multiplier) - 1;
}

function getWinningCat(): Cat {
    return frameCount % 2 == 0 ? catRight : catLeft;
}
function getLosingCat(): Cat {
    return frameCount % 2 == 1 ? catRight : catLeft;
}
function stepCatsPlayingPingPong() {
    if(frameCount % 2 == 0) {
        getWinningCat().setFrame(directoryCatWhileGaming + fileCatPong);
        getLosingCat().setFrame(directoryCatWhileGaming + fileCatStandBy);
    } else {
        getLosingCat().setFrame(directoryCatWhileGaming + fileCatStandBy);
        getWinningCat().setFrame(directoryCatWhileGaming + fileCatPong);
    }
    console.log("Pong!");
    frameCount++;
}
function endGame() {
    console.log("Winning cat:");
    console.log(getWinningCat());

    getWinningCat().setFrame(directoryCatSuccess + filesCatSuccess[getRandomIndex(filesCatSuccess)])
    getLosingCat().setFrame(directoryCatFailure + filesCatFailure[getRandomIndex(filesCatFailure)])

    getWinningCat().increaseScore();
    gameLock = false;
}

function game() {
    if(gameLock) {return}
    gameLock = true;

    // Init game:
    setCatsIdle();
    frameCount = 0;
    let pongs: number = getGamePongs();

    // Animate:
    let delay: number = config.pongs.msBetween;
    for (let i = 0; i < pongs; i++) {
        setTimeout(stepCatsPlayingPingPong, delay);
        delay += config.pongs.msBetween;
    }
    setTimeout(endGame, delay + config.pongs.msBetween);
}

window.onload = () => {
    setCatsIdle();
}

