var express = require('express');
var router = express.Router();
const validateURL = require('valid-url');
const Hashids = require('hashids');
const fs = require('fs');
var path = require('path');
const urlData = require('../public/data/urls.json');

router.get('/', (req, res, next) => {
  res.render('form', { title: 'URL shortener' });
});

router.get('/:id', function (req, res, next) {
  const { id } = req.params;
  const { host } = req.headers;
  const url = `http://${host}/${id}`;
  const originalUrl = urlData.shortenedURLS[url];
  if (validateURL.isUri(originalUrl)) {
    res.redirect(originalUrl);
  } else {
    res.status(404);
    res.render('404');
  }
});

router.post('/new', (req, res, next) => {
  const  {url}  = req.body.url == undefined ? req.query : req.body;
  if (!validateURL.isUri(url)) {
    return res.render('form', { title: 'URL shortener', error: 'Not a valid URL' });
  }

  if (urlData.urls[url] !== undefined) {
    return res.json({ oldUrl: url, newUrl: urlData.urls[url] });
  }

  const { host } = req.headers;
  const baseURL = `http://${host}`;

  const generateHash = (uniqueId) => {
    const hashids = new Hashids();
    return hashids.encode(uniqueId);
  };

  const hash = generateHash(Math.floor(Date.now() * Object.keys(urlData.urls).length));
  const shortenedUrl = `${baseURL}/${hash}`;
  urlData.urls[url] = shortenedUrl;
  urlData.shortenedURLS[shortenedUrl] = url;

  fs.writeFileSync(path.join(__dirname, '../public/data/urls.json'), JSON.stringify(urlData, null, 2));
  res.json({ oldUrl: url, newUrl: shortenedUrl });
});

module.exports = router;
