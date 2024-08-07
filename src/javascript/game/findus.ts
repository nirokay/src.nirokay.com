function get(id: string): HTMLElement | null {
    return document.querySelector("#" + id);
}
const foodCheckbox = get("i-would-give-food-to-findus") as HTMLInputElement;
const creditCardCheckbox = get("oh-hell-yeah-lets-go") as HTMLInputElement;
const creditCardStealer = get("gimme-gimme-more-gimme-gimme-gimme-more") as HTMLInputElement;
const testPassed = get("good-person") as HTMLDialogElement;
const testFailed = get("bad-person") as HTMLDialogElement;

creditCardStealer.style.visibility = "hidden";
creditCardCheckbox.checked = false;

creditCardCheckbox.addEventListener("change", () => {
    if(creditCardCheckbox.checked) {
        creditCardStealer.style.visibility = "visible";
        creditCardStealer.value = "";
    } else {
        creditCardStealer.style.visibility = "hidden";
    }
});

function submitForm() {
    testFailed.open = false;
    testPassed.open = false;
    let passed = foodCheckbox.checked;
    let dialog = passed ? testPassed : testFailed;
    dialog.open = true;
}
