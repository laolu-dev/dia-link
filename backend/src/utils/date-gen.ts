export function getRandomDate(): Date {
    const currentDate = new Date();
    const twoWeeksInMilliseconds = 14 * 24 * 60 * 60 * 1000;

    // Generate a random offset in the range of ±2 weeks
    const randomOffset = Math.floor(Math.random() * (2 * twoWeeksInMilliseconds + 1)) - twoWeeksInMilliseconds;

    // Create the random date by adding the offset to the current date
    const randomDate = new Date(currentDate.getTime() + randomOffset);

    return randomDate;
}

export function formatDate(date: Date): { formattedDate: string; formattedTime: string } {
    const day = date.getDate();
    const month = date.toLocaleString("en-US", { month: "long" }); // Full month name
    const year = date.getFullYear();

    // Get hours and convert to 12-hour format
    let hours = date.getHours();
    const minutes = date.getMinutes();
    const ampm = hours >= 12 ? "PM" : "AM";

    // Convert 24-hour to 12-hour format
    hours = hours % 12 || 12;

    // Format the day with an ordinal suffix (1st, 2nd, 3rd, etc.)
    const ordinalSuffix = (n: number): string => {
        if (n > 3 && n < 21) return "th"; // 4th, 5th, ... 20th
        switch (n % 10) {
            case 1: return "st";
            case 2: return "nd";
            case 3: return "rd";
            default: return "th";
        }
    };

    const formattedDate = `${day}${ordinalSuffix(day)} ${month} ${year}`;
    const formattedTime = `${hours}${minutes > 0 ? `:${minutes}` : ""} ${ampm}`; // Include minutes only if non-zero

    return { formattedDate, formattedTime };
}

