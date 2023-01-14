export const returnTimesInBetween = (start: string, end: string): string[] => {
    const timesInBetween = [];
    const startH = parseInt(start.split(":")[0]);
    const startM = parseInt(start.split(":")[1]);
    const endH = parseInt(end.split(":")[0]);
    const endM = parseInt(end.split(":")[1]);

    const startTime = new Date();
    startTime.setHours(startH, startM, 0); //8 AM
    const endTime = new Date();
    endTime.setHours(endH, endM, 0); //5 PM

    while (startTime < endTime) {
        timesInBetween.push(startTime.toLocaleString('en-US', { hour: '2-digit', minute: '2-digit', hour12: false }));
        startTime.setMinutes(startTime.getMinutes() + 30);
    }

    return timesInBetween;
}