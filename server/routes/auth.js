const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const auth = require("../middleware/auth");
const { PASSWORD_KEY } = process.env;

authRouter.post("/api/signup", async(req, res) => {
    try {
        // Extract name, email, and photoUrl from request body
        const { name, email, profilePic } = req.body;

        // Validate inputs
        if (!name || !email) {
            return res.status(400).json({ error: "Name and email are required" });
        }

        // Find user by email and update profile or create new user if not found
        const user = await User.findOneAndUpdate({ email }, { name, profilePic: profilePic }, { upsert: true, new: true });

        // Generate JWT token with user ID and password key
        const token = jwt.sign({ id: user._id }, PASSWORD_KEY);

        // Return user object and token in JSON response
        res.json({ user, token });
    } catch (e) {
        // Handle errors by returning 500 status and error message in JSON response
        res.status(500).json({ error: e.message });
    }
});

authRouter.get("/", auth, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({ user, token: req.token });
});

module.exports = authRouter;