const emailFormat: String = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Reminder</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; background-color: #f9f9f9; padding: 20px;">
    <div style="max-width: 600px; margin: 0 auto; background: #ffffff; border: 1px solid #ddd; border-radius: 8px; padding: 20px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
        <h2 style="color: #2c3e50; margin-bottom: 10px;">Appointment Reminder</h2>
        <p>Dear <strong>{{patientName}}</strong>,</p>
        <p>This is a friendly reminder about your upcoming appointment with <strong>{{radiologistName}}</strong> for <strong>{{procedureType}}</strong>.</p>
        
        <div style="margin: 20px 0; padding: 10px; background: #f4f4f4; border: 1px solid #ddd; border-radius: 5px;">
            <p><strong>Appointment Details:</strong></p>
            <p>Date: <strong>{{appointmentDate}}</strong></p>
            <p>Time: <strong>{{appointmentTime}}</strong></p>
            <p>Location: <strong>{{clinicName}}, {{clinicAddress}}</strong></p>
        </div>
        
        <p>Please confirm if the appointment time works for you. If you need to make any changes or reschedule, kindly reply to this email or contact us at <strong>{{contactInformation}}</strong> as soon as possible.</p>
        
        <p>We look forward to seeing you and are happy to assist with any questions you may have during your visit.</p>
        
        <p>Thank you,</p>
        <p><strong>{{organizationName}}</strong></p>
        <p><strong>{{contactEmail}}</strong></p>
    </div>
</body>
</html>
`;

export default emailFormat;