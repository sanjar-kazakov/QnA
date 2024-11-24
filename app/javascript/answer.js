$(document).on('turbo:load', function() {
    $('.answers').on('click', '.edit-answer-link', function(e) {
        e.preventDefault();
        $(this).hide();
        let answerId = $(this).data('answerId');
        $('form#edit-answer-' + answerId).removeClass('hidden');
    });

    $('form.new-answer').on('ajax:success', function(e) {
        let answer = e.detail[0];

        let newAnswerHtml = `<div class="answer" id="answer-${answer.id}">
                                <p>${answer.body}</p>`;

        if (answer.attachments) {
            answer.attachments.forEach(function(attachment) {
                newAnswerHtml += `<li><a href="${attachment.url}" target="_blank">${attachment.filename}</a></li>`;
            });
        }

        $('.answers').append(newAnswerHtml);


        $('.new-answer #answer_body').val('');
    })
        .on('ajax:error', function(e) {
            let errors = e.detail[0];
            let $errorsContainer = $('.answer-errors');

            $errorsContainer.empty();

            $.each(errors, function(index, value) {
                $errorsContainer.append('<p>' + value + '</p>');
            });
        });
});