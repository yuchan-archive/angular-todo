var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var router = express.Router();
var mongoose = require('mongoose');
var Todo = require('./models/todo');

app.use(bodyParser.urlencoded({
  extended: false
}));
app.use(bodyParser.json());

var port = process.env.PORT || 5000;
var host = process.env.MONGOLAB_URI ||
  process.env.MONGOHQ_URL || "mongodb://" + process.env.DB_PORT_27017_TCP_ADDR + "/todoapp" || "mongodb://localhost/todoapp";

mongoose.connect(host);

router.get('/', function(req, res) {
  res.json({
    message: 'this is my first api.'
  });
});

router.route('/todo')
  .post(function(req, res) {
    var todo = new Todo();
    todo.title = req.body.title;
    todo.done = req.body.done;
    todo.save(function(err) {
      if (err) {
        res.json({
          message: 'something is wrong...'
        });
      }

      res.json({
        message: 'todo created'
      });
    });
  })
  .get(function(req, res) {
    Todo.find(function(err, todos) {
      if (err)
        res.send(err);
      res.json(todos);
    });
  });

router.route('/todo/:id')
  .put(function(req, res) {
    Todo.findById(req.params.id, function(err, todo) {
      if (err) {
        res.send(err);
      }

      if (!todo) {
        res.json({
          message: 'todo cannot be found.'
        });
        return;
      }

      todo.done = req.body.done;
      todo.save(function(err) {
        if (err) {
          res.send(err);
        }
        res.json({
          message: 'todo is updated'
        });
      });
    });
  })
  .delete(function(req, res) {
    Todo.findById(req.params.id, function(err, todo) {
      if (err) {
        res.send(err);
      }

      if (!todo) {
        res.json({
          message: 'todo cannot be found.'
        });
        return;
      }

      todo.remove(function(err) {
        if (err) {
          res.send(err);
        }
        res.json({
          message: 'todo is deleted'
        });
      });
    });
  })
  .get(function(req, res) {
    Todo.findById(req.params.id, function(err, todos) {
      if (err)
        res.send(err);
      res.json(todos);
    });
  });

app.use('/', express.static('public'));
app.use('/api', router);
app.listen(port);
console.log('Server started... on port=' + port);
