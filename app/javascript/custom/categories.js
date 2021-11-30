window.onload = function() {
    let headers = document.getElementsByClassName('category-name-span');
    let tables = document.getElementsByClassName('border-table');

    if (headers.length > 0) {
        for ( let i = 0; i < headers.length; ++i ) {
            headers[i].addEventListener('click', function() {
                if (tables[i].className === 'border-table') {
                    tables[i].className += ' hide';
                } else {
                    tables[i].className = 'border-table';
                }
            });
        }
    }
}