// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['toggleWrap'];

  toggle(event) {
    event.preventDefault();
    const toggleWrap = this.toggleWrapTarget;

    if (toggleWrap.classList.contains('hidden')) {
      toggleWrap.classList.remove('hidden');
      toggleWrap.style.height = `${toggleWrap.scrollHeight}px`;
    } else {
      toggleWrap.style.height = '0';
      toggleWrap.addEventListener('transitionend', () => {
        toggleWrap.classList.add('hidden');
      }, { once: true });
    }
  }

  connect() {
    console.log("connected")
  }
}
