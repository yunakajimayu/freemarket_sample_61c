$(function(){
  
  Dropzone.autoDiscover = false;

  $(".dropzone").dropzone({
    autoProcessQueue:false, 
    dictDefaultMessage: 'アップロードするファイルをここへドロップしてください',
    previewsContainer:".preview",
    thumbnailHeight:"120",
    thumbnailWidth:"120",
    thumbnailMethod:"contain",
    maxFiles:"10",
    addRemoveLinks:true,
    dictRemoveFile:'削除'

  });

  $('submit').click(function(){
    myDropzone.processQueue()
  })

  Dropzone.autoDiscover = false;

  $(".dropzone").dropzone({
    autoProcessQueue:false, 
    dictDefaultMessage: 'アップロードするファイルをここへドロップしてください',
    previewsContainer:".preview",
    thumbnailHeight:"120",
    thumbnailWidth:"120",
    thumbnailMethod:"contain",
    maxFiles:"10",
    addRemoveLinks:true,
    dictRemoveFile:'削除'
    
  });

  $('submit').click(function(){
    myDropzone.processQueue()
  })

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
  var name = "[name*=item\\[delivery_attributes\\]\\[postage_bearer\\]]"
  
  $(name).change(function(){
    $('.delivery-method').show()
    val = $(name).val()
    switch(val){
      case 'buyer' :
        $(`option[value="letter_pack"],
          option[value="standard_mail"],
          option[value="click_post"],
          option[value="yu_packet"]`).hide()
        break;
    }
  })

  $('#upload_file').on('change', function()
    var strFileInfo = $(#upload_file)[0].files[0];
    if(strFileInfo && strFileInfo.type.match('image.*')){
      $('preview').remove();
      $('.preview_area').append('<img id="preview" width="300" />');
      fileReader = new FileReader(); // 解説⑥
      fileReader.onload = function(event){
        $('#preview').attr('src', event.target.result);
      }

      fileReader.readAsDataURL(strFileInfo); // 解説⑦
    }
  );

})

