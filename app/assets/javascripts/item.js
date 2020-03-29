$(function(){

    // // クリックで画像を選択する場合
    $('#drop_area').on('click', function () {
      $('#input_file').click();
    });
  
    $('#drop_area').on('dragenter dragover', function (event) {
      event.stopPropagation();
      event.preventDefault();
      $('#drop_area').css('border', '1px solid #333');  // 枠を実線にする
    });
    $('#drop_area').on('dragleave', function (event) {
      event.stopPropagation();
      event.preventDefault();
      $('#drop_area').css('border', '1px dashed #aaa');  // 枠を点線に戻す
    });
  
  
    $('#drop_area').on('drop', function (event) {
      event.preventDefault();
  
      $('#input_file').each(function(i) {
        $('#input_file')[i].files = event.originalEvent.dataTransfer.files;
        handleFiles($('#input_file')[i].files);

        $('.preview_field_wrap #preview_field').append(html);
      })
      
    });
  
      $('#input_file').change(function(){
        
        if ( !this.files.length ) {
          return;
        }
        $('#preview_field').text('');
        var $files = $(this).prop('files');
        var len = $files.length;
        for ( var i = 0; i < len; i++ ) {
          var file = $files[i];
          var fr = new FileReader();
          fr.onload = function(e) {
            var src = e.target.result;
            var img = '<img src="'+ src +'">';
            var html =  `<div class="preview_field" >
                          <div class="preview_field--caption">
                            ${img}
                          </div>
                          <div class="preview_field--option">
                            <div class="preview_field--option--list">
                              <a class="preview_field--option--list--tag">削除</a>
                            </div>
                          </div>
                        </div>`
            $('.preview_field_wrap #preview_field').append(html);
            // $('.item__contents--image-upload-container').css('height','400px');
          }
     
          fr.readAsDataURL(file);
        }
        
        $('.preview_field_wrap').css('display','block');
      });
  

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

})



    