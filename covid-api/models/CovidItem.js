const mongoose = require("mongoose");

const itemSchema = new mongoose.Schema({
  item: {
    type: String,
    required: true
  },
  desc: {
    type: String, 
    requierd: true
  },
  contact: {
    type: String,
    required: true,
    maxLength: 10
  },
  city: {
    type: String, 
    required: true,
    maxLength: 50
  },
  userId: {
    type: String,
    required: true
  }
})

module.exports = mongoose.model("CovidItem", itemSchema);