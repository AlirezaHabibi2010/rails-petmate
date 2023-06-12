import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"]

  connect() {
    this.highlightStars();
  }

  highlightStars() {
    const rating = parseInt(this.data.get("rating") || 0);
    this.starTargets.forEach((star, index) => {
      const radioButton = document.getElementById(`rating_${index + 1}`);
      radioButton.checked = index < rating;
      if (index < rating) {
        star.classList.add("fa-solid");
        star.classList.remove("fa-regular");
      } else{
        star.classList.remove("fa-solid");
        star.classList.add("fa-regular");
      }

    });
  }

  selectStar(event) {
    const rating = event.currentTarget.dataset.value;
    this.data.set("rating", rating);
    this.highlightStars();
    console.log(this.data)
  }
}
