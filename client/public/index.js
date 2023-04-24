alert("index.js");
var x = document.getElementById("demo");

function getLocation() {
    navigator.geolocation.getCurrentPosition(showPosition);
}
function showPosition(position) {
    let lat=position.coords.latitude ;
    let lng=position.coords.longitude;
    document.querySelector(".latitudeUser").setAttribute("value", lat); 
    document.querySelector(".longitudeUser").setAttribute("value", lng); 
    console.log(lat);
    console.log(lng);
}
let button=document.querySelector(".allow");
button.addEventListener("click",function()
{
    getLocation();
    alert("clicked");
})


