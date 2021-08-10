require("dotenv").config()

const express = require("express")
const app = express()
const mongoose = require("mongoose")
const bodyParser = require("body-parser")

mongoose.connect(process.env.DB_URL, {
  useCreateIndex: true,
  useNewUrlParser: true,
  useUnifiedTopology: true
});

const authRoute = require("./routes/auth");


app.use(express.json());
app.use(authRoute);

app.listen(3000, () => {
  console.log("Listening on port 3000...");
});