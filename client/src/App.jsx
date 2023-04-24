import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import SearchBar from './components/SearchBar.jsx'

function App() {
  const [count, setCount] = useState(0);
  

  return (
    <>
      <div className='mainName'>
        <h1>
        SafeJourney.
        </h1>
      </div>
      <div className='search-area'>
      <SearchBar />
      </div>
      <div className='Scams'>
      <Scams />
      </div>
    </>
  )
}

export default App
