import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: [true, "Please provide a name"],
    },
    lastName: {
        type: String,
        required: [true, "Please provide a name"],
    },
    email: {
        type: String,
        required: [true, "Please provide an email"],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "Please provide a password"],
    },
    gender: { type: String },
    phoneNumber: { type: String },
    appointments: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Appointment"
    }]
});

const User = mongoose.model("User", userSchema);

export default User;