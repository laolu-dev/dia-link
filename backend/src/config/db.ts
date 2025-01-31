import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();

const _connectionString = process.env.MONGO_URI!;

export const database = async () => {
    try {
        // Use await with mongoose.connect since it's a promise
        await mongoose.connect(_connectionString);
        console.log("Database connected successfully!");
    } catch (error) {
        console.error("Error connecting to the database:", error);
        process.exit(1); // Exit the process with failure
    }
};


