// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "jquery";
import Rails from "@rails/ujs";
Rails.start();
import $ from 'jquery';
window.$ = $; // Чтобы jQuery был доступен глобально
window.jQuery = $; // Это необходимо для некоторых плагинов, которые требуют jQuery
