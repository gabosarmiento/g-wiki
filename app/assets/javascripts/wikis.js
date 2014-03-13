
$(document).ready(function(){
    var opts = {
      container: 'epiceditor',
      textarea: 'wiki_body',
      basePath: '../../../../assets/',
      clientSideStorage: true,
      localStorageName: 'epiceditor',
      useNativeFullscreen: true,
      parser: marked,
      file: {
        name: 'epiceditor',
        defaultContent: '',
        autoSave: 100
      },
      theme: {
        base: 'themes/base/epiceditor.css',
        preview: 'themes/preview/github.css',
        editor: 'themes/editor/epic-dark.css'
      },
      button: {
        preview: true,
        fullscreen: false,
        bar: "auto"
      },
      focusOnLoad: false,
      shortcut: {
        modifier: 18,
        fullscreen: 70,
        preview: 80
      },
      string: {
        togglePreview: 'Toggle Preview Mode',
        toggleEdit: 'Toggle Edit Mode',
        toggleFullscreen: 'Enter Fullscreen'
      },
      autogrow: false
    }
    
    var editor = new EpicEditor(opts).load();

    $("#wiki_public_false").click(function() {
        $(".js-charges").removeClass('hide').slideDown();
      });

    $("#wiki_public_true").click(function() {
        $(".js-charges").hide().removeClass('hide').slideUp();
      });
  });

