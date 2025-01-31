import express from "express";
import { createAppointment, getAppointments, confirmAppointment, deleteAppointment } from "../controllers/appointment.controller";

const appointmentRouter = express.Router();

appointmentRouter.get("/", getAppointments);
appointmentRouter.post("/confirm", confirmAppointment);
appointmentRouter.post("/create", createAppointment);
appointmentRouter.delete("/delete/:id", deleteAppointment);

export default appointmentRouter;