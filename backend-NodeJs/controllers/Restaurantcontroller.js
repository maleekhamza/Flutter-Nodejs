const restaurantServices = require("../services/Restaurant.services");
const upload = require("../middleware/upload.js");

// Create and Save a new Restaurant
exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const url = req.protocol + "://" + req.get("host");

      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        restaurantName: req.body.restaurantName,
        restaurantDescription: req.body.restaurantDescription,
        restaurantPrice: req.body.restaurantPrice,
        restaurantImage: path != "" ? url + "/" + path : "",
      };

      restaurantServices.createRestaurant(model, (error, results) => {
        if (error) {
          return next(error);
        }
        return res.status(200).send({
          message: "Success",
          data: results,
        });
      });
    }
  });
};

// Retrieve all Restaurants from the database.
exports.findAll = (req, res, next) => {
  var model = {
    restaurantName: req.query.restaurantName,
  };

  restaurantServices.getRestaurants(model, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};

// Find a single Restaurant with an id
exports.findOne = (req, res, next) => {
  var model = {
    restaurantId: req.params.id,
  };

  restaurantServices.getRestaurantById(model, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};

// Update a Restaurant by the id in the request
exports.update = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const url = req.protocol + "://" + req.get("host");

      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        restaurantId: req.params.id,
        restaurantName: req.body.restaurantName,
        restaurantDescription: req.body.restaurantDescription,
        restaurantPrice: req.body.restaurantPrice,
        restaurantImage: path != "" ? url + "/" + path : "",
      };

      console.log(model);

      restaurantServices.updateRestaurant(model, (error, results) => {
        if (error) {
          return next(error);
        }
        return res.status(200).send({
          message: "Success",
          data: results,
        });
      });
    }
  });
};

// Delete a Restaurant with the specified id in the request
exports.delete = (req, res, next) => {
  var model = {
    restaurantId: req.params.id,
  };

  restaurantServices.deleteRestaurant(model, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};