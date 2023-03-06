const express = require("express");
require("dotenv").config();
const mongoose = require("mongoose");
const PORT = process.env.PORT | 8000;
const app = express();
console.log(process.env.DATABASE);
mongoose
    .connect(process.env.DATABASE)
    .then(() => {
        console.log("DB Connected");
    })
    .catch((err) => {
        console.log(err);
    });
app.listen(PORT, "0.0.0.0", () => {
    console.log("Server is running on port 8000");
});