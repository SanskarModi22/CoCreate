const express = require('express');
const mongoose = require('mongoose');
const PORT = process.env.PORT | 8000;
const app = express();
app.listen(PORT, "0.0.0.0", () => {
    console.log("Server is running on port 8000")
});