const idLanguageVar: string = "page-language-variable"
const idDiagnosisName: string = "diagnosis-name"

const idLoadingText: string = "loading-text"

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


window.onload = () => {
    getLanguage();
}
