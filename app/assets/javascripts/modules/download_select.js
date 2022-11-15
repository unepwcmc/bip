export default {
  initialize: (selectEl) => {
    const downloadId = selectEl.dataset.downloadSelect
    const downloadEl = document.getElementById(downloadId)

    selectEl.addEventListener('change', function (event) {
      updateDownloadHref(event)
    })

    function updateDownloadHref() {
      downloadEl.href = selectEl.value
    }
  }
}
