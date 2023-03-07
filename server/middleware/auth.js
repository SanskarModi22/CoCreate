// Import the jsonwebtoken library.
const jwt = require("jsonwebtoken");
const { PASSWORD_KEY } = process.env;

// Define an asynchronous middleware function called auth that takes in a request, response, and next function.
const auth = async(req, res, next) => {
    try {
        // Get the authorization token from the request header.
        const token = req.header("X-Auth-Token");
        if (!token) {
            return res.status(401).json({ msg: "No auth token, access denied" });
        }

        // Verify the token with the password key and get the decoded payload.
        const verfified = jwt.verify(token, PASSWORD_KEY);

        // If the token verification fails, return a 401 Unauthorized response with an error message.
        if (!verfified) {
            return res
                .status(401)
                .json({ msg: "Token Verification failed, authorization denied" });
        }

        // Set the user and token properties in the request object to the decoded payload and token, respectively.
        req.user = verfified.id;
        req.token = token;

        // Call the next middleware function.
        next();
    } catch (e) {
        // If an error occurs, return a 500 Internal Server Error response with the error message.
        res.status(500).json({ error: e.message });
    }
};
// Export the auth middleware function.
module.exports = auth;