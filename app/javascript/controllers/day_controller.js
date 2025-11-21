import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { dayDate: String }

  open(event) {
    const date = this.element.dataset.dayDate
    const url = `/shopping_lists/new?date=${date}`
    
    // Turbo Frame にロード
    const frame = document.getElementById("shopping_list_modal")
    if (frame) {
      frame.src = url
    }
  }
}