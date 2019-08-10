# chess-studies - skiminki's studies of chess games

## Instructive computer chess games

This is a study of instructive computer chess games.

[Everything in a book format (PDF)](instructive-compchess/instructive-compchess-games.pdf)

### Individual games

TCEC Season 15

- Stockfish vs Leela Superfinal Game 12
  [[Analysis (PDF)](instructive-compchess/tcec-s15-sufi-g12.pdf)] ---
  TCEC archive [[link](https://cd.tcecbeta.club/archive.html?season=15&div=sf&game=12)]
- Bonus: Bluefish vs Leela Jhorthos Game 2
  [[Analysis (PDF)](instructive-compchess/tcec-s15-bonus-g2.pdf)] ---
  TCEC archive [[link](https://cd.tcecbeta.club/archive.html?season=bonus&div=fun_bonus&game=2)]

TCEC Season 16

- League 2 round 23.1: Stoofvlees II a11 – chess22k
  [[Analysis (PDF)](instructive-compchess/tcec-s16-l2-r23-1.pdf)] ---
  TCEC archive [[link](https://cd.tcecbeta.club/archive.html?season=16&div=l2&game=177)]

## Building from sources

### Prerequisites:
- Recent enough TeX Live distribution
- GNU Make
- Basic shell tools such as md5sum, find, grep, and sed.

### Building:

At the top level:

`make` (serial build) or `make -j` (parallel build)

You can also build individual studies.

For additional targets, see `make help`
