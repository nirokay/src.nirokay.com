
const idThesisDivPrefix: string = "id-thesis-div-"
const idThesisButtonsDiv: string = "id-thesis-buttons-"
const idThesisQuotePrefix: string = "id-thesis-quote-"
const idThesisAuthorPrefix: string = "id-thesis-author-"
const idThesisButtonAfdPrefix: string = "id-thesis-button-afd-"
const idThesisButtonOtherPrefix: string = "id-thesis-button-other-"

let lastQuestionsBuffer: Array<number> = [];
function addToBuffer(id: number) {
    lastQuestionsBuffer.push(id);
    if(lastQuestionsBuffer.length > 5) lastQuestionsBuffer.shift();
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
        if(element != null && element != undefined) break;
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
        if(buttons != null && buttons != undefined) buttons.style.display = "initial";

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
    if(element != null && element != undefined) element.style.display = "initial";
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
    addToBuffer(id);
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
    if(author != null && buttons != undefined) author.style.display = "initial";
}


function gameWhoSaidWhatInit() {
    // hideAllQuestions();
    viewRandomQuestion();
}


document.onload = () => {
    gameWhoSaidWhatInit();
};
