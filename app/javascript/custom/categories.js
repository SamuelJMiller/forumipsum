let dropped = false;
let tables = document.getElementsByClassName("border-table");

document.getElementsByClassName("category-show-button")[0].onclick(onclick());

function onclick() {
    for ( let i = 0; i < tables.length; ++i ) {
        tables[i].style.visibility = "hidden";
    }
}