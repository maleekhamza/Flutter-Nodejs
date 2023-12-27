const mongoose = require("mongoose");

const restaurant = mongoose.model(
  "restaurants", 
  mongoose.Schema(
    {
      restaurantName: String, 
      restaurantDescription: String,
      restaurantPrice: Number,
      restaurantImage: String
    },
    { timestamps: true }
  )
);

module.exports = {
  restaurant, 
};