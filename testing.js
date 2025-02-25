const express = require("express");
const cors = require("cors");
 
const app = express();
app.use(cors());
app.use(express.static("public")); // Serve static HTML
 
let lightStatus = "nothing"; // Default light status
 
app.get("/up", (req, res) => {
    lightStatus = "up";
    console.log("Going up");
    res.send("Up");
});
 
app.get("/down", (req, res) => {
    lightStatus = "down";
    console.log("Going Down");
    res.send("down");
});

app.get("/left", (req, res) => {
    lightStatus = "left";
    console.log("Going Left");
    res.send("down");
});

app.get("/right", (req, res) => {
    lightStatus = "right";
    console.log("Going Right");
    res.send("right");
});

app.get("/nothing", (req, res) => {
    lightStatus = "nothing";
    console.log("Not moving");
    res.send("Not moving");
});
 
app.get("/status", (req, res) => {
    res.send(lightStatus);
});
 
// Start server
const PORT = 3000;
app.listen(PORT, () => {
console.log(`Server running on http://localhost:${PORT}`);
});