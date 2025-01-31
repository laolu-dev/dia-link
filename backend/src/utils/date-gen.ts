export function getRandomDate(): Date {
    const currentDate = new Date();
    const twoWeeksInMilliseconds = 14 * 24 * 60 * 60 * 1000;

    // Generate a random offset in the range of ±2 weeks
    const randomOffset = Math.floor(Math.random() * (2 * twoWeeksInMilliseconds + 1)) - twoWeeksInMilliseconds;

    // Create the random date by adding the offset to the current date
    const randomDate = new Date(currentDate.getTime() + randomOffset);

    return randomDate;
}
