import { App as CapacitorApp } from '@capacitor/app';
import { AnimatePresence, motion } from 'framer-motion';
import { useEffect, useMemo, useRef, useState } from 'react';
import type { Song } from './songs';
import { SONGS } from './songs';

type PlayMode = 'normal' | 'shuffle-forever' | 'single-forever';

type ShortcutAction = 'shuffle' | 'repeat' | 'play';

const getRandomSong = (songs: Song[], excludeId?: number): Song => {
  const filtered = songs.filter((song) => song.id !== excludeId);
  return filtered[Math.floor(Math.random() * filtered.length)] ?? songs[0];
};

const getActionFromUrl = (url: string): ShortcutAction | null => {
  if (url.startsWith('orebeats://shuffle')) return 'shuffle';
  if (url.startsWith('orebeats://repeat')) return 'repeat';
  if (url.startsWith('orebeats://play')) return 'play';
  return null;
};

export function App() {
  const audioRef = useRef<HTMLAudioElement>(new Audio(SONGS[0].url));
  const [isPlaying, setIsPlaying] = useState(false);
  const [selectedSong, setSelectedSong] = useState<Song>(SONGS[0]);
  const [started, setStarted] = useState(false);
  const [showSettings, setShowSettings] = useState(false);
  const [playMode, setPlayMode] = useState<PlayMode>('normal');
  const [crossfadeMs, setCrossfadeMs] = useState(0);
  const [showDebugOverlay, setShowDebugOverlay] = useState(false);

  const currentAudio = audioRef.current;

  const modeDescription = useMemo(
    () => ({
      normal: 'Play selected tracks normally.',
      'shuffle-forever': 'Endless random Minecraft songs.',
      'single-forever': 'Repeat the same song forever.'
    }[playMode]),
    [playMode]
  );

  const playSong = async (song: Song) => {
    setSelectedSong(song);
    const nextAudio = audioRef.current;
    if (crossfadeMs > 0 && isPlaying) {
      nextAudio.volume = 0;
      nextAudio.src = song.url;
      await nextAudio.play();
      const step = 50;
      const increment = step / crossfadeMs;
      const timer = window.setInterval(() => {
        nextAudio.volume = Math.min(1, nextAudio.volume + increment);
        if (nextAudio.volume >= 1) {
          window.clearInterval(timer);
        }
      }, step);
    } else {
      nextAudio.src = song.url;
      await nextAudio.play();
    }
    setIsPlaying(true);
  };

  const togglePlay = async () => {
    if (!isPlaying) {
      await currentAudio.play();
      setIsPlaying(true);
      return;
    }
    currentAudio.pause();
    setIsPlaying(false);
  };

  const nextTrack = async () => {
    if (playMode === 'single-forever') {
      await playSong(selectedSong);
      return;
    }

    if (playMode === 'shuffle-forever') {
      await playSong(getRandomSong(SONGS, selectedSong.id));
      return;
    }

    const nextIdx = (SONGS.findIndex((song) => song.id === selectedSong.id) + 1) % SONGS.length;
    await playSong(SONGS[nextIdx]);
  };

  const runShortcutAction = async (action: ShortcutAction) => {
    setStarted(true);
    if (action === 'shuffle') {
      setPlayMode('shuffle-forever');
      await playSong(getRandomSong(SONGS));
      return;
    }
    if (action === 'repeat') {
      setPlayMode('single-forever');
      await playSong(selectedSong);
      return;
    }
    await playSong(selectedSong);
  };

  useEffect(() => {
    currentAudio.onended = () => {
      void nextTrack();
    };
  }, [currentAudio, nextTrack]);

  useEffect(() => {
    let removeListener: (() => void) | undefined;

    const setupListener = async () => {
      const listener = await CapacitorApp.addListener('appUrlOpen', (event) => {
        const action = getActionFromUrl(event.url);
        if (action) {
          void runShortcutAction(action);
        }
      });
      removeListener = () => {
        void listener.remove();
      };
    };

    void setupListener();

    return () => {
      removeListener?.();
    };
  }, [selectedSong]);

  const launchPlayer = async () => {
    setStarted(true);
    await playSong(selectedSong);
  };

  return (
    <main className="ore-shell">
      <AnimatePresence mode="wait">
        {!started ? (
          <motion.section
            key="start"
            className="ore-start"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
          >
            <h1>Ore Beats</h1>
            <p>Modern iOS-focused Minecraft music player with smooth visuals and transitions.</p>
            <button className="ore-button" onClick={() => void launchPlayer()}>Enter Player</button>
            <p className="ore-disclaimer">
              Copyright disclaimer: Minecraft and related assets are trademarks of Mojang Studios. This app streams
              publicly available tracks for fan-use demonstration only.
            </p>
          </motion.section>
        ) : (
          <motion.section
            key="player"
            className="ore-player"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
          >
            <header>
              <h2>Now Playing</h2>
              <button className="ore-chip" onClick={() => setShowSettings(!showSettings)}>Settings</button>
            </header>

            <div className="ore-card">
              <p className="ore-label">Track</p>
              <h3>{selectedSong.title}</h3>
              <p className="ore-subtle">Mode: {modeDescription}</p>
              <div className="ore-controls">
                <button className="ore-button" onClick={() => void togglePlay()}>{isPlaying ? 'Pause' : 'Play'}</button>
                <button className="ore-button secondary" onClick={() => void nextTrack()}>Next</button>
              </div>
            </div>

            <section className="ore-list" aria-label="Song picker">
              {SONGS.map((song) => (
                <button
                  key={song.id}
                  className={`ore-song ${song.id === selectedSong.id ? 'active' : ''}`}
                  onClick={() => void playSong(song)}
                >
                  {song.id}. {song.title}
                </button>
              ))}
            </section>

            {showSettings && (
              <section className="ore-settings">
                <h3>Settings</h3>
                <label>
                  Play behavior
                  <select value={playMode} onChange={(event) => setPlayMode(event.target.value as PlayMode)}>
                    <option value="normal">Normal</option>
                    <option value="shuffle-forever">Auto-play forever (random)</option>
                    <option value="single-forever">Forever play (same song)</option>
                  </select>
                </label>
                <label>
                  Crossfade (ms)
                  <input
                    type="range"
                    min={0}
                    max={4000}
                    step={200}
                    value={crossfadeMs}
                    onChange={(event) => setCrossfadeMs(Number(event.target.value))}
                  />
                  <span>{crossfadeMs} ms</span>
                </label>

                <h4>Developer options</h4>
                <label className="ore-toggle">
                  <input
                    type="checkbox"
                    checked={showDebugOverlay}
                    onChange={(event) => setShowDebugOverlay(event.target.checked)}
                  />
                  Show debug overlay
                </label>
                <div className="ore-shortcuts">
                  <p>Shortcuts compatibility</p>
                  <p>Use iOS Shortcuts with URL actions:</p>
                  <code>orebeats://play</code>
                  <code>orebeats://shuffle</code>
                  <code>orebeats://repeat</code>
                  <div className="ore-controls">
                    <button className="ore-chip" onClick={() => void runShortcutAction('play')}>Test play</button>
                    <button className="ore-chip" onClick={() => void runShortcutAction('shuffle')}>Test shuffle</button>
                    <button className="ore-chip" onClick={() => void runShortcutAction('repeat')}>Test repeat</button>
                  </div>
                </div>
              </section>
            )}

            {showDebugOverlay && (
              <aside className="ore-debug">
                <p>Developer Overlay</p>
                <p>Track ID: {selectedSong.id}</p>
                <p>Playing: {String(isPlaying)}</p>
                <p>Mode: {playMode}</p>
              </aside>
            )}
          </motion.section>
        )}
      </AnimatePresence>
    </main>
  );
}
