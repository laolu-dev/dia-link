import mongoose from "mongoose";

const appointmentSchema = new mongoose.Schema({
    patientName: { type: String, required: true }, // Required field
    age: { type: String, required: true },        // Required field
    gender: { type: String, required: true },     // Required field
    dob: { type: Date, required: true },          // Required field
    hospitalName: { type: String, required: true }, // Required field
    testName: { type: String, required: true },     // Required field
    nextOfKin: { type: String, default: "None" }, // Optional field
    allergies: { type: String, default: "None" }, // Optional field
    history: { type: String, default: "None" }, // Optional field
    isConfirmed: { type: Boolean, default: false },
    appointmentDate: { type: Date }
});

const Appointment = mongoose.model("Appointment", appointmentSchema);

export default Appointment;