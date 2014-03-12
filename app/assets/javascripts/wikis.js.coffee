# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
opts = 
  container: 'epiceditor',
  textarea: 'my-text-area',
  basePath: '/assets/epiceditor',
  clientSideStorage: true,
  localStorageName: 'epiceditor',
  useNativeFullscreen: true,
  parser: marked,
  button: 
    preview: true,
    fullscreen: true,
    bar: "auto";
  focusOnLoad: false,
  shortcut: 
    modifier: 18,
    fullscreen: 70,
    preview: 80;
  string: 
    togglePreview: 'Toggle Preview Mode',
    toggleEdit: 'Toggle Edit Mode',
    toggleFullscreen: 'Enter Fullscreen';
  autogrow: false;

editor = new EpicEditor opts 

editor.load()

body = $document.getElementById('my-edit-area')

$document.onclick.submit(body)

