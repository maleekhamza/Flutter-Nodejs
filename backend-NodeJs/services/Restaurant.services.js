const { restaurant } = require("../models/Restaurant.model");

async function createRestaurant(params, callback) {
  if (!params.restaurantName) {
    return callback(
      {
        message: "Restaurant Name Required",
      },
      ""
    );
  }

  const restaurantModel = new restaurant(params);
  restaurantModel
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getRestaurants(params, callback) {
  const restaurantName = params.restaurantName;
  var condition = restaurantName
    ? { restaurantName: { $regex: new RegExp(restaurantName), $options: "i" } }
    : {};

  restaurant
    .find(condition)
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getRestaurantById(params, callback) {
  const restaurantId = params.restaurantId;

  restaurant
    .findById(restaurantId)
    .then((response) => {
      if (!response) callback("Not found Restaurant with id " + restaurantId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function updateRestaurant(params, callback) {
  const restaurantId = params.restaurantId;

  restaurant
    .findByIdAndUpdate(restaurantId, params, { useFindAndModify: false })
    .then((response) => {
      if (!response) callback(`Cannot update Restaurant with id=${restaurantId}. Maybe Restaurant was not found!`);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function deleteRestaurant(params, callback) {
  const restaurantId = params.restaurantId;

  restaurant
    .findByIdAndDelete(restaurantId)
    .then((response) => {
      if (!response) callback(`Cannot delete Restaurant with id=${restaurantId}. Maybe Restaurant was not found!`);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

module.exports = {
  createRestaurant,
  getRestaurants,
  getRestaurantById,
  updateRestaurant,
  deleteRestaurant
};