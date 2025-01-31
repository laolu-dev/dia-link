import jwt from 'jsonwebtoken';
import bcrypt from 'bcryptjs';
import { Response, Request, NextFunction } from "express";

import userModel from "../models/user.model";

export const createAccount = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const {
            firstName,
            lastName,
            gender,
            phoneNumber,
            email,
            password
        } = req.body;

        if (!firstName || !lastName) {
            res.status(400).json({
                status: "error",
                message: "We need your name 🙄"
            });
            return;
        }

        if (!email || !password) {
            res.status(400).json({
                status: "error",
                message: "How are we gonna register you if you don't provide this? 🙄 🙄"
            });
            return;
        }

        const userExists = await userModel.findOne({ email });

        if (userExists) {
            res.status(400).json({
                status: "error",
                message: "Email already exists"
            });
            return;
        }

        const hashPassword: String = await bcrypt.hash(password, 10);

        const user = await userModel.create({
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            phoneNumber: phoneNumber,
            email: email,
            password: hashPassword
        });

        if (user) {
            res.status(201).json({
                status: "success",
                message: "Successfully created account.",
                data: { id: user.id }
            });
            return;
        } else {
            res.status(400).json({
                status: "error",
                message: "We could not create your account. Please try again"
            });
            return;
        }

    } catch (error: any) {
        next(error);
    }
}

export const login = async (req: Request, res: Response, next: NextFunction): Promise<void> => {

    const { email, password } = req.body;

    if (!email || !password) {
        res.status(400).json({
            status: "error",
            message: "Hey, you sure you want to login? 😒"
        });
        return;
    }

    const user = await userModel.findOne({ email });

    if (user) {
        const passwordMatches: boolean = await bcrypt.compare(password, user.password);

        if (passwordMatches) {
            res.status(200).json({
                status: "success",
                message: "Successfully logged into account.",
                data: {
                    id: user._id,
                    name: user.lastName,
                    jwtToken: generateToken(user.id),
                }
            });
            return;
        }
    } else {
        res.status(400).send({
            status: "error",
            message: "We don't have your details."
        });
        return;
    }

}

const generateToken = (id: String) => {
    return jwt.sign(id, "myJwtSecret");
}