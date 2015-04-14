/*
  _   _               _      
 | | | |___ ___ _ __ (_)_ _  
 | |_| (_-</ -_) '  \| | ' \ 
  \___//__/\___|_|_|_|_|_||_|

 Concatenate, minify and cachebust the CSS and JS for the production ready version.

 NOTE: Concatenation groups, filenames, etc are defined in ./public/index.html.

*/

var gulp = require('gulp'),
    usemin = require('gulp-usemin'),
    uglify = require('gulp-uglify'),
    minifycss = require('gulp-minify-css'),
    rev = require('gulp-rev');

gulp.task('usemin', function() {
  gulp.src('public/*.html')
    .pipe(usemin({
      'js1': [uglify(), rev()],
      'js2': [uglify(), rev()],
      'js3': [uglify(), rev()],
      'css': [minifycss(), rev()]
    }))
    .pipe(gulp.dest('dist/'));
});