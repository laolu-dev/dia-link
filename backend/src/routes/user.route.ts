import express from "express";
import { createAccount, login } from "../controllers/user.controller";

const userRouter = express.Router();

userRouter.post("/", createAccount);
userRouter.post("/login", login);

export default userRouter;