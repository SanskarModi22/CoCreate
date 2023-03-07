const express = require("express");
require("dotenv").config();
const mongoose = require("mongoose");
const PORT = process.env.PORT | 8000;
const app = express();
console.log(process.env.DATABASE);
mongoose
    .connect(process.env.DATABASE, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
    .then(() => console.log("DB connected"))
    .catch((e) => console.log(e));
app.listen(PORT, "0.0.0.0", () => {
    console.log("Server is running on port 8000");
});