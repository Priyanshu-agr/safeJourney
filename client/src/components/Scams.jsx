import React from 'react';
const { useState, useEffect } = require("react");
import { Link } from "react-router-dom";

const [scams, setScams] = useState([]);

const Scams = (props) => {
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
    }

    const scams = await response.json();
    
})

export default Scams;