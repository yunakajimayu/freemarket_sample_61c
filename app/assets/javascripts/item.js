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
  $('[name*="DeliveryFee"]').change(function(){
    var val = $(this).val();

    switch(val){
      case "Seller" :
        $('.buyer').hide()
        $('.seller').show()
      break;
      case "Buyer" :
        $('.seller').hide()
        $('.buyer').show()
      break;
    }
    

  })
  // $("select").prepend($("<option selected>").text("---"));

})