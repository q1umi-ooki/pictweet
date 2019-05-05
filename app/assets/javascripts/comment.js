$(function(){
    function buildHTML(comment){
      let html = `<p>
                  <strong><a href="/users/${comment.user_id}">${comment.user_name}</a>:</strong>${comment.text}
                </p>`
      return html;
    }
    $('#new_comment').on('submit', function(e){
      e.preventDefault();     
      let formData = new FormData(this);
      console.log(formData);
      let url = $('#new_comment').attr('action')
      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false,
      })
      .done(function(data){
        console.log(data)
        let html = buildHTML(data);
        $('.comments').append(html);
        $('.textbox').val('');
      })
      .fail(function(data){
        alert('error');
      })
    });
  });