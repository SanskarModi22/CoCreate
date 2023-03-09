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
        document = await document.save();
        // console.log(res.json({ document }));
        // console.log(req.);
        res.json(document);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

documentRouter.get("/doc/me", auth, async(req, res) => {
    try {
        console.log(req.user);
        let documnents = await Document.find({ uid: req.user });
        res.status(200).json(documnents);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

documentRouter.post("/doc/title", auth, async(req, res) => {
    try {
        const { id, title } = req.body;
        let document = await Document.findByIdAndUpdate(id, { title });
        res.json(document);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

documentRouter.get("/doc/:id", auth, async(req, res) => {
    try {
        const documnents = await Document.findById(req.params.id);
        res.status(200).json(documnents);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
module.exports = documentRouter;