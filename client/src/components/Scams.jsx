import React from 'react';
const { useState, useEffect } = require("react");
import { Link } from "react-router-dom";

const [scams, setScams] = useState([]);

const Scam = (props) => {
    <>
        <div>
            <h1>{props.scam.title}</h1>
            <p>{props.scam.body}</p>
            <p>-{props.scam.author}</p>
            <p>Votes:{props.scam.votes}</p>
        </div>
    </>
}

useEffect(() => {
    async function getScams() {
        const response = await fetch(`http://localhost:3000/scam`)

        if(!response.ok) {
            const message = `An error has occured: ${response.statusText}`;
            window.alert(message);
            return;
        }

        const scams = await response.json();
        // console.log(Scams);
        setScams(scams);
    }

    getScams();
    return;
}, [scams.length]);

ScamList = () => {
    return scams.map((scam) => {
        return (
            <Scam scam = {scam} key={scam._id} />
        );
    });

}

return (
    <div>
        <h3>Scam List</h3>
        {ScamList()}
    </div>
);

export default ScamList;