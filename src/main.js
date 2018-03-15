module.exports.version = require('../package.json').version;
module.exports.path = __dirname;

module.exports = () => style => {
  style.include(__dirname)
};
