#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include "stdio.h"
#include "stdlib.h"
#include "./source/Character.cpp"
#include "./source/InitialScreen.cpp"
#include "./source/ArenaScreen.cpp"
#include "./source/definitions.hpp"

using sf::Color;
using namespace std;

enum GameState
{
  Initial,
  Arena
};


int main()
{
  float fps = 30;
  sf::RenderWindow App(sf::VideoMode(WIDTH_SCREEN, HEIGHT_SCREEN), "Bomber Man!");

  InitialScreen initialScreen;
  ArenaScreen arenaScreen;
  Character character;

  GameState gameState = GameState::Initial;

  while (App.isOpen())
  {
    sf::Event event;
    while (App.pollEvent(event))
    {
      if (event.type == sf::Event::Closed)
        App.close();

      if (sf::Keyboard::isKeyPressed(sf::Keyboard::Escape))
        App.close();
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Return) && gameState == GameState::Initial)
      initialScreen.initGame();

    switch (gameState)
    {
    case GameState::Initial:
      initialScreen.draw(App);
      if (initialScreen.startGame)
        gameState = GameState::Arena;
      break;
    case GameState::Arena:
      arenaScreen.draw(App, character.getCurrentSprite());
      break;
    }

    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
      character.walkUp();

    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
      character.walkDown();

    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
      character.walkLeft();

    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
      character.walkRight();
    // else
    //   character.stop();

    sf::sleep(sf::seconds(1/fps));
  }
  return 0;
}