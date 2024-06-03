import React, { useState } from 'react';

function App() {
  const [playerName, setPlayerName] = useState('');
  const [playersList, setPlayersList] = useState([]);
  const [randomPlayer, setRandomPlayer] = useState('');
  const [showPlayersList, setShowPlayersList] = useState(false);
  const [showTotalPlayers, setShowTotalPlayers] = useState(false);

  // Function to generate a random 6-digit number
  const generateRandomNumber = () => {
    return Math.floor(100000 + Math.random() * 900000);
  };

  // Function to handle adding a player
  const addPlayer = () => {
    if (playerName.trim() !== '') {
      const randomNum = generateRandomNumber();
      const playerWithNum = `${playerName} - ${randomNum}`;
      setPlayersList([...playersList, playerWithNum]);
      setPlayerName('');
    }
  };

  // Function to handle selecting a random player
  const selectWinner = () => {
    if (playersList.length > 0) {
      const randomIndex = Math.floor(Math.random() * playersList.length);
      setRandomPlayer(playersList[randomIndex]);
    } else {
      setRandomPlayer('No players registered yet');
    }
  };

  // Function to show the list of players
  const showPlayers = () => {
    setShowPlayersList(true);
    setShowTotalPlayers(false);
  };

  // Function to show the total number of players
  const showTotal = () => {
    setShowPlayersList(false);
    setShowTotalPlayers(true);
  };

  return (
    <div className='container'>
      <div>
        <h1>Raffle Winner For ₱100,000,000</h1>
        <label>TRY YOUR LUCK NOW</label><br />
        <label>Enter your name:</label><br /><br />
        <input
          type="text"
          value={playerName}
          onChange={(e) => setPlayerName(e.target.value)}
          placeholder="Enter player name"
        />
        <button onClick={addPlayer}>Add Player</button>
        <br />
        {showPlayersList && (
          <div>
            <h2>Total players: {playersList.length}</h2>
            <ul>
              {playersList.map((player, index) => (
                <li key={index}>{player}</li>
              ))}
            </ul>
          </div>
        )}
        {showTotalPlayers && (
          <h2>Total players: {playersList.length}</h2>
        )}
        <button onClick={showPlayers}>Show Players</button>
        <button onClick={showTotal}>Total Players</button>
        <button onClick={selectWinner}>The Winner Is?</button>
        <h2>Winner: {randomPlayer}</h2>
      </div>
      <style jsx>{`
        .container {
          margin-left: auto;
          margin-right: auto;
          width: fit-content;
          margin-top: 150pt;
        }

        h1 {
          font-family: Tahoma;
          font-weight: bold;
        }

        label {
          font-weight: bold;
        }
      `}</style>
    </div>
  );
}

export default App;
