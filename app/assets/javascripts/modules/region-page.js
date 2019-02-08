export default {
  initialize: (el) => {
    const countryHeaders = el.querySelector('[data-country-list]').querySelectorAll('h3')
    const selectEl = el.querySelector('[data-country-nav]')

    function jumpToCountry(select) {
      if(select.value) {window.location.href = '#' + select.value}
      select.value = ''
    }

    selectEl.onchange = function () {jumpToCountry(this)}
    
    for (let i = 0; i < countryHeaders.length; i++) {
      if(countryHeaders[i].textContent.trim()) {
        const name = countryHeaders[i].textContent
        const id = name
          .trim()
          .replace(/ /g, '-')
          .replace(/[,'()]/g,'')
          .toLowerCase()
  
        countryHeaders[i].id = id
        selectEl.add(new Option(name, id))
      }
    }
  }
}
