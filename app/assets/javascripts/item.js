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
