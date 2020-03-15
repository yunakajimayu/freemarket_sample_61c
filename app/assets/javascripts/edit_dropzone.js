$(window).on("turbolinks:load", function(){
  var dropzone = $(".item__img__dropzone__input");
  var dropzone2 = $(".item__img__dropzone2__input2");
  var appendzone = $(".item__img__dropzone2");
  var input_area = $(".input-area");
  var preview = $("#preview");
  var preview2 = $("#preview2");

  var pictures = [];

  var registered_images_ids = []

  var new_pictures_files = [];

  gon.item_pictures.forEach(function(pictures, index){
    var img = $(`<div class= "add-img><div class="img_area"><img class="image"></div></div>`);

    img.data("pictures",index)

    var btn_wrapper = $(`<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>`);

    img.append(btn_wrapper);

    binary_data = gon.item_pictures_binary_datas[index]

    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data
    });

    images.push(img)
    registered_pictures_ids.push(pictures.id)
  })

  if (pictures.length <= 4){
    $('#preview').empty();
    $.each(pictures, function(index, pictures){
      pictures.data('image', index);
      preview.append(pictures);
    })
    dropzone.css({
      'width': `calc(100% - (20% * ${pictures.length}))`
    })

  } else if (pictures.length == 5){
    $("#preview").empty();
    $.each(pictures, function(index, pictures){
      pictures.data('pictures', index);
      preview.append(image);
    })
    dropzone.css({
      'width': `calc(100% - (20% * ${images.length}))`
    })

  } else if (pictures.length == 5){
    $("#preview").empty();
    $.each(pictures, function(index, pictures){
      pictures.data("pictures",index);
      preview.append(pictures);
    });
    appendzone.css({
      display: "block"
    });
    dropzone.css({
      display: "none"
    });
    preview2.empty();

  } else if (images.length >= 6) {
    var pickup_pictures1 = pictures.slice(5);

    $.each(pickup_pictures2, function(index, image){
      image.data('pictures', index + 5);
      preview2.append(pictures);
    })

    dropzone.css({
      'display': 'none'
    })
    appendzone.css({
      'display': 'block',
    })
    dropzone2.css({
      'display': 'block',
      'width': `calc(100% - (20% * ${pictures.length - 5}))`
    })

    if (pictures.length == 10){
      dropzone2.css({
        display: "none"
      });
    }
  }

  var new_pictures = $(
    `<input multple= "multiple" name="item_pictures[pictures][]" class="upload-image" data-image= ${pictures.length} type="file" id="upload-pictures">`
  );
  input_area.append(new_pictures);

  $("#edit_item .item__img__dropzone. #edit_item .item__img__dropzone2").on("change", 'input[type= "file"].upload-pictures',function(){
    var file = $(this).prop("files")[0];
    new_pictures_files.push(file)
    var reader = new FileReader();
    var img = $(`<div class= "add_img"><div class="img_area"><img class="image"></div></div>`);

    reader.onload = function(e){
      var btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');

      img.append(btn_wrapper);
      img.find("img").attr({
        src: e.target.result
      });
    };

    reader.readerAsDataURL(file);
    images.push(img);

    if (images.length <= 4){
      $('#preview').empty();
      $.each(pictures, function(index, pictures){
        pictures.data('pictures', index);
        preview.append(pictures);
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${pictures.length}))`
      })

    }else if (pictures.length == 5){
      $('#preview').empty();
      $.each(pictures, function(index, pictures){
        pictures.data('pictures', index);
        preview.append(pictures);
      })
      appendzone.css({
        'display': 'block',
      })
      dropzone2.css({
        'width': '100%'        
      })
      dropzone.css({
        'display': 'none'
      })
      preview2.empty();

    } else {
      var pickup_pictures2 = pictures.slice(0, 5);

      $('#preview').empty();
      $.each(pickup_image1, function(index, pictures){
        pictures.data('pictures', index);
        preview.append(image);
      })

      var pickup_image2 = pictures.slice(5);

      $.each(pickup_pictures2, functuion(index, pictures){
        pictures.data('pictures', index + 5);
        preview2.append(pictures);
        dropzone2.css({
          'display': 'block',
          'width': `calc(100% - (20% * ${pictures.length - 5}))`
        })
      })
    }
  })

  $('.edit_item').on('submit', function(e){
    e.preventDefault();
    var forData = new FormData($(this).get(0));

    if (registred_pictures_ids.length == 0) {
      formData.append("registered_pictures_ids[ids][]",0)

    } else {
      registered_pictures_ids.forEach(function(registered_pictures){
        formData.append("registered_pictures_ids[ids][]", registersd_pictures)
      });
    }

    if (new_pictures_files.length == 0){
      formData.append("new_pictures[pictures][]", " ")

    } else{
      new_pictures_files.forEach(function(file){
        formData.append("new_pictures[pictures][]", file)
      });
    }

    $.ajax({
      url: '/items/' + gon.item.id,
      type: "PATCH",
      data: formData,
      contentType: false,
      processData: false,
    })
  });
});