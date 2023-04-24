import React from 'react';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';

const SearchBar = () => {
    return (
        <>
            <div>
            <TextField id="outlined-basic" label="Outlined" variant="outlined" />
            <Button variant="contained">Search</Button>
            </div>
        </>
    )
}

export default SearchBar;