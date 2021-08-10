const CovidItem = require("../models/CovidItem");
const { verify } = require("./verify_token");

const Router = require("express").Router();

Router.post("/itemRequest", verify, async (req, res) => {
  try {
    req.body.userId = req.user.id;
    const covidItem = new CovidItem(req.body);
    await covidItem.save();

    res.status(201).send({
      isSuccess: true,
      item: covidItem
    })
  } catch (err) {
    res.status(500).send({
      isSuccess: false,
      message: "Couldn't complete this request, try again"
    });
  }
});

Router.get("/items", verify, async (req, res) => {
  try {

    const userId = req.user.id;
    const items = await CovidItem.find({ userId });
    res.send(items);

  } catch {
    res.status(500).send({
      isSuccess: false,
      message: "Something went wrong"
    });
  }
})

Router.get("/allItems", async (req, res) => {
  try {
    
    const items = await CovidItem.find({});
    res.send(items);

  } catch {
    res.status(500).send({
      isSuccess: false,
      message: "Something went wrong"
    });
  }
})

Router.delete("/deleteItem/:id", verify, async (req, res) => {
  try {
    const covidItem = await CovidItem.findById(req.params.id);
    if (covidItem.userId == req.user.id) {
      await covidItem.delete();
      res.send({isSuccess: true});
    }
  } catch (err) {
    res.status(500).send({
      isSuccess: false,
      message: "Something went wrong"
    });
  }
})

module.exports = Router;