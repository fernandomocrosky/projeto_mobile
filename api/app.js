const express = require("express");
const app = express();
const multer = require("multer");

const mongoose = require("mongoose");
mongoose
    .connect("mongodb+srv://fernandobm:<P>@cluster0.amktk8o.mongodb.net/fictions?retryWrites=true&w=majority")
    .then(() => app.emit("pronto"))
    .catch((e) => console.log(e))
;

const date = Date.now()
let fileName = "";

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, "public/images/");
    },
    filename: function(req, file, cb) {
        fileName = file.originalname + date + ".jpeg";
        cb(null, fileName);
    }
})

const upload = multer({storage});

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static("public"));

const db = require("./model/FictionModel");

const newFiction = {
    title: "Fiction 1",
    description: "Ola sou uma fiction",
    image: "http://10.0.2.2/images/images.jpg",
    grade: 0.0,
    author: "Author teste 1",
    chapters: [{
        id: 1,
        title: "Chapter 1",
        text: "Text test"
    },{
        id: 2,
        title: "Chapter 2",
        text: "Text test",
    }],
}

// db.create(newFiction);



app.get("/fictions",  async (req, res) => {
    const fictions = await db.find();
    res.send(fictions);
});

app.post("/fictions", upload.single("file"), async (req, res) => {
    const newFiction = {
        title: req.body.title,
        description: req.body.description,
        image: `http://10.0.2.2:3000/images/${fileName}`,
        author: "Author 0",
        grade: 0.0,
        chapters: [],
    };
    let user = await db.create(newFiction);
    return user;
})

app.delete("/fictions/:id", async (req, res) => {
    let user = await db.deleteOne({_id: req.params.id});
    return user;
})

app.put("/fictions/:id", async (req, res) => {
    let user = await db.findOneAndUpdate(req.params.id, req.body, {new: true});
    return user;
});

app.on("pronto", () => {
   app.listen(3000, () => {
        console.log("Acessar localhost:3000");
        console.log("Servidor executado na porta 3000");
   });
});
