// Settings:
const questionsWithoutRepeating: number = 25;

// Questions:
const idThesisDivPrefix: string = "id-thesis-div-";
const idThesisButtonsDiv: string = "id-thesis-buttons-";
const idThesisQuotePrefix: string = "id-thesis-quote-";
const idThesisAuthorPrefix: string = "id-thesis-author-";
const idThesisButtonAfdPrefix: string = "id-thesis-button-afd-";
const idThesisButtonOtherPrefix: string = "id-thesis-button-other-";

// Score:
const idScoreAbsoluteLeft: string = "id-score-absolute-left";
const idScoreAbsoluteRight: string = "id-score-absolute-right";

const idScoreUniqueLeft: string = "id-score-unique-left";
const idScoreUniqueMiddle: string = "id-score-unique-middle";
const idScoreUniqueRight: string = "id-score-unique-right";

// Buttons:
const idButtonStartQuestions: string = "id-button-start";
const idButtonSkipQuestion: string = "id-button-skip";
const idButtonNextQuestion: string = "id-button-next";
const buttonIds: Array<string> = [idButtonStartQuestions, idButtonSkipQuestion, idButtonNextQuestion];

function displayOnlyButton(id: string) {
    buttonIds.forEach((id) => {
        let button: HTMLButtonElement|null = document.getElementById(id) as HTMLButtonElement;
        if(button != null && button != undefined) button.style.display = "none";
    });
    let button: HTMLButtonElement|null = document.getElementById(id) as HTMLButtonElement;
    if(button != null && button != undefined) button.style.display = "block";
}


let allQuestionsBuffer: Array<number> = [];
function isUnique(id: number): boolean {
    return ! allQuestionsBuffer.includes(id);
}
function addToQuestionBuffer(id: number) {
    if(isUnique(id)) allQuestionsBuffer.push(id);
}

function increaseScore(id: number, correct: boolean) {
    function readAndIncrement(element: HTMLElement|null) {
        if(element == null || element == undefined) {
            console.warn("Passed invalid element");
            return;
        }
        try {
            let rawOldValue: string = element.innerHTML;
            let newValue: number = parseInt(rawOldValue) + 1;
            element.innerHTML = newValue.toString();
        } catch(e) {
            console.error("Could not increment score for element", element, e);
            try {
                element.innerHTML = "0";
            } catch(e) {
                console.error("Could not reset score to 0", e);
            }
        }
    }
    let absoluteLeft: HTMLElement|null = document.getElementById(idScoreAbsoluteLeft);
    let absoluteRight: HTMLElement|null = document.getElementById(idScoreAbsoluteRight);
    if(correct) readAndIncrement(absoluteLeft);
    readAndIncrement(absoluteRight);

    let uniqueLeft: HTMLElement|null = document.getElementById(idScoreUniqueLeft);
    let uniqueMiddle: HTMLElement|null = document.getElementById(idScoreUniqueMiddle);
    let uniqueRight: HTMLElement|null = document.getElementById(idScoreUniqueRight);
    if(isUnique(id)) {
        if(correct) readAndIncrement(uniqueLeft);
        readAndIncrement(uniqueMiddle);
    }
    if(uniqueRight != null && uniqueRight != undefined) uniqueRight.innerHTML = everyGameQuestionId().length.toString();

    addToQuestionBuffer(id);
}


let lastQuestionsBuffer: Array<number> = [];
function addToLastQuestionBuffer(id: number) {
    lastQuestionsBuffer.push(id);
    if(lastQuestionsBuffer.length > questionsWithoutRepeating) lastQuestionsBuffer.shift();
}


function getQuestion(id: number): HTMLElement|null {
    return document.getElementById(idThesisDivPrefix + id.toString());
}
function getQuestionButtons(id: number): HTMLElement|null {
    return document.getElementById(idThesisButtonsDiv + id.toString());
}
function getQuestionAuthor(id: number): HTMLElement|null {
    return document.getElementById(idThesisAuthorPrefix + id.toString());
}


function everyGameQuestionId(): Array<number> {
    let result: Array<number> = [];
    for (let id = 0; id < 1024; id++) {
        let element: HTMLElement|null = getQuestion(id);
        if(element == null || element == undefined) break;
        result.push(id);
    }
    return result;
}


function hideAllQuestions() {
    everyGameQuestionId().forEach(id => {
        let question: HTMLElement|null = getQuestion(id);
        let author: HTMLElement|null = getQuestionAuthor(id);
        let buttons: HTMLElement|null = getQuestionButtons(id);
        if(question != null && question != undefined) question.style.display = "none";
        if(author != null && author != undefined) author.style.display = "none";
        if(buttons != null && buttons != undefined) buttons.style.display = "block";

        try {
            question?.classList.remove("thesis-wrong-answer");
            question?.classList.remove("thesis-correct-answer");
        } catch(e) {
            console.warn("Caught error whilst removing class", e);
        }
    });
}

function viewQuestionWithId(id: number) {
    hideAllQuestions();
    let element: HTMLElement|null = getQuestion(id);
    if(element != null && element != undefined) element.style.display = "block";
}
function viewRandomQuestion() {
    let ids: Array<number> = everyGameQuestionId();
    let randomIndex: number = -1;
    let tries: number = 0;
    while(lastQuestionsBuffer.includes(randomIndex) || randomIndex == -1) {
        // Give up after 1024 tries without recent picks:
        if(tries >= 1024) {
            alert("Please refresh the website, something seems to be broken... ran function 'viewRandomQuestion()' over 1024 times...");
            break;
        }
        tries++;
        let random: number = Math.random();
        if(random === 1) random = 0.99999;
        randomIndex = Math.floor(random * ids.length) % ids.length;
    }

    let id: number = ids[randomIndex];
    viewQuestionWithId(id);
    addToLastQuestionBuffer(id);
}

function submitQuestion(id: number, correct: boolean) {
    let question: HTMLElement|null = getQuestion(id);
    console.log(correct);
    if(question != null && question != undefined) {
        if(correct) {
            question.classList.remove("thesis-wrong-answer");
            question.classList.add("thesis-correct-answer");
        }
        else {
            question.classList.remove("thesis-correct-answer");
            question.classList.add("thesis-wrong-answer");
        }
    } else {
        alert("Fuck");
    }
    let buttons: HTMLElement|null = getQuestionButtons(id);
    if(buttons != null && buttons != undefined) buttons.style.display = "none";
    let author: HTMLElement|null = getQuestionAuthor(id);
    if(author != null && author != undefined) {
        author.style.display = "block";
    } else {
        console.warn("Could not display author", author);
    }

    increaseScore(id, correct);
    displayOnlyButton(idButtonNextQuestion);
}


function whoSaidWhatStart() {
    viewRandomQuestion();
    displayOnlyButton(idButtonSkipQuestion);

    let uniqueRight: HTMLElement|null = document.getElementById(idScoreUniqueRight);
    if(uniqueRight != null && uniqueRight != undefined) uniqueRight.innerHTML = everyGameQuestionId().length.toString();
}
function whoSaidWhatSkip() {
    viewRandomQuestion();
    displayOnlyButton(idButtonSkipQuestion);
}
function whoSaidWhatNext() {
    viewRandomQuestion();
    displayOnlyButton(idButtonSkipQuestion);
}


document.onload = () => {
    displayOnlyButton(idButtonStartQuestions);
    hideAllQuestions();
};
