document.addEventListener('turbo:load', function() {

    // Обработчик для кнопок голосования
    document.querySelectorAll('.vote').forEach(function(element) {
        element.addEventListener('ajax:success', function(event) {
            event.preventDefault();

            const rating = event.detail[0].rating;
            element.style.display = 'none';

            const votesContainer = element.closest('.votes');
            votesContainer.querySelector('.delete-vote').style.display = '';
            votesContainer.querySelector('.rating').textContent = rating;
        });

        element.addEventListener('ajax:error', function(event) {
            const [data, status, xhr] = event.detail;
            let errors = data && data.errors;
            if (!errors) {
                errors = ['An error occurred'];
            }
            const ratingErrors = element.closest('.votes').querySelector('.rating-errors');
            ratingErrors.innerHTML = '<p>Error(s) detected:</p>';

            errors.forEach(function(error) {
                const p = document.createElement('p');
                p.textContent = error;
                ratingErrors.appendChild(p);
            });
        });
    });

    // Обработчик для кнопки удаления голоса
    document.querySelectorAll('.delete-vote').forEach(function(element) {
        element.addEventListener('ajax:success', function(event) {
            event.preventDefault();

            const rating = event.detail[0].rating;
            element.style.display = 'none';

            const votesContainer = element.closest('.votes');
            votesContainer.querySelector('.vote').style.display = '';
            votesContainer.querySelector('.rating').textContent = rating;
        });

        element.addEventListener('ajax:error', function(event) {
            const [data, status, xhr] = event.detail;
            let errors = data && data.errors;
            if (!errors) {
                errors = ['An error occurred'];
            }
            const ratingErrors = element.closest('.votes').querySelector('.rating-errors');
            ratingErrors.innerHTML = '<p>Error(s) detected:</p>';

            errors.forEach(function(error) {
                const p = document.createElement('p');
                p.textContent = error;
                ratingErrors.appendChild(p);
            });
        });
    });
});