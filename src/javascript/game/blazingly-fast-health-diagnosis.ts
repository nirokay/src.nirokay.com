const idLanguageVar: string = "page-language-variable"
const idDiagnosisName: string = "diagnosis-name"

const idLoadingText: string = "loading-text"
const idPrefixQuestionNumber: string = "quiz-question-nr-"
const idSuffixQuestionYouTrustEverythingOnTheInternet: string = "nah-scratch-that-this-stays-on"

const idPageLanguage: string = "page-language-variable"
enum Section {
    idSectionStartQuiz = "section-start-quiz",
    idSectionQuiz = "section-doing-quiz",
    idSectionComputing = "section-computing-results",
    idSectionShowingResults = "section-showing-results"
}

let language: string = "enGB";
/**
 * Sets the `language` variable, used for retrieving illness names
 */
function getLanguage() {
    let element: HTMLElement|null = document.getElementById(idLanguageVar);
    if(element == null) {
        // Default to english
        console.warn("Could not find language, using default value.");
        return;
    }
    language = element.innerHTML;
}


interface Illness {
    "enGB": string;
    "deDE": string;
}
interface FatalIllnesses {
    noSymptoms: Illness,
    allSymptoms: Illness
}

function ill(enGB: string, deDE: string): Illness {
    let result = {
        "enGB": enGB,
        "deDE": deDE
    };
    return result;
}
const illnesses: Illness[] = [
    ill(
        "Kidney Failure",
        "Nierenversagen"
    ),
    ill(
        "Heart Failure",
        "Herzversagen"
    ),
    ill(
        "Breast Cancer",
        "Brustkrebs"
    ),
    ill(
        "Skin Cancer",
        "Hautkrebs"
    ),
    ill(
        "Lung Cancer",
        "Lungenkrebs"
    ),
    ill(
        "Paper Cut :( ouch",
        "Papierschnittwunde :( aua"
    )
];
const fatalIllnesses: FatalIllnesses = {
    noSymptoms: ill(
        "Death",
        "Tod"
    ),
    allSymptoms: ill(
        "100% Healthy",
        "100% Gesund"
    )
}

function getAccurateDiagnosisOneHundredPercentNotACompletelyRandomPickFromAList(): Illness {
    let symptomCount: number = 0;
    let checkboxCount: number = 0;
    let defaultIllness: Illness = ill(
        "Mysterious Disease",
        "Mysteriöse Krankheit"
    );

    // Count illness symptoms by checking the checkboxes:
    for(let i = 0; i < 1024; i++) {
        const id: string = idPrefixQuestionNumber + i.toString();
        let element: HTMLInputElement|null = document.getElementById(id) as HTMLInputElement;
        if(element == undefined || element == null) break;

        if(element.checked) symptomCount++;
        checkboxCount++;
    }

    // Pick ~~a random~~ *the correct* disease:
    let illnessIndex: number = checkboxCount % illnesses.length;
    let totallyAccurateDiagnosis: Illness = illnesses[illnessIndex];

    // Override for fatal situations (being healthy is counted as fatal, as it should be):
    switch(symptomCount) {
        case 0:
            totallyAccurateDiagnosis = fatalIllnesses.noSymptoms;
            break;
        case checkboxCount:
            totallyAccurateDiagnosis = fatalIllnesses.allSymptoms;
            break;
        default:
            break;
    }

    return totallyAccurateDiagnosis ?? defaultIllness;
}

/**
 * Hides all sections, except the specified one
 */
function showOnlySection(toShow: Section) {
    Object.values(Section).forEach(section => {
        console.log(section, toShow, section === toShow)
        let visibility: string = "none";
        if(section === toShow) visibility = "initial";
        let element: HTMLElement|null = document.getElementById(section);
        if(element == null) {
            console.warn("Could not find section with ID: '" + section + "'");
            return;
        }
        element.style.display = visibility;
    });

    // Ensure checkbox is always checked:
    checkSillyCheckbox();
}
/**
 * Activates visibility of `Section.idSectionShowingResults`
 */
function spinLoadingText() {
    let element: HTMLElement|null = document.getElementById(idLoadingText);
    /**
     * Gets waited on and displays results
     */
    function switchToResults() {
        showOnlySection(Section.idSectionShowingResults);
    }

    if(element != null) {
        element.classList.add("animated");
        element.classList.add("twister");
        setTimeout(switchToResults, 5500)
    } else {
        setTimeout(switchToResults, 2000)
    }
}

/**
 * Invoked via button -> Shows question
 */
function startQuiz() {
    showOnlySection(Section.idSectionQuiz);
}

/**
 * Invoked via button -> Shows computing "process"
 */
function submitQuiz() {
    showOnlySection(Section.idSectionComputing);
    spinLoadingText();
}

/**
 * Invoked via button -> Resets stuff and shows questions again
 */
function restartQuiz() {
    // TODO: clean questions
    startQuiz();
}

function getSillyCheckbox(): HTMLInputElement|null {
    let id: string = idPrefixQuestionNumber + idSuffixQuestionYouTrustEverythingOnTheInternet;
    let result: HTMLInputElement|null = document.getElementById(id) as HTMLInputElement;
    if(result == null || result == undefined) console.warn("Element by id '" + id + "' not found...");
    return result;
}
function checkSillyCheckbox() {
    let element: HTMLInputElement|null = getSillyCheckbox();
    if(element == null || element == undefined) return;
    element.checked = true;
}
function sillyCheckbox() {
    let element: HTMLInputElement|null = getSillyCheckbox();
    if(element == null || element == undefined) return;
    checkSillyCheckbox();
    element.addEventListener("change", () => {
        setTimeout(() => {
            element.checked = true;
        }, 200)
    });
}

window.onload = () => {
    getLanguage();
    sillyCheckbox();
}
