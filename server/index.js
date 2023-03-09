const express = require("express");
require("dotenv").config();
const mongoose = require("mongoose");
const cors = require("cors");
const http = require("http");
const Document = require('./models/document');
const authRouter = require("./routes/auth");
const documentRouter = require("./routes/document");
const PORT = process.env.PORT | 8000;
const app = express();
const server = http.createServer(app);
var io = require("socket.io")(server);
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(documentRouter);
mongoose
    .connect(process.env.DATABASE, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
    .then(() => console.log("DB connected"))
    .catch((e) => console.log(e));

io.on("connection", (socket) => {
    socket.on("join", (documentID) => {
        socket.join(documentID);
        console.log(documentID);
        console.log("joined");
        socket.on("typing", (data) => {
            socket.broadcast.to(data.room).emit("changes", data);
            console.log("joined");
        });
    });
    socket.on("save", (data) => {
        // console.log(data);
        saveData(data);
    });
});
const saveData = async(data) => {
    // console.log(data);
    let document = await Document.findById(data.room);
    document.content = data.Delta;
    console.log(document);
    document = await document.save();
};
server.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});