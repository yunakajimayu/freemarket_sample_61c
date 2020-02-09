$(function(){

  $('#price').keyup(function() {
    var s = $('#price').val();
    var si = parseInt(s);
    var commission = Math.floor(si * 0.1)
    var sales = Math.floor(si * 0.9).toLocaleString();
    var comm = commission.toLocaleString();
    if( commission >= 30 && commission <= 9999999) {
      $('#commission').text(`¥${comm}`)
      $('#sales').text(`¥${sales}`)
    } else {
      $('#commission').text("-");
      $('#sales').text("-")
    }
  })

})