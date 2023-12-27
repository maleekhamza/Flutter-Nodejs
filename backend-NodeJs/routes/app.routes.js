const restaurantController = require("../controllers/Restaurantcontroller");
const express = require("express");
const router = express.Router();

// Create a new Restaurant
router.post("/restaurants", restaurantController.create);

// Retrieve all Restaurants
router.get("/restaurants", restaurantController.findAll);

// Retrieve a single Restaurant with id
router.get("/restaurants/:id", restaurantController.findOne);

// Update a Restaurant with id
router.put("/restaurants/:id", restaurantController.update);

// // Delete a Restaurant with id
router.delete("/restaurants/:id", restaurantController.delete);

module.exports = router;