export default {
  initialize: (el) => {
    var countryHeaders = el.querySelector('[data-country-list]').querySelectorAll('h3')
    var selectEl = el.querySelector('[data-country-nav]')
    var navHeight = 0;
    
    setNavHeight()
    selectEl.onchange = function () {jumpToCountry(this)}
    
    addIdsAndSelectOptions(countryHeaders, selectEl)
    addStickyScrollListener('country-nav__bar', 'country-nav')

    window.onresize = function () {
      setNavHeight()
      removeScrollListeners()
      addStickyScrollListener('country-nav__bar', 'country-nav')
    }

    function jumpToCountry(select) {
      if(select.value) {
        window.location.href = '#' + select.value
        var scrollDistance = $(document).scrollTop()
        $(document).scrollTop(scrollDistance - navHeight)
      }

      select.value = ''
    }

    function addIdsAndSelectOptions (headers, select) {
      for (let i = 0; i < headers.length; i++) {
        if(headers[i].textContent.trim()) {
          var name = headers[i].textContent
          var id = name
            .trim()
            .replace(/ /g, '-')
            .replace(/[,'()]/g,'')
            .toLowerCase()
    
            headers[i].id = id
            select.add(new Option(name, id))
        }
      }
    }

    function addStickyScrollListener (stickyElementClass, stickyElementPlaceholderClass) {
      var stickyElement = $('.' + stickyElementClass)
      var stickyElementPlaceholder = $('.' + stickyElementPlaceholderClass)
      
        var initialOffsetTop = stickyElementPlaceholder.offset().top
      
        $(document).scroll(function () {
          var scrollDistance = $(document).scrollTop()
   
          if(scrollDistance >= initialOffsetTop)  {
            stickyElement.addClass(stickyElementClass + '--sticky')
          } else {
            stickyElement.removeClass(stickyElementClass + '--sticky')
          }
        });
    }

    function removeScrollListeners () {
      $(document).off('scroll')
    }

    function setNavHeight () {
      navHeight = el.querySelector('.country-nav').offsetHeight
    }
  }
}
