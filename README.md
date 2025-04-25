# odin-chess

## About

This command line chess game is my capstone project for The Odin Project's Ruby curriculum. The purpose of the project was to put my Ruby and general programming skills to the test, and it certainly did! Although the rules of chess are relatively simple and clearly defined, there are still plenty of challenging problems to solve (e.g. en passant captures, castling, draw conditions).

Overall, this was really enjoyable to work on and I'm happy with the end result. My goal wasn't to make a *blazingly fast* chess engine (it's written in Ruby), but I have done my best to ensure that it obeys all the rules of chess to the letter, even the obscure ones.

There are some things I would do differently if I ever decide to write another chess engine. For starters, I'd probably use C/C++ or maybe even Rust. Languages like that are better suited for computationally-heavy tasks. I would also like to try my hand at writing a half-way decent AI to play against. To that end, I would change my design to use [bitboards](https://www.chessprogramming.org/Bitboards) for the core data structures and algorithms, since they provide a huge performance boost when calculating possible moves.

## How to Play

Make sure you have Ruby installed on your system, and then simply `git clone` this repository and `bundle install` the necessary gems. Then, you can run `bundle exec ruby main.rb` to play the game.

You input your moves using coordinate-only algebraic notation, like so:

```
1) White: e2e4
```

Meaning, "move the piece on e2 (a pawn) to the e4 square." If you enter and invalid or illegal move, you'll be prompted again. You can also `quit` the game or ask for `help`.

Take turns until one player is checkmated, or you stumble into one of the many various (and tedious to program) draw conditions!

## Resources

[Chess Programming Wiki](https://www.chessprogramming.org/)

This website was very helpful when I had questions about the rules of chess, or needed a little inspiration in how to approach a thorny problem. You won't find any tutorials here (that would ruin the fun), but you will find a ton of helpful information about all things related to chess programming.
