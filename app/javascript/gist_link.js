document.addEventListener('turbo:load', function() {
    loadGists('.gist-link');
});

function loadGists(selector) {
    document.querySelectorAll(selector).forEach(async function(gistLink) {
        const gistUrl = gistLink.getAttribute('href');
        const gistId = gistUrl.split('/').pop();  // Извлекаем ID Gist

        if (gistId) {
            try {
                const response = await fetch(`https://api.github.com/gists/${gistId}`);
                const gistData = await response.json();

                const gistFileContent = gistData.files[Object.keys(gistData.files)[0]].content;

                gistLink.insertAdjacentHTML('afterend', `<pre>${gistFileContent}</pre>`);
                gistLink.remove();
            } catch (error) {
                console.error('Error trying to load gist:', error);
            }
        }
    });
}