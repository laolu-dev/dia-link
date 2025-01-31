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
            user: process.env.EMAIL_USER, // Replace with your email
            pass: process.env.EMAIL_PASSWORD, // Replace with your email password or app password
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
            .replace('{{contactInformation}}', "+234 809 673 8815")
            .replace('{{organizationName}}', "Dialink Admin")
            .replace('{{contactEmail}}', "dialink-support@gmail.com"),
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
