#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include "./definitions.hpp"

using sf::Color;

class ArenaScreen
{
  sf::Sprite sprite;
  sf::Texture texture;
  sf::RectangleShape backgroundShape;
  Color backgroundColor;
  sf::Music battleMusic;

  float alphaBackground = 255;

  void updateAlphaScreen()
  {
    if (battleMusic.getStatus() != sf::SoundSource::Status::Playing)
    {
      battleMusic.play();
      battleMusic.setLoop(true);
    }

    if (alphaBackground > 0)
      alphaBackground -= 5;
    else if (alphaBackground <= 0)
      screenLoaded = true;

    backgroundColor.a = alphaBackground;
    backgroundShape.setFillColor(backgroundColor);
  }

public:
  ArenaScreen()
  {
    if (texture.loadFromFile("textures/arena.jpg"))
      sprite.setTexture(texture);

    battleMusic.openFromFile("sounds/battle_music.ogg");

    backgroundColor = Color::Black;
    backgroundColor.a = alphaBackground;
    backgroundShape.setSize(sf::Vector2f(WIDTH_SCREEN, HEIGHT_SCREEN));
  }

  bool screenLoaded = false;

  void draw(sf::RenderWindow &window, sf::Sprite spriteChar)
  {
    if (!screenLoaded)
      updateAlphaScreen();

    window.clear();
    window.draw(sprite);
    window.draw(spriteChar);
    window.draw(backgroundShape);

    window.display();
  }
};
