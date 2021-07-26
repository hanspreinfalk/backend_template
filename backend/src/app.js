const express = require('express');
const app = express();

const morgan = require('morgan');
const cors = require('cors');

var corsOptions = {
    origin: '*',
  }

app.use(require('./routes/users'));

app.use(morgan('dev'));
app.use(cors());

app.use(function(req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Acces-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

module.exports = app;