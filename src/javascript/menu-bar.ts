const menuId: string = "id-menu-bar";

function getMenu(): HTMLElement | null {
    return document.getElementById(menuId);
}

function changeToSelectedPage() {
    let element: HTMLSelectElement | null = getMenu() as HTMLSelectElement;
    if(element == null) {
        console.error("Could not find navigation menu by id " + menuId);
        return;
    }
    window.location.href = "/" + element.value;
}
