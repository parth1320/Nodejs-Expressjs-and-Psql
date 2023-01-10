const bcrypt = require("bcrypt"); //hashing password
const express = require("express");
const pool = require("../db");
const router = new express.Router();

//create a user
router.post("/user", async (req, res) => {
  try {
    const { email, name, lastname, birthday } = req.body;
    const password = await bcrypt.hash(req.body.password, 10);
    console.log(password);
    const newUser = await pool.query(
      "INSERT INTO users (email, name, lastname, birthday, password) VALUES($1, $2, $3, $4, $5) RETURNING *",
      [email, name, lastname, birthday, password],
    );
    res.json(newUser.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
});

module.exports = router;
