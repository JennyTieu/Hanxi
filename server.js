const express = require('express');
const app = express();
const bcrypt = require('bcrypt');
app.use("/media", express.static("media"));

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

app.engine('.ejs', require('ejs').__express);
app.set('view engine', 'ejs');

const cookieParser = require('cookie-parser');
app.use(cookieParser());

const session = require('express-session');
app.use(session({
    secret: 'example',
    resave: false,
    saveUninitialized: true
}));

app.listen(3000, function () {
    console.log('listening on 3000');
});
//CSS files laden
app.use(express.static('stylesheets'));

//Startseite
app.get('/', function (req, res) {
    res.render('home');
});