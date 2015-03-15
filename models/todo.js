var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var todoSchema = new Schema({
  title: String,
  done: Boolean
});

module.exports = mongoose.model('Todo', todoSchema);
