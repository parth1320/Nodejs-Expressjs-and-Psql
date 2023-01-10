const express = require("express");
const userRouter = require("./routes/user");
const itemRouter = require("./routes/item");

const app = express();

app.use(express.json());
app.use(userRouter);
app.use(itemRouter);

//Server is running on 3033 as per task
app.listen(3033, () => {
  console.log(`Server listing on the port 3033`);
});
