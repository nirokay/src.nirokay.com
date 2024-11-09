const menuId: string = "id-menu-bar";

function getMenu(): HTMLElement | null {
    return document.getElementById(menuId);
}

function setSelectedToNavigation() {
    let element: HTMLSelectElement | null = getMenu() as HTMLSelectElement;
    if(element == null) {
        console.error("Could not find navigation menu by id " + menuId);
        return;
    }
    element.selectedIndex = 0;
}

function changeToSelectedPage() {
    let element: HTMLSelectElement | null = getMenu() as HTMLSelectElement;
    if(element == null) {
        console.error("Could not find navigation menu by id " + menuId);
        return;
    }
    if(element.selectedIndex == 0) {
        return;
    }
    window.location.href = "/" + element.value;
}
