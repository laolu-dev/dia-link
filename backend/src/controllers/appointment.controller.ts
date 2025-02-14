import { Response, Request, NextFunction } from "express";

import { getRandomDate, formatDate } from "../utils/date-gen";
import { sendAppointmentDate } from "../utils/send-mail";

import userModel from "../models/user.model";
import appointmentModel from "../models/appointment.model";


export const createAppointment = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const {
            userId,
            name,
            age,
            gender,
            dob,
            hospitalName,
            nameOfTest,
            nextOfKinName,
            allergies,
            medicalHistory,
        } = req.body;

        if (!userId) {
            res.status(400).json({
                status: "error",
                message: "Provide a user ID."
            });
            return;
        }
        if (!name || !age || !hospitalName || !nameOfTest || !dob) {
            res.status(400).json({
                status: "error",
                message: "Insuffient patient information."
            });
            return;
        }
        
        // Parse and validate date of birth
        const dateOfBirth = new Date(dob);
        if (isNaN(dateOfBirth.getTime())) {
            res.status(400).json({
                status: "error",
                message: "Invalid date of birth format.",
            });
            return;
        }

        const selectedDate = getRandomDate();

        const { formattedDate, formattedTime } = formatDate(selectedDate);

        const appointment = await appointmentModel.create({
            patientName: name,
            age: age,
            gender: gender,
            dob: dateOfBirth,
            hospitalName: hospitalName,
            testName: nameOfTest,
            nextOfKin: nextOfKinName,
            allergies: allergies,
            history: medicalHistory,
            appointmentDate: selectedDate
        });

        const user = await userModel.findByIdAndUpdate(userId, { $push: { appointments: appointment._id } });

        if (!user) {
            res.status(404).json({
                status: "error",
                message: "User not found.",
            });
            return;
        }

        await sendAppointmentDate({
            patientName: name,
            test: nameOfTest,
            email: user.email,
            date: formattedDate,
            time: formattedTime,
            hospitalName: hospitalName,
            hospitalAddress: "Some address",
        });

        res.status(201).json({
            status: "success",
            message: "Successfully created appointment",
        });
        return;

    } catch (error: any) {
        console.log(error);
    }
}

export const getAppointments = async (req: Request, res: Response): Promise<void> => {
    const { userId } = req.body;

    if (!userId) {
        res.status(400).json({
            status: "error",
            message: "Provide a user ID."
        });
        return;
    }

    // Find user and populate appointments
    const user = await userModel.findById(userId).populate("appointments");

    if (user) {
        res.status(200).json({
            status: "success",
            message: "Successfully fetched appointments.",
            data: user.appointments
        });
        return;
    } else {
        res.status(404).send({
            status: "error",
            message: "User does not exist."
        });
        return;
    }

}

export const confirmAppointment = async (req: Request, res: Response): Promise<void> => {
    try {
        const { appointmentId, status } = req.body;

        if (!appointmentId) {
            res.status(400).json({
                status: "error",
                message: "Provide an appointment id."
            });
            return;
        }

        const appointment = await appointmentModel.findByIdAndUpdate(
            appointmentId,
            { isConfirmed: status },
            { new: true }
        );
        
        if (appointment) {
            res.status(200).json({
                status: "success",
                message: "Successfully confirmed appointment",
            });
            return;
        } else {
            res.status(404).send({
                status: "error",
                message: "No confirmation was made as the appointment does not exist."
            });
            return;
        }
    } catch (error) {
        console.error("Error confirming appointment:", error);
    }
}


export const deleteAppointment = async (req: Request, res: Response): Promise<void> => {
    try {
        const { id } = req.params;

        if (!id) {
            res.status(400).json({
                status: "error",
                message: "Provide an appointment id."
            });
            return;
        }

        // Find and delete the appointment
        const appointment = await appointmentModel.findByIdAndDelete(id);

        if (!appointment) {
            res.status(404).json({
                status: "error",
                message: "No appointment was deleted. It does not exist.",
            });
            return;
        }

        res.status(200).json({
            status: "success",
            message: "Successfully deleted appointment.",
        });
        return;

    } catch (error) {
        console.error("Error deleting appointment:", error);
    }
}

