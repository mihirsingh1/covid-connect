const jwt = require('jsonwebtoken');

function auth (req, res, resume) {
  const token = req.header('auth-token');
  if (!token) return res.status(401).send("Access Denied!");
  try {
    const user = jwt.verify(token, process.env.JWT_TOKEN);
    req.user = user;
  } catch (err) {
    res.status(400).send("Invalid Token");
  }

  resume();
}

module.exports.verify = auth;