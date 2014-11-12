/*
   ___ _               
  / __| |___ __ _ _ _  
 | (__| / -_) _` | ' \ 
  \___|_\___\__,_|_||_|

 Get rid of everything Gulp generates. You can see the stripes ...

*/

var gulp  = require('gulp'),
    clean = require('gulp-clean');

gulp.task('clean', function() {
  return gulp.src(['dist/', 'public/css/', 'public/js/'], {read: false})
    .pipe(clean());
});