function getDistance(latitude1, longitude1, latitude2, longitude2) {

    const R = 6378137; // Earth’s mean radius in meter
    const dLat = rad(latitude2 - latitude1);
    const dLong = rad(longitude2 - longitude1);
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(rad(latitude1)) * Math.cos(rad(latitude2)) *
        Math.sin(dLong / 2) * Math.sin(dLong / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const d = R * c;
    return d; // returns the distance in meter
};

function rad(x) {
    return x * Math.PI / 180;
};

module.exports = { getDistance };