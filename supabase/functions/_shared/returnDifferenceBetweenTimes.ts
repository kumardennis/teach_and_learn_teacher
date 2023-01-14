export const returnDifferenceBetweenTimes = (end: string, start: string) => {

    const startH = parseInt(start.split(":")[0]);
    const startM = parseInt(start.split(":")[1]);
    const endH = parseInt(end.split(":")[0]);
    const endM = parseInt(end.split(":")[1]);

    const startTime = new Date();
    startTime.setHours(startH, startM, 0); //8 AM
    const endTime = new Date();
    endTime.setHours(endH, endM, 0); //5 PM

    let diff = (endTime.getTime() - startTime.getTime()) / 1000;
    diff /= 60;

    return Math.abs(Math.round(diff));

}