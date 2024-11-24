document.addEventListener('turbo:load', function() {
    console.log('Votes script loaded');

    function handleSuccess(event, elementSelector, toggleSelector) {
        event.preventDefault();

        const rating = event.detail[0].rating;
        const container = elementSelector.closest('.votes');

        container.querySelector('.rating').textContent = rating;

        elementSelector.style.display = 'none';
        container.querySelector(toggleSelector).style.display = '';
    }

    function handleError(event) {
        const errors = event.detail[0];
        const flashAlert = $('.flash_alert');

        flashAlert.empty();
        $.each(errors, function(_, message) {
            flashAlert.append('<p>' + message + '</p>');
        });
        flashAlert.show();
    }

    document.querySelectorAll('.vote').forEach(function(element) {
        element.addEventListener('ajax:success', function(event) {
            handleSuccess(event, element, '.delete-vote');
        });
        element.addEventListener('ajax:error', handleError);
    });

    document.querySelectorAll('.delete-vote').forEach(function(element) {
        element.addEventListener('ajax:success', function(event) {
            handleSuccess(event, element, '.vote');
        });
        element.addEventListener('ajax:error', handleError);
    });
});