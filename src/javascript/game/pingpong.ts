const directoryGameResources: string = "../resources/images/games/pingpong/";
let debugPrint: boolean = false;
function debug(msg: string, element: any = null) {
    if(! debugPrint) {return}
    console.log(msg);
    if(element != null) {
        console.log(element);
    }
}

interface Dictionary {
    [key: string]: string|null;
}

// Html IDs:
// =========
class Ball {
    constructor(picture: string) {
        this.pictureId = picture;
    }
    pictureId: string;
}

class Cat {
    constructor(name: string, picture: string, score: string, highscore: string) {
        this.name = name;
        this.pictureId = picture;
        this.scoreId = score;
        this.highscoreId = highscore;
    }
    name: string;
    pictureId: string;
    scoreId: string;
    highscoreId: string;

    /**
     * Updates the source of the cat image element
     */
    setFrame(source: string) {
        let element: HTMLPictureElement | null = document.getElementById(this.pictureId) as HTMLPictureElement;
        if(element == null) {
            console.error("Cat by id " + this.pictureId + " not found :(");
            return;
        }
        element.setAttribute("src", directoryGameResources + source);
    }

    /**
     * Sets the score of the cat
     */
    setScore(score: number) {
        let element: HTMLElement | null = document.getElementById(this.scoreId);
        if(element == null) {
            console.error("Cat score by id " + this.scoreId + " not found");
            return;
        }
        element.innerHTML = score.toString();
    }
    /**
     * Increments the cat score
     */
    increaseScore() {
        let element: HTMLElement | null = document.getElementById(this.scoreId);
        if(element == null) {
            console.error("Cat score by id " + this.scoreId + " not found");
            return;
        }
        this.setScore(parseInt(element.innerHTML) + 1);

        switch(this.name) {
            case "left":
                updateHighscore(1, 0);
                break;
            case "right":
                updateHighscore(0, 1);
                break;
            default:
                // This should never happen:
                console.error("Wtf kind of cat name is " + this.name);
        }
    }

    /**
     * Shifts the cat up
     */
    shiftUp() {
        let element: HTMLPictureElement | null = document.getElementById(this.pictureId) as HTMLPictureElement;
        if(element == null) {
            console.error("Cat picture by id " + this.pictureId + " not found");
            return;
        }
        element.style.alignSelf = "baseline";
        setTimeout(() =>{
            element.style.alignSelf = "end";
        }, config.pongs.msPongLength);
    }
}

let catLeft = new Cat("left", "id-cat-left-picture", "id-cat-left-score", "id-cat-left-highscore");
let catRight = new Cat("right", "id-cat-right-picture", "id-cat-right-score", "id-cat-right-highscore");

let ballLeft = new Ball("id-ball-left");
let ballRight = new Ball("id-ball-right");
let ballLeftGameOver = new Ball("id-ball-left-game-over");
let ballRightGameOver = new Ball("id-ball-right-game-over");
const idButtonStartGame: string = "id-button-start-game";


// Cat files:
// ==========
//  - Cat failures:
const directoryCatFailure: string = "cat/failure/";
const filesCatFailure: string[] = [
    "cry.gif",
    "disbelief.gif",
    "rage.gif",
    "sad.gif",
    "shock.gif"
];
//  - Cat successes:
const directoryCatSuccess: string = "cat/success/";
const filesCatSuccess: string[] = [
    "dance.gif",
    "grin.gif",
    "happy.gif",
    "smug.gif",
    "yippie.gif"
];
//  - Cat assets:
const directoryCatWhileGaming: string = "cat/";
const fileCatStandBy: string = "standby.png";
const fileCatPong: string = "pong.png";

//  - Ball assets:
const fileBall: string = "ball.png";
const fileBallEmpty: string = "ball_empty.png";


// Audio files:
// ============
const directorySounds: string = "../resources/sounds/games/pingpong/";
function newSound(filename: string): HTMLAudioElement {
    return new Audio(directorySounds + filename);
}
const soundPingPong: HTMLAudioElement = newSound("pingpong.mp3");
const soundYippie: HTMLAudioElement = newSound("yippie.mp3");
const soundWinningMusic: HTMLAudioElement = newSound("winning-music.mp3");
soundWinningMusic.volume = 0.5;


// Cookie:
// =======
/**
 * Returns cookie in a index-value pair dictionary
 * @returns object Dictionary of key-value pairs
 */
function fetchCookie(): Dictionary {
    let result: Dictionary = {};
    let cookie: string = document.cookie;
    cookie.split(";").forEach((raw: string) => {
        let splitValues: string[] = raw.trim().split("=");
        let index: string = splitValues[0];
        if(splitValues.length < 2) {
            result[index] = null;
            return;
        }
        let value: string = splitValues[1];
        result[index] = value;
    });
    return result;
}
/**
 * Pushes the cookie into storage
 */
function sendCookie(dictionary: Dictionary) {
    //                           y    d     constant (full day)
    let expirationDays: number = 5 * 365 * (1000 * 60 * 60 * 24);
    let expirationDate: number = new Date().getTime() + expirationDays;
    for (const index in dictionary) {
        if (Object.prototype.hasOwnProperty.call(dictionary, index)) {
            const value: string = dictionary[index] ?? "";
            let newCookieValue: string = index + "=" + value + "; expires=" + expirationDate.toString() + "; ";
            document.cookie = newCookieValue;
            console.log(newCookieValue)
        }
    }
}


// Highscore:
// ============
function updateHighscore(addLeft: number, addRight: number) {
    let cookie: Dictionary = fetchCookie();
    let highscoreLeft: number = 0;
    let highscoreRight: number = 0;

    // Get cookie score:
    let currentScores: string[] = (cookie["highscore"] ?? "0:0").split(":");
    try {
        highscoreLeft = parseInt(currentScores[0]);
    } catch(error) {
        console.error(error);
    }
    try {
        highscoreRight = parseInt(currentScores[1]);
    } catch(error) {
        console.error(error);
    }

    // Update highscore:
    highscoreLeft += addLeft;
    highscoreRight += addRight;

    // Update Cookie:
    let newScore: string = highscoreLeft.toString() + ":" + highscoreRight.toString();
    cookie["highscore"] = newScore;
    sendCookie(cookie);

    // Update HTML:
    let htmlHighscoreLeft: HTMLElement|null = document.getElementById(catLeft.highscoreId);
    if(htmlHighscoreLeft != null) {htmlHighscoreLeft.innerHTML = highscoreLeft.toString()}
    let htmlHighscoreRight: HTMLElement|null = document.getElementById(catRight.highscoreId);
    if(htmlHighscoreRight != null) {htmlHighscoreRight.innerHTML = highscoreRight.toString()}
}


// Other constants:
// ================
const config = {
    pongs: {
        min: 2,
        multiplier: 10, // Range(0 .. 1) * multiplier
        msPongInterval: 1000,
        msPongLength: 200
    }
};


// Variables:
// ==========
let gameLock: boolean = false;
let frameCount: number = 0;


// Game logic stuff:
// =================
/**
 * This gets the next games pongs
 */
function getGamePongs(): number {
    let result: number =  Math.ceil(Math.random() * config.pongs.multiplier + config.pongs.min);
    debug("Random pong: " + result.toString());
    return result;
}

/**
 * Sets all balls invisible except the one that is passed to it
 */
function moveBallTo(ball: Ball) {
    [ballLeft, ballRight, ballLeftGameOver, ballRightGameOver].forEach(ball => {
        let id: string = ball.pictureId;
        let picture: HTMLPictureElement | null = document.getElementById(id) as HTMLPictureElement;
        if(picture == null) {
            console.error("Failed to find ball by id " + id);
            return;
        }
        picture.setAttribute("src", directoryGameResources + fileBallEmpty);
    });

    if(ball.pictureId == "null") {return}

    let picture: HTMLPictureElement | null = document.getElementById(ball.pictureId) as HTMLPictureElement;
    if(picture == null) {
        console.error("Failed to find ball by id " + ball.pictureId);
        return;
    }
    picture.setAttribute("src", directoryGameResources + fileBall);
}

/**
 * Updates the "Start Game" button text
 */
function setButtonText(text: string) {
    let button: HTMLButtonElement = document.getElementById(idButtonStartGame) as HTMLButtonElement;
    if(button == null) {
        console.error("Button not found by id " + idButtonStartGame);
        return;
    }
    button.innerHTML = text;
}

/**
 * Inits cats as idle
 */
function setCatsIdle() {
    [catLeft, catRight].forEach(cat => {
        cat.setFrame(directoryCatWhileGaming + fileCatStandBy);
    });
}
/**
 * Gets a random index of an array
 */
function getRandomIndex(array: Array<string>): number {
    let multiplier: number = Math.random()
    return Math.ceil(array.length * multiplier) - 1;
}

/**
 * Gets the currently winning cat (the one that pongs)
 */
function getWinningCat(): Cat {
    return frameCount % 2 == 0 ? catRight : catLeft;
}
/**
 * Gets the currently losing cat (the one that is about to pong)
 */
function getLosingCat(): Cat {
    return frameCount % 2 == 1 ? catRight : catLeft;
}
/**
 * Animates and updates cats and balls - increments `frameCount`
 */
function stepCatsPlayingPingPong(pongs: number) {
    let winningCat: Cat = getWinningCat();
    let losingCat: Cat = getLosingCat();
    soundPingPong.play();

    // Animate cats:
    losingCat.setFrame(directoryCatWhileGaming + fileCatStandBy);
    winningCat.setFrame(directoryCatWhileGaming + fileCatPong);
    winningCat.shiftUp();
    setTimeout(() => {
        winningCat.setFrame(directoryCatWhileGaming + fileCatStandBy);
    }, config.pongs.msPongLength);

    // Update frame counter:
    frameCount++;

    // Update ball:
    let ballPosition: Ball = winningCat.scoreId == catLeft.scoreId ? ballLeft : ballRight;
    if(frameCount < pongs) {
        // Normal ball update:
        moveBallTo(ballPosition);
    } else {
        // Game over ball position:
        setTimeout(() => {
            let finalBallPosition: Ball = ballPosition == ballLeft ? ballLeftGameOver : ballRightGameOver;
            moveBallTo(finalBallPosition);
        }, config.pongs.msPongLength);
    }
}
/**
 * Updates cats and score on game ending
 */
function endGame() {
    let winnerGif: string = directoryCatSuccess + filesCatSuccess[getRandomIndex(filesCatSuccess)];
    let loserGif: string = directoryCatFailure + filesCatFailure[getRandomIndex(filesCatFailure)];
    getWinningCat().setFrame(winnerGif);
    getLosingCat().setFrame(loserGif);

    soundYippie.play();
    getWinningCat().increaseScore();

    setTimeout(() => {
        soundWinningMusic.play();
        setButtonText("Another round!");
        gameLock = false;
    }, 1000);
}

/**
 * Game logic function (called by the "Start Game" button)
 */
function game() {
    // Ignore when game is in action:
    if(gameLock) {return}

    // Lock for game and reset resources:
    gameLock = true;
    setButtonText("Waiting for results...");

    // Stop winning music:
    soundWinningMusic.pause();
    soundWinningMusic.currentTime = 0;

    // Init game:
    setCatsIdle();
    frameCount = 0;
    let pongs: number = getGamePongs();

    // Animate:
    let delay: number = config.pongs.msPongInterval;
    for (let i = 0; i < pongs; i++) {
        setTimeout(stepCatsPlayingPingPong, delay, pongs);
        delay += config.pongs.msPongInterval;
    }
    setTimeout(endGame, delay + config.pongs.msPongInterval);
}

window.onload = () => {
    moveBallTo(new Ball("null")); // Inits sources for the balls
    setCatsIdle(); // Inits sources for the cats
    setButtonText("Begin the battle!"); // Overrides the button text to before-first-game state
    updateHighscore(0, 0); // Display highscore
}

