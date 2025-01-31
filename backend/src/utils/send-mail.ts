import mailer from 'nodemailer';

import format from "./appointment-date-html";

export async function sendAppointmentDate(details: {
    patientName: string,
    test: string,
    email: string,
    date: string,
    time: string,
    hospitalName: string,
    hospitalAddress: string,

}): Promise<boolean> {
    const transporter = mailer.createTransport({
        service: 'Gmail', // or another service like Outlook, Yahoo, etc.
        auth: {
            user: 'your-email@gmail.com', // Replace with your email
            pass: 'your-email-password', // Replace with your email password or app password
        },
    });

    const appointment = {
        from: `Dialink Admin`,
        to: details.email,
        subject: 'Appointment Reminder',
        html: format
            .replace('{{patientName}}', details.patientName)
            .replace('{{radiologistName}}', "Philadelphia")
            .replace('{{procedureType}}', details.test)
            .replace('{{appointmentDate}}', details.date)
            .replace('{{appointmentTime}}', details.time)
            .replace('{{clinicName}}', details.hospitalName)
            .replace('{{clinicAddress}}', details.hospitalAddress)
            .replace('{{contactInformation}}', "Laoludev")
            .replace('{{organizationName}}', "Dialink")
            .replace('{{contactEmail}}', "dephy@gmail.com"),
    };

    try {
        const info = await transporter.sendMail(appointment);
        console.log('Email sent:', info.response);
        return true;
    } catch (error) {
        console.error('Error sending email:', error);
        return false;
    }
}

async function sendOTPCode(email: string, otp: number): Promise<void> {
    const transporter = mailer.createTransport({
        service: 'Gmail',
        auth: {
            user: 'your-email@gmail.com',
            pass: 'your-email-password',
        },
    });


    const mailOptions = {
        from: '"Dialink Admin" <dialink@gmail.com>',
        to: email,
        subject: "OTP verification",
        html: `
            <!DOCTYPE html>
            <html>
            <body>
                <div style="font-family: Arial, sans-serif; text-align: center; padding: 20px;">
                    <h2 style="color: #4CAF50;">Your OTP Code</h2>
                    <p>Use the OTP below to verify your email address:</p>
                    <h1 style="color: #4CAF50;">${otp}</h1>
                    <p>This OTP is valid for 10 minutes.</p>
                    <p>If you didn't request this, please ignore this email.</p>
                </div>
            </body>
            </html>
        `,
    };

    try {
        const info = await transporter.sendMail(mailOptions);
        console.log('Email sent:', info.response);
    } catch (error) {
        console.error('Error sending email:', error);
    }
}


