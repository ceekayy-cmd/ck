import React, { useState } from 'react';

function App() {
  const [playerName, setPlayerName] = useState('');
  const [totalPlayers, setTotalPlayers] = useState([]);
  const [randomPlayer, setRandomPlayer] = useState('');

  // Function to generate a random 6-digit number
  const generateRandomNumber = () => {
    return Math.floor(100000 + Math.random() * 900000);
  };

  // Function to handle adding a player
  const addPlayer = () => {
    if (playerName.trim() !== '') {
      const randomNum = generateRandomNumber();
      const playerWithNum = `${playerName} - ${randomNum}`;
      setTotalPlayers([...totalPlayers, playerWithNum]);
      setPlayerName('');
    }
  };

  // Function to handle selecting a random player
  const selectRandomPlayer = () => {
    if (totalPlayers.length > 0) {
      const randomIndex = Math.floor(Math.random() * totalPlayers.length);
      setRandomPlayer(totalPlayers[randomIndex]);
    } else {
      setRandomPlayer('No players registered yet');
    }
  };

  return (
    <div className='container'>
    <div>
      <h1>Raffle Winner For ₱100,000,000</h1>
      <label>TRY YOUR LUCK NOW</label><br/>
      <label>Enter your name:</label><br/><br/>
      <input
        type="text"
        value={playerName}
        onChange={(e) => setPlayerName(e.target.value)}
        placeholder="Enter player name"
      />
      <button onClick={addPlayer}>Add Player</button>
      <br />
      <h2>Total Players:</h2>
      <ul>
        {totalPlayers.map((player, index) => (
          <li key={index}>{player}</li>
        ))}
      </ul>
      <button onClick={selectRandomPlayer}>Select Random Player</button>
      <h2>Winner: {randomPlayer}</h2>
    </div>
    <style jsx>{`
      .container{
        margin-left: auto;
        margin-right: auto;
        width: fit-content;
        margin-top: 150pt;
      }

      h1{
        font-family: Tahoma;
        font-weight: bold;
      }

      label{
        font-weight: bold;
      }
    `}</style>
    </div>
  );
}

export default App;
