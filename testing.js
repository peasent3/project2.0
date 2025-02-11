const express = require("express");
const cors = require("cors");
 
const app = express();
app.use(cors());
app.use(express.static("public")); // Serve static HTML
 
let lightStatus = "off"; // Default light status
 
app.get("/on", (req, res) => {
    lightStatus = "on";
    console.log("Light turned ON");
    res.send("Light is ON");
});
 
app.get("/off", (req, res) => {
    lightStatus = "off";
    console.log("Light turned OFF");
    res.send("Light is OFF");
});
 
app.get("/status", (req, res) => {
    res.send(lightStatus);
});
 
// Start server
const PORT = 3000;
app.listen(PORT, () => {
console.log(`Server running on http://localhost:${PORT}`);
});