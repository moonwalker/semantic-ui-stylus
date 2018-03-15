const path = require('path');
const less2stylusPlugin = require('@moonwalker/less-to-stylus').plugin;

module.exports.version = require('../package.json').version;
module.exports.path = __dirname;

module.exports = () => style => {
  style
    .include(__dirname)
    .use(less2stylusPlugin())
    .import(path.join(__dirname, 'updates.styl'))
};
