path      = require('path')
gulp      = require('gulp')
gutil     = require('gulp-util')
minifyCSS = require('gulp-minify-css')
clean     = require('gulp-clean')
watch     = require('gulp-watch')
rev       = require('gulp-rev')
tiny_lr   = require('tiny-lr')
cjsx      = require('gulp-cjsx')

gulp.task 'clean', ->
    gulp.src 'dist', 
        read: false
    .pipe clean()

gulp.task 'echo', ->
    console.log "Hello!!!"

gulp.task 'transform-cjsx',->
    gulp.src './app/scripts/*.cjsx'
    .pipe cjsx(
            bare:true
        ).on "error",gutil.log 
    .pipe gulp.dest ('dist')
