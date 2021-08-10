const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    maxLength: 15,
    unique: true
  },
  password: {
    type: String, 
    required: true
  }
})

module.exports = mongoose.model("User", userSchema);