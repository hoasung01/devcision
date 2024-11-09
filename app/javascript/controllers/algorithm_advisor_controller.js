import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "description",
    "analysisResult",
    "problemType",
    "requirements",
    "suggestions",
    "primarySuggestion",
    "alternativeSuggestions",
    "analyzeButton",
    "errorContainer"
  ]

  // Analyze input as user types (with debounce)
  analyzeInput() {
    if (this.timeout) clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const description = this.descriptionTarget.value
      if (description.length > 20) {
        this.getAiAnalysis()
      }
    }, 1000)
  }

  displayError(errorMessage) {
    // Set the error message
    this.errorContainerTarget.textContent = errorMessage;

    // Display the error message
    this.errorContainerTarget.classList.remove('d-none');

    // Automatically hide the error after a few seconds
    setTimeout(() => {
      this.errorContainerTarget.classList.add('d-none');
    }, 5000); // Adjust the time as needed
  }


  // Get AI analysis
  getAiAnalysis = async (event) => {
    event.preventDefault()

    // Show loading state
    this.analyzeButtonTarget.disabled = true
    this.analyzeButtonTarget.innerHTML = `
      <span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
      Analyzing...
    `

    try {
      const response = await fetch('/visitor/analyze_problem', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({ description: this.descriptionTarget.value })
      })

      const data = await response.json()

      if (data.success) {
        this.displayAnalysis(data.analysis)
        this.displaySuggestions(data.suggestions)
      } else {
        this.displayError(data.error || 'Analysis failed')
      }
    } catch (error) {
      console.error('Error getting AI analysis:', error)
      this.displayError('Failed to get AI analysis. Please try again.')
    } finally {
      // Reset button state
      this.analyzeButtonTarget.disabled = false
      this.analyzeButtonTarget.innerHTML = 'Analyze with AI'
    }
  }


  displayAnalysis(analysis) {
    this.analysisResultTarget.classList.remove('d-none')
    this.problemTypeTarget.textContent = analysis.problem_type

    // Display requirements
    this.requirementsTarget.innerHTML = `
      <li>Input Size: ${analysis.input_size}</li>
      <li>Time Complexity: ${analysis.time_complexity}</li>
      <li>Space Complexity: ${analysis.space_complexity}</li>
      ${analysis.special_requirements.map(req => `<li>${req}</li>`).join('')}
    `
  }

  displaySuggestions(suggestions) {
    this.suggestionsTarget.classList.remove('d-none')

    // Display primary suggestion
    this.primarySuggestionTarget.innerHTML = `
      <div class="mb-2"><strong>${suggestions.primary_suggestion.name}</strong></div>
      <p class="mb-2">${suggestions.primary_suggestion.reason}</p>
      <div class="mb-2">
        <span class="badge bg-primary me-2">${suggestions.primary_suggestion.complexity}</span>
      </div>
      <div class="small text-muted">
        Trade-offs:
        <ul>
          ${suggestions.primary_suggestion.trade_offs.map(t => `<li>${t}</li>`).join('')}
        </ul>
      </div>
    `

    // Display alternatives
    this.alternativeSuggestionsTarget.innerHTML = suggestions.alternatives.map(alt => `
      <div class="card mb-2">
        <div class="card-body">
          <h6 class="card-title">${alt.name}</h6>
          <p class="small mb-1">${alt.reason}</p>
          <div class="small text-muted">
            Trade-offs:
            <ul>
              ${alt.trade_offs.map(t => `<li>${t}</li>`).join('')}
            </ul>
          </div>
        </div>
      </div>
    `).join('')
  }
}
