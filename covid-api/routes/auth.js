const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken")

const Router = require("express").Router();

Router.post("/login", async (req, res) => {
  try {
    const user = await User.findOne({ username: req.body.username })
    const isPasswordCorrect = await bcryptjs.compare(req.body.password, user.password);

    const token = jwt.sign({ id: user._id }, process.env.JWT_TOKEN)
    
    res.status(201).send({
      isLoginSuccess: isPasswordCorrect,
      token
    });

  } catch (err) {
    res.status(500).send( {
      error: err.message,
      isLoginSuccess: false
    });
  }
});

Router.post("/signup", async (req, res) => {

  const salt = await bcryptjs.genSalt(10);
  const encryptedPass = await bcryptjs.hash(req.body.password, salt);

  const user = new User({
    username: req.body.username,
    password: encryptedPass
  });

  try {
    await user.save();
    const token = jwt.sign({ id: user._id }, process.env.JWT_TOKEN)
    res.status(201).send({
      isLoginSuccess: true,
      token
    });
  } catch (err) {
    res.status(500).send( {
      error: err.message,
      isLoginSuccess: false
    });
  }
});

module.exports = Router;
