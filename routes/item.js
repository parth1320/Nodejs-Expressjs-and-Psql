const express = require("express");
const pool = require("../db");

const router = express.Router();

//task b
router.get("/purchase", async (req, res) => {
  try {
    const purchase =
      await pool.query(`SELECT purchase.p_id, purchase.date, purchase.u_id, items.name, purchase_item.quantity, purchase_item.price, purchase_item.total_purchase_item_price
FROM purchase
INNER JOIN purchase_item ON purchase.u_id = purchase_item.u_id
INNER JOIN items ON items.i_id = purchase_item.i_id;
`);
    if (!purchase) {
      res.status(400).send("Not Found....");
    }
    res.send(purchase.rows);
  } catch (err) {
    console.error(err);
  }
});

//creating item
router.post("/item", async (req, res) => {
  try {
    const { name, description, price } = req.body;
    const newItem = await pool.query(
      "INSERT INTO items (name, description, price) VALUES($1, $2, $3) RETURNING *",
      [name, description, price],
    );
    res.json(newItem.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
});

//creating purchase item
router.post("/purchaseitem", async (req, res) => {
  try {
    const { u_id, i_id, quantity, price } = req.body;
    const total_purchase_item_price = (await quantity) * price;
    const newPurchaseItem = await pool.query(
      "INSERT INTO purchase_item(u_id, i_id, quantity, price, total_purchase_item_price) VALUES($1, $2, $3, $4, $5) RETURNING *",
      [u_id, i_id, quantity, price, total_purchase_item_price],
    );
    res.json(newPurchaseItem.rows[0]);
  } catch (err) {
    console.error(err);
  }
});

module.exports = router;
