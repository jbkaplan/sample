$(document).ready(function() {

    playingCssClass = 'playing',
    audioObject = null;

  var fetchTracks = function (albumId, callback) {
      var request = $.ajax({
        url: 'https://api.spotify.com/v1/albums/' + albumId,
      });
      request.done(function (response) {
        callback(response);
      });
  };

  var searchAlbums = function (query) {
    var request = $.ajax({
        url: 'https://api.spotify.com/v1/search',
        data: {
            q: query,
            type: 'album,artist'
        },
    });
    request.done(function (response) {
        artistObject = response.artists.items[0];
        $('.form').hide();
        $('#search-again').fadeIn(500);
        $('#artist-bio').append(`<img class="artist_pic" src="${artistObject.images[0].url}"> <h1 class="artist_name">${artistObject.name}</h1>`);
        response.albums.items.forEach(function(album_object) {
          $('#results').append(`
            <div data-album-id='${album_object.id}' class='album_cover cover' style="background-image: url(${album_object.images[0].url})">
            <div class="album_name_container hidden"><span class="album_name">${album_object.name}</span></div>
            </div>`)
        });
    });
  };

  $('.container').on('click touchstart', '.cover', function (e) {
    var player = $(this)
      var target = e.target;
      if (target !== null && target.classList.contains('cover')) {
          if (target.classList.contains(playingCssClass)) {
              audioObject.pause();
          } else {
              if (audioObject) {
                  audioObject.pause();
              }
              fetchTracks(target.getAttribute('data-album-id'), function (album_object) {

                  $('#sidebar').html('<div id="seekbar" max="1"></div>');
                  $('#sidebar').animate({right: "0px"},"fast")
                  var randomNumber = Math.floor(Math.random() * album_object.tracks.items.length)
                  trackFile = album_object.tracks.items[randomNumber]
                  audioObject = new Audio(trackFile.preview_url)
                  audioObject.play();
                  target.classList.add(playingCssClass);
                  audioObject.addEventListener('timeupdate', function () {
                    $("#seekbar").animate({left: "400px"}, 30000);
                  });
                  audioObject.addEventListener('ended', function () {
                      target.classList.remove(playingCssClass);
                  });
                  audioObject.addEventListener('pause', function () {
                      target.classList.remove(playingCssClass);
                      $('#sidebar').animate({right: "-390px"},"fast");
                  });
                  $('#sidebar').append(`
                    <h2 class="track_album">${album_object.name}</h2>
                    <h3 class="track_name">Track: ${trackFile.name}</h3>
                    <h4 class="track_popularity">Release Date: ${album_object.release_date}</h4>
                    <div id="popularity_circle"></div>
                    <form id="save_form" method="get" action="/users">
                     <input type="hidden" name="id" value="${album_object.id}">
                     <input type="hidden" name="name" value="${album_object.name}">
                     <input type="submit" id="search" value="Save">
                    </form>`);
                    var bar = new ProgressBar.SemiCircle('#popularity_circle', {
                      strokeWidth: 5,
                      color: '#FFEA82',
                      trailColor: '#eee',
                      trailWidth: .75,
                      easing: 'easeInOut',
                      duration: 1400,
                      svgStyle: null,
                      text: {
                        value: '',
                        alignToBottom: false
                      },
                      from: {color: '#FFEA82'},
                      to: {color: '#ED6A5A'},
                      // Set default step function for all animate calls
                      step: (state, bar) => {
                        bar.path.setAttribute('stroke', state.color);
                        var value = Math.round(bar.value() * 100);
                        if (value === 0) {
                          bar.setText('');
                        } else {
                          bar.setText('Popularity ' + value);
                        }
                      }
                    });
                    bar.animate((Number(album_object.popularity)/100))
              });
          }
      }
  });
  
  $('#search-form').on('submit', function(e) { 
      e.preventDefault();
      $('#artist-bio').html('');
      $('#results').html('');
      searchAlbums($('#query').val());
  });


  $('#sidebar').on("submit", "#save_form", function(event){
    event.preventDefault();
    data = $(this).serialize();
    var request = $.ajax({
        url: '/users',
        method: "GET",
        data: data
    });
  });

  $('.container').on("click", "#search-again", function(event){
    event.preventDefault();
      $('#query').val('');
      $('.form').show();
      $('#search-again').fadeOut(500);
  });

});


