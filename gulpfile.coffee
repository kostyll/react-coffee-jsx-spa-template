# coffee -b -p -c gulpfile.coffee > gulpfile.js ;gulp clean ; gulp build ; tree dist/
path      = require('path')
gulp      = require('gulp')
gutil     = require('gulp-util')
minifyCSS = require('gulp-minify-css')
clean     = require('gulp-clean')
watch     = require('gulp-watch')
rev       = require('gulp-rev')
tiny_lr   = require('tiny-lr')
cjsx      = require('gulp-cjsx')

express   = require "express"

vendorPaths = [
    'es5-shim/es5-sham.js', 
    'es5-shim/es5-shim.js', 
    'bootstrap/dist/css/bootstrap.css',
    'jquery/jquery.js',
    'react/react.js',
    'react/react-with-addons.js',
    'react-bootstrap/react-bootstrap.js',
]

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
    .pipe gulp.dest 'dist/scripts/'

gulp.task 'dev', ['build'], ->
    server = make_server 9999,35999
    gulp.watch ['app/**/*'], (evt) -> gulp.run "build"
    gulp.watch ['app/*'], (evt) -> gulp.run "build"
    gulp.watch ['app/scripts/*'], (evt) -> gulp.run "build"

    gulp.watch ['dist/**/*'], (evt) -> 
        gutil.log gutil.colors.cyan(evt.path),'changed' 
        server.lr.changed
            body:
                files: [evt.path]

gulp.task 'build', ['vendor'], ->
    gulp.run "transform-cjsx"

    gulp.src ['app/index.html']
    .pipe gulp.dest 'dist/'

    gulp.src ['app/styles/**']
    .pipe gulp.dest 'dist/styles/'

    gulp.src ['app/static/**']
    .pipe gulp.dest 'dist/static/'

    gulp.src ['app/images/**']
    .pipe gulp.dest 'dist/images/'

gulp.task 'vendor', ->
    paths = vendorPaths.map (p) -> path.resolve("./bower_components",p)
    gulp.src paths
    .pipe gulp.dest "dist/assets/vendor"


make_server = (port,lrport) ->
    lr = tiny_lr()
    lr.listen lrport, -> gutil.log "Live reload on....",lrport
    app = express()
    app.use express.static path.resolve "dist/"
    app.listen port, -> gutil.log "Listening",port

    lr:lr
    app:app



