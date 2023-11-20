const mongoose = require("mongoose");

const fictionSchema = new mongoose.Schema({
    title: { type: String, required: [true, "title requred"] },
    description: { type: String, required: [true, "description required"] },
    image: { type: String, required: false },
    grade: { type: Number, required: false },
    author: { type: String, required: [true, "author required"] },
    chapters: { type: Array, required: false},
});

const FictionModel = mongoose.model("Fiction", fictionSchema);


module.exports = FictionModel;