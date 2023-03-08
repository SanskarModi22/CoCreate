const express = require("express");
const Document = require("../models/document");
const documentRouter = express.Router();
const auth = require("../middleware/auth");

documentRouter.post("/doc/create", auth, async(req, res) => {
    try {
        const { createdAt } = req.body;
        let document = new Document({
            uid: req.user,
            title: "Untitled Document",
            createdAt: createdAt,
        });
        console.log(req.body);
        document = await document.save;
        // console.log(req.);
        res.json({ document });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = documentRouter;